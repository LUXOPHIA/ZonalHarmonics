# ZonalHarmonics

[English](README.md) | [日本語](ja/README.md)

A FireMonkey (Delphi / Object Pascal) application — currently an early-stage scaffold under development — for computing and visualizing **zonal harmonics** — the rotationally symmetric $`m = 0`$ subset of the spherical harmonics. The numerical core is provided by the bundled [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) library.

<!-- TODO: screenshot -->

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：The foundation math library of LUXOPHIA.
* [**LUX.FMX.Graphics.D3**](https://github.com/LUXOPHIA/LUX.FMX.Graphics.D3) ：Helper classes for FireMonkey 3D graphics.
* [**LUX.Sphere**](https://github.com/LUXOPHIA/LUX.Sphere) ：A geometry library for the spheres S² and S³.
* [**LUX.SphericalHarmonics**](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ：A spherical harmonics and associated Legendre function library.

## 1. Overview

* **GUI application** (`ZonalHarmonics.dpr`): a FireMonkey window titled *Zonal Harmonics* consisting of a `TViewport3D`-based 3D viewer (`TViewerFrame`) and a **RUN** button.
* **Mathematical engine**: the [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) subtree, which evaluates Associated Legendre Functions (ALFs) in three normalizations (plain / normalized / fully normalized) via explicit polynomials (degree $`n \le 8`$) and recurrence relations, and builds complex and real spherical harmonics on top of them.
* **Automatic differentiation**: every library class has a `*.Diff` twin operating on dual numbers (`TdDouble`), which the 3D mesh component `TSPHarmonics3D` uses to obtain analytic surface normals.
* **Status**: the application shell (`TForm1`, `TViewerFrame`, `Core.pas`) is currently a minimal scaffold — its event handlers are empty and all mathematical functionality resides in the library subtrees under `_LIBRARY/`.

## 2. Mathematical Background

### 2.1 Real Spherical Harmonics

The library evaluates the real spherical harmonics [2] from fully normalized Associated Legendre Functions $`\overline{P}_n^m`$ (class `TRSPHarmonics<TFNALFs_>`):

```math
\overline{Y}_n^m(\theta,\phi)
= \frac{1}{\sqrt{4\pi}}\,
\begin{cases}
\overline{P}_n^{|m|}(\cos\theta)\,\sin(|m|\,\phi) & m < 0\\[2pt]
\overline{P}_n^{0}(\cos\theta) & m = 0\\[2pt]
\overline{P}_n^{m}(\cos\theta)\,\cos(m\,\phi) & m > 0
\end{cases}
\tag{1}
```

where $`\theta`$ is the polar angle (`AngleY`, entering only through $`x = \cos\theta`$) and $`\phi`$ the azimuth (`AngleX`).

### 2.2 Zonal Harmonics

The **zonal harmonics** [1] are the $`m = 0`$ column of (1). Since the azimuthal factor degenerates to a constant, they reduce to Legendre polynomials $`P_n`$ [3]:

```math
Z_n(\theta) \;=\; Y_n^0(\theta,\phi) \;=\; \sqrt{\frac{2n+1}{4\pi}}\;P_n(\cos\theta),
\qquad
P_n(x) \;=\; \frac{1}{2^n\,n!}\,\frac{d^n}{dx^n}\left(x^2-1\right)^n .
\tag{2}
```

Being independent of $`\phi`$, $`Z_n`$ is invariant under every rotation about the polar axis: each zonal harmonic is a circularly symmetric band function on the sphere. In terms of the library's normalizations this $`m=0`$ branch is exactly

```math
Y_n^0 \;=\; \frac{\tilde{P}_n^0(\cos\theta)}{\sqrt{2\pi}}
\;=\; \frac{\overline{P}_n^0(\cos\theta)}{\sqrt{4\pi}} ,
\tag{3}
```

which is the value returned by `TSPHarmonics<TNALFs_>.GetRSHs` and `TRSPHarmonics<TFNALFs_>.GetRSHs` for $`m = 0`$.

### 2.3 Rotation of Zonal Harmonics

Zonal harmonics rotate far more cheaply than general spherical harmonics. By the addition theorem [2],

```math
P_n(\hat{\omega}\cdot\hat{s})
\;=\; \frac{4\pi}{2n+1}\sum_{m=-n}^{n} \overline{Y}_n^m(\hat{\omega})\;\overline{Y}_n^m(\hat{s}),
\tag{4}
```

so a circularly symmetric function $`f(\theta) = \sum_n f_n\,Z_n(\theta)`$, re-oriented so that its symmetry axis points along an arbitrary direction $`\hat{\omega}`$, has the spherical-harmonic coefficients

```math
\hat{f}_n^m \;=\; \sqrt{\frac{4\pi}{2n+1}}\;f_n\;\overline{Y}_n^m(\hat{\omega}) .
\tag{5}
```

Equation (5) — the standard ZH rotation/projection identity [4][5] — replaces the dense $`(2n+1)\times(2n+1)`$ rotation matrices of general SH by a single evaluation of the basis at $`\hat{\omega}`$, and is the property this project is built around.

### 2.4 Visualization Mapping

The mesh component `TSPHarmonics3D` (method `AngToPos`) plots a harmonic as the polar surface

```math
r(\theta,\phi) \;=\; \sqrt{4\pi}\,\bigl|\,\overline{Y}_n^m(\theta,\phi)\,\bigr|\;R,
\qquad
(x,\,y,\,z) \;=\; \bigl(r\sin\theta\cos\phi,\;\; r\cos\theta,\;\; r\sin\theta\sin\phi\bigr),
\tag{6}
```

with $`R`$ = `Radius` and the $`y`$-axis as the polar axis. Vertex normals are obtained analytically from the dual-number (`*.Diff`) evaluation rather than by finite differences.

## 3. Architecture

```
[ Application — control containment ]

・TForm1                                              ･･･ ( Main.pas / .fmx )
  ┣・Panel1 :TPanel
  ┃  ┗・Button1 :TButton "RUN"
  ┗・ViewerFrame1 :TViewerFrame                      ･･･ ( Viewer.pas / .fmx )
     ┗・Viewport3D1 :TViewport3D

[ LUX.SphericalHarmonics — ALFs inheritance ]

・TALFs                                               ･･･ ( LUX.ALFs.* )
  ┗・TCoreALFs
     ┣・TMapALFs
     ┃  ┗・TALFsTerm3
     ┗・TALFsN8                                      ･･･ ( LUX.ALFs.N8 )

[ LUX.SphericalHarmonics — normalized ALFs ]

・ALFs, incl. Term3 / Term4
  ┣・TNALFs                                          ･･･ ( LUX.NALFs.* )
  ┗・TFNALFs                                         ･･･ ( LUX.FNALFs.* )

[ LUX.SphericalHarmonics — spherical harmonics inheritance ]

・TSPHarmonics                                        ･･･ ( LUX.SH )
  ┣・TSPHarmonics<TNALFs_>
  ┗・TRSPHarmonics<TFNALFs_>

[ LUX.SphericalHarmonics — dual-number twins ]

・TdSPHarmonics ...                                   ･･･ ( LUX.SH.Diff )
  ┗・dual-number twins of the classes above

[ LUX.SphericalHarmonics — surface mesh ]

・TF3DShaper                                          ･･･ (LUX.FMX.Graphics.D3)
  ┗・TSPHarmonics3D                                  ･･･ mesh of surface (6)

[ Usage — the application renders with the library ]

・TForm1 / ViewerFrame1 / Viewport3D1                 ･･･ renders via SH library
  ┗・TSPHarmonics3D / TF3DShaper                     ･･･ mesh of surface (6)
     ┗・TSPHarmonics / TRSPHarmonics / TdSPHarmonics ･･･ used by the mesh
        ┗・TNALFs / TFNALFs
           ┗・TALFs family
```

```
・ZonalHarmonics/
  ┣・ZonalHarmonics.dpr / .dproj ･･･ FireMonkey application project
  ┣・Main.pas / Main.fmx         ･･･ TForm1: main window (RUN + viewer)
  ┣・Viewer.pas / Viewer.fmx     ･･･ TViewerFrame: hosts the TViewport3D
  ┣・Core.pas                    ･･･ application model unit (placeholder)
  ┗・_LIBRARY/LUXOPHIA/
     ┣・LUX/                     ･･･ base math: vectors, matrices, complex/dual
     ┣・LUX.Sphere/              ･･･ spherical geometry (S2/S3 curves, grids)
     ┣・LUX.FMX.Graphics.D3/     ･･･ FMX 3D helper classes (TF3DShaper)
     ┗・LUX.SphericalHarmonics/  ･･･ ALFs / spherical-harmonics library
```

`_LIBRARY/` contains read-only Git-subtree snapshots of the upstream libraries; see [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) for the library's own documentation.

## 4. Usage / Controls

| Control | Type | Function |
|:---|:---|:---|
| **RUN** | `TButton` | Starts the computation (`Button1Click`; handler is currently an empty stub) |
| Viewer | `TViewport3D` | 3D display surface (black background) for the harmonic mesh |

## 5. Building

* **IDE**: Embarcadero RAD Studio / Delphi with FireMonkey (the project file uses format version 20.4).
* **Steps**: open `ZonalHarmonics.dproj`, choose a target platform, then *Build* / *Run*.
* **Target platforms** (from `.dproj`): Win32 and Win64.

## 6. References

1. [*Zonal spherical harmonics*](https://en.wikipedia.org/wiki/Zonal_spherical_harmonics), Wikipedia.
2. [*Spherical harmonics*](https://en.wikipedia.org/wiki/Spherical_harmonics), Wikipedia.
3. [*Legendre polynomials*](https://en.wikipedia.org/wiki/Legendre_polynomials), Wikipedia.
4. P.-P. Sloan, [*Stupid Spherical Harmonics (SH) Tricks*](http://www.ppsloan.org/publications/), GDC 2008.
5. R. Green, [*Spherical Harmonic Lighting: The Gritty Details*](https://www.cse.chalmers.se/~uffe/xjobb/Readings/GlobalIllumination/Spherical%20Harmonic%20Lighting%20-%20the%20gritty%20details.pdf), GDC 2003.

## 💖 [Embarcadero](https://www.embarcadero.com/) [**Delphi**](https://www.embarcadero.com/products/delphi)
Integrated Development Environment (IDE) for Creating Native Cross-Platform Apps.
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/products/delphi/starter)
