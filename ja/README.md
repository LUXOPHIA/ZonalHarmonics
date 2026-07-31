# ZonalHarmonics

[English](../README.md) | [日本語](README.md)

**帯球調和関数（Zonal Harmonics）** — 球面調和関数のうち回転対称な $`m = 0`$ 成分 — を計算・可視化する FireMonkey（Delphi / Object Pascal）アプリケーション（現状は開発初期段階の骨組み）。数値計算の中核は同梱の [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ライブラリが担います。

<!-- TODO: screenshot -->

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：LUXOPHIA の基盤数学ライブラリ。
* [**LUX.FMX.Graphics.D3**](https://github.com/LUXOPHIA/LUX.FMX.Graphics.D3) ：FireMonkey 3D の補助クラスライブラリ。
* [**LUX.Sphere**](https://github.com/LUXOPHIA/LUX.Sphere) ：球面 S²/S³ の幾何ライブラリ。
* [**LUX.SphericalHarmonics**](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ：球面調和関数・ルジャンドル陪関数ライブラリ。

## 1. 概要

* **GUI アプリケーション**（`ZonalHarmonics.dpr`）：*Zonal Harmonics* と題された FireMonkey ウィンドウで、`TViewport3D` ベースの 3D ビューア（`TViewerFrame`）と **RUN** ボタンから構成されます。
* **数学エンジン**：[LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) サブツリー。ルジャンドル陪関数（ALFs）を 3 種類の正規化（無正規化／正規化／完全正規化）で、明示的多項式（次数 $`n \le 8`$）と漸化式により評価し、その上に複素および実数の球面調和関数を構築します。
* **自動微分**：全ライブラリクラスに二重数（`TdDouble`）で動作する `*.Diff` 版があり、3D メッシュコンポーネント `TSPHarmonics3D` はこれを用いて解析的な面法線を取得します。
* **状態**：アプリケーション本体（`TForm1`・`TViewerFrame`・`Core.pas`）は現状最小限の骨組みであり、イベントハンドラは空で、数学的機能はすべて `_LIBRARY/` 以下のライブラリサブツリーに存在します。

## 2. 数学的背景

### 2.1 実球面調和関数

本ライブラリは、完全正規化ルジャンドル陪関数 $`\overline{P}_n^m`$ から実球面調和関数 [2] を評価します（クラス `TRSPHarmonics<TFNALFs_>`）：

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

ここで $`\theta`$ は極角（`AngleY`。$`x = \cos\theta`$ を通じてのみ寄与）、$`\phi`$ は方位角（`AngleX`）です。

### 2.2 帯球調和関数

**帯球調和関数** [1] は式 (1) の $`m = 0`$ の列です。方位角因子が定数に退化するため、ルジャンドル多項式 $`P_n`$ [3] に帰着します：

```math
Z_n(\theta) \;=\; Y_n^0(\theta,\phi) \;=\; \sqrt{\frac{2n+1}{4\pi}}\;P_n(\cos\theta),
\qquad
P_n(x) \;=\; \frac{1}{2^n\,n!}\,\frac{d^n}{dx^n}\left(x^2-1\right)^n .
\tag{2}
```

$`\phi`$ に依存しないため、$`Z_n`$ は極軸まわりの任意の回転に対して不変であり、各帯球調和関数は球面上の回転対称な帯状関数となります。本ライブラリの正規化で表すと、この $`m=0`$ 成分はちょうど

```math
Y_n^0 \;=\; \frac{\tilde{P}_n^0(\cos\theta)}{\sqrt{2\pi}}
\;=\; \frac{\overline{P}_n^0(\cos\theta)}{\sqrt{4\pi}} ,
\tag{3}
```

であり、これは `TSPHarmonics<TNALFs_>.GetRSHs` および `TRSPHarmonics<TFNALFs_>.GetRSHs` が $`m = 0`$ で返す値そのものです。

### 2.3 帯球調和関数の回転

帯球調和関数は一般の球面調和関数よりはるかに低コストで回転できます。加法定理 [2] により、

```math
P_n(\hat{\omega}\cdot\hat{s})
\;=\; \frac{4\pi}{2n+1}\sum_{m=-n}^{n} \overline{Y}_n^m(\hat{\omega})\;\overline{Y}_n^m(\hat{s}),
\tag{4}
```

が成り立つので、回転対称な関数 $`f(\theta) = \sum_n f_n\,Z_n(\theta)`$ の対称軸を任意方向 $`\hat{\omega}`$ に向け直したときの球面調和係数は

```math
\hat{f}_n^m \;=\; \sqrt{\frac{4\pi}{2n+1}}\;f_n\;\overline{Y}_n^m(\hat{\omega}) .
\tag{5}
```

となります。式 (5) は標準的な ZH 回転／射影公式 [4][5] であり、一般の SH に必要な密な $`(2n+1)\times(2n+1)`$ 回転行列を、$`\hat{\omega}`$ における基底の一度の評価に置き換えます。本プロジェクトはこの性質を主題としています。

### 2.4 可視化写像

メッシュコンポーネント `TSPHarmonics3D`（メソッド `AngToPos`）は、調和関数を極座標曲面

```math
r(\theta,\phi) \;=\; \sqrt{4\pi}\,\bigl|\,\overline{Y}_n^m(\theta,\phi)\,\bigr|\;R,
\qquad
(x,\,y,\,z) \;=\; \bigl(r\sin\theta\cos\phi,\;\; r\cos\theta,\;\; r\sin\theta\sin\phi\bigr),
\tag{6}
```

として描画します。ここで $`R`$ = `Radius`、極軸は $`y`$ 軸です。頂点法線は有限差分ではなく二重数（`*.Diff`）評価により解析的に求められます。

## 3. アーキテクチャ

```
[ アプリケーション — コントロールの包含 ]

・TForm1                                              ･･･ ( Main.pas / .fmx )
  ┣・Panel1 :TPanel
  ┃  ┗・Button1 :TButton "RUN"
  ┗・ViewerFrame1 :TViewerFrame                      ･･･ ( Viewer.pas / .fmx )
     ┗・Viewport3D1 :TViewport3D

[ LUX.SphericalHarmonics — ALFs の継承 ]

・TALFs                                               ･･･ ( LUX.ALFs.* )
  ┗・TCoreALFs
     ┣・TMapALFs
     ┃  ┗・TALFsTerm3
     ┗・TALFsN8                                      ･･･ ( LUX.ALFs.N8 )

[ LUX.SphericalHarmonics — 正規化 ALFs ]

・ALFs（Term3 / Term4 を含む）
  ┣・TNALFs                                          ･･･ ( LUX.NALFs.* )
  ┗・TFNALFs                                         ･･･ ( LUX.FNALFs.* )

[ LUX.SphericalHarmonics — 球面調和関数の継承 ]

・TSPHarmonics                                        ･･･ ( LUX.SH )
  ┣・TSPHarmonics<TNALFs_>
  ┗・TRSPHarmonics<TFNALFs_>

[ LUX.SphericalHarmonics — 二重数（自動微分）版 ]

・TdSPHarmonics ...                                   ･･･ ( LUX.SH.Diff )
  ┗・上記クラスの二重数版

[ LUX.SphericalHarmonics — 曲面メッシュ ]

・TF3DShaper                                          ･･･ (LUX.FMX.Graphics.D3)
  ┗・TSPHarmonics3D                                  ･･･ 曲面 (6) のメッシュ

[ 使用関係 — アプリケーションはライブラリで描画する ]

・TForm1 / ViewerFrame1 / Viewport3D1                 ･･･ SH ライブラリで描画
  ┗・TSPHarmonics3D / TF3DShaper                     ･･･ 曲面 (6) のメッシュ
     ┗・TSPHarmonics / TRSPHarmonics / TdSPHarmonics ･･･ メッシュが使用
        ┗・TNALFs / TFNALFs
           ┗・TALFs 系
```

```
・ZonalHarmonics/
  ┣・ZonalHarmonics.dpr / .dproj ･･･ FireMonkey アプリケーションプロジェクト
  ┣・Main.pas / Main.fmx         ･･･ TForm1：メインウィンドウ（RUN＋ビューア）
  ┣・Viewer.pas / Viewer.fmx     ･･･ TViewerFrame：TViewport3D を保持
  ┣・Core.pas                    ･･･ アプリケーションモデル（プレースホルダ）
  ┗・_LIBRARY/LUXOPHIA/
     ┣・LUX/                     ･･･ 基礎数学：ベクトル・行列・複素数・二重数
     ┣・LUX.Sphere/              ･･･ 球面幾何（S2/S3 曲線・グリッド）
     ┣・LUX.FMX.Graphics.D3/     ･･･ FMX 3D 補助クラス（TF3DShaper）
     ┗・LUX.SphericalHarmonics/  ･･･ ALFs／球面調和関数ライブラリ（上図参照）
```

`_LIBRARY/` は上流ライブラリの読み取り専用 Git subtree スナップショットです。ライブラリ自体のドキュメントは [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) を参照してください。

## 4. 使い方／操作

| コントロール | 型 | 機能 |
|:---|:---|:---|
| **RUN** | `TButton` | 計算を開始（`Button1Click`。ハンドラは現状空のスタブ） |
| ビューア | `TViewport3D` | 調和関数メッシュの 3D 表示面（黒背景） |

## 5. ビルド

* **IDE**：Embarcadero RAD Studio / Delphi（FireMonkey。プロジェクトファイルはフォーマットバージョン 20.4）。
* **手順**：`ZonalHarmonics.dproj` を開き、ターゲットプラットフォームを選択して *Build* / *Run*。
* **ターゲットプラットフォーム**（`.dproj` より）：Win32 および Win64。

## 6. 参考文献

1. [*Zonal spherical harmonics*](https://en.wikipedia.org/wiki/Zonal_spherical_harmonics), Wikipedia.
2. [*Spherical harmonics*](https://en.wikipedia.org/wiki/Spherical_harmonics), Wikipedia.
3. [*Legendre polynomials*](https://en.wikipedia.org/wiki/Legendre_polynomials), Wikipedia.
4. P.-P. Sloan, [*Stupid Spherical Harmonics (SH) Tricks*](http://www.ppsloan.org/publications/), GDC 2008.
5. R. Green, [*Spherical Harmonic Lighting: The Gritty Details*](https://www.cse.chalmers.se/~uffe/xjobb/Readings/GlobalIllumination/Spherical%20Harmonic%20Lighting%20-%20the%20gritty%20details.pdf), GDC 2003.

## 💖 [Embarcadero](https://www.embarcadero.com/jp/) [**Delphi**](https://www.embarcadero.com/jp/products/delphi)
ネイティブなクロスプラットフォームアプリを開発するための統合開発環境（ＩＤＥ）。
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/jp/products/delphi/starter)
