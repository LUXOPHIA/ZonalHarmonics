﻿# LUX.SphericalHarmonics
Spherical Harmonics Library for Delphi.

## ■ ルジャンドル陪関数
[ルジャンドル陪関数](https://ja.wikipedia.org/wiki/%E3%83%AB%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%89%E3%83%AB%E5%A4%9A%E9%A0%85%E5%BC%8F#%E3%83%AB%E3%82%B8%E3%83%A3%E3%83%B3%E3%83%89%E3%83%AB%E9%99%AA%E5%A4%9A%E9%A0%85%E5%BC%8F)([Associated Legendre polynomials](https://en.wikipedia.org/wiki/Associated_Legendre_polynomials))は、ルジャンドル陪微分方程式([Associated Legendre Differential Equation](https://mathworld.wolfram.com/AssociatedLegendreDifferentialEquation.html)):
```math
\left(1-x^2\right)\,\frac{d^2}{dx^2}\,P_n^m(x)-2x\,\frac{d}{dx}\,P_n^m(x)+\biggl[n
\left(n+1\right)-\frac{m^2}{1-x^2}\biggr]P_n^m(x)=0
```
の $\[-1,+1\]$ における解であり、次式のように定義される。
```math
\begin{aligned}
P_{n}^{m}(x)
&= (-1)^{m} (1 - x^2)^{m/2} \frac{d^m}{dx^m} P_{n}(x)\\
&= \frac{(-1)^{m}}{2^{n} n!} (1 - x^2)^{m/2} \frac{d^{n + m}}{dx^{n + m}} (x^2 - 1)^{n}
\end{aligned}
```

### ◆ 低次の多項式
```math
x = \cos\theta, \quad s = \sqrt{1-x^2} = \sin \theta
```

#### ▼ $n = 0$
```math
\begin{aligned}
P_0^0(x) &= 1
\end{aligned}
```

#### ▼ $n = 1$
```math
\begin{aligned}
P_1^0(x) &= x \\
P_1^1(x) &= -s
\end{aligned}
```

#### ▼ $n = 2$
```math
\begin{aligned}
P_2^0(x) &= \frac{1}{2}\,(3x^2 - 1)\\
P_2^1(x) &= -3\,x\,s\\
P_2^2(x) &= 3\,s^2
\end{aligned}
```

#### ▼ $n = 3$
```math
\begin{aligned}
P_3^0(x) &= \frac{1}{2}\,x\,(5x^2 - 3)\\
P_3^1(x) &= -\frac{3}{2}\,(5x^2 - 1)\,s\\
P_3^2(x) &= 15\,x\,s^2\\
P_3^3(x) &= -15\,s^3
\end{aligned}
```

#### ▼ $n = 4$
```math
\begin{aligned}
P_4^0(x) &= \frac{1}{8}\,(35x^4 - 30x^2 + 3)\\
P_4^1(x) &= -\frac{5}{2}\,s\,(7x^3 - 3x)\\
P_4^2(x) &= \frac{15}{2}\,s^2\,(7x^2 - 1)\\
P_4^3(x) &= -105\,x\,s^3\\
P_4^4(x) &= 105\,s^4
\end{aligned}
```

#### ▼ $n = 5$
```math
\begin{aligned}
P_5^0(x) &= \frac{1}{8}\,x\,(63x^4 - 70x^2 + 15)\\
P_5^1(x) &= -\frac{15}{8}\,s\,(21x^4 - 14x^2 + 1)\\
P_5^2(x) &= \frac{105}{2}\,x\,s^2\,(3x^2 - 1)\\
P_5^3(x) &= -\frac{105}{2}\,s^3\,(9x^2 - 1)\\
P_5^4(x) &= 945\,x\,s^4\\
P_5^5(x) &= -945\,s^5
\end{aligned}
```

#### ▼ $n = 6$
```math
\begin{aligned}
P_6^0(x) &= \frac{1}{16}\,(231x^6 - 315x^4 + 105x^2 - 5)\\
P_6^1(x) &= -\frac{21}{8}\,x\,s\,(33x^4 - 30x^2 + 5)\\
P_6^2(x) &= \frac{105}{8}\,s^2\,(33x^4 - 18x^2 + 1)\\
P_6^3(x) &= -\frac{315}{2}\,x\,s^3\,(11x^2 - 3)\\
P_6^4(x) &= \frac{945}{2}\,s^4\,(11x^2 - 1)\\
P_6^5(x) &= -10395\,x\,s^5\\
P_6^6(x) &= 10395\,s^6
\end{aligned}
```

#### ▼ $n = 7$
```math
\begin{aligned}
P_7^0(x) &= \frac{1}{16}\,x\,(429x^6 - 693x^4 + 315x^2 - 35)\\
P_7^1(x) &= -\frac{7}{16}\,s\,(429x^6 - 495x^4 + 135x^2 - 5)\\
P_7^2(x) &= \frac{63}{8}\,x\,s^2\,(143x^4 - 110x^2 + 15)\\
P_7^3(x) &= -\frac{315}{8}\,s^3\,(143x^4 - 66x^2 + 3)\\
P_7^4(x) &= \frac{3465}{2}\,x\,s^4\,(13x^2 - 3)\\
P_7^5(x) &= -\frac{10395}{2}\,s^5\,(13x^2 - 1)\\
P_7^6(x) &= 135135\,x\,s^6\\
P_7^7(x) &= -135135\,s^7
\end{aligned}
```

#### ▼ $n = 8$
```math
\begin{aligned}
P_8^0(x) &= \frac{1}{128}\,(6435x^8 - 12012x^6 + 6930x^4 - 1260x^2 + 35)\\
P_8^1(x) &= -\frac{9}{16}\,x\,s\,(715x^6 - 1001x^4 + 385x^2 - 35)\\
P_8^2(x) &= \frac{315}{16}\,s^2\,(143x^6 - 143x^4 + 33x^2 - 1)\\
P_8^3(x) &= -\frac{3465}{8}\,x\,s^3\,(39x^4 - 26x^2 + 3)\\
P_8^4(x) &= \frac{10395}{8}\,s^4\,(65x^4 - 26x^2 + 1)\\
P_8^5(x) &= -\frac{135135}{2}\,x\,s^5\,(5x^2 - 1)\\
P_8^6(x) &= \frac{135135}{2}\,s^6\,(15x^2 - 1)\\
P_8^7(x) &= -2027025\,x\,s^7\\
P_8^8(x) &= 2027025\,s^8
\end{aligned}
```

### ◆ 漸化式

|  |  | Recurrence Relation |
|:----:|:----:|:----|
| ![](--------/Associated%20Legendre%20polynomials/Symbol_EE.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_EE_ON.png) | $`\begin{aligned} P_n^m(x) &= \dfrac{(2m)!}{2^mm!}\displaystyle\sum_{i=0}^{m/2}(-1)^i\frac{\frac{m}{2}!}{i!\Bigl(\frac{m}{2}-i\Bigr)!}\,x^{2i}\,\\ &= +(2m-1)!!\,(1-x^2)^{\frac{m}{2}}, \quad n=m\;\text{:even} \end{aligned}`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_EO.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_EO_ON.png) | $`\begin{aligned} P_n^m(x) &= -\dfrac{(2m)!}{2^mm!}\Bigl(\sqrt{1 - x^2}\Bigr)^{m}\,\\ &= -(2m-1)!!\,(1-x^2)^{\frac{m}{2}}, \quad n=m\;\text{:odd} \end{aligned}`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_ED.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_ED_ON.png) | $`P_n^m(x) = (2m+1)\,x\,P_{n-1}^m(x)\,, \quad n = m + 1`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_EU.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_EU_ON.png) | $`P_n^m(x) = \dfrac{1}{(2m+1)x}P_{n+1}^m(x)\,, \quad n = m`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_RR.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_RR_ON.png) | $`P_n^m(x) = -\dfrac{2(m-1)x}{\sqrt{1-x^2}}\,P_{n}^{m-1}(x)-(n+m-1)(n-m+2)\,P_n^{m-2}(x)`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_LR.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_LR_ON.png) | $`P_n^m(x) = -\dfrac{\sqrt{1-x^2}}{2mx}\Bigl\lbrace P_n^{m+1}(x)+(n+m)(n-m+1)\,P_{n}^{m-1}(x)\Bigr\rbrace`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_LL.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_LL_ON.png) | $`P_n^m(x) = -\dfrac{1}{(n+m+1)(n-m)}\Biggl\lbrace \dfrac{2(m+1)x}{\sqrt{1-x^2}}\,P_n^{m+1}(x)+P_n^{m+2}(x)\Biggr\rbrace`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_DD.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_DD_ON.png) | $`P_n^m(x) = \dfrac{1}{n-m}\Bigl\lbrace (2n-1)\,x\,P_{n-1}^m(x)-(n+m-1)\,P_{n-2}^m(x)\Bigr\rbrace`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_UD.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_UD_ON.png) | $`P_n^m(x) = \dfrac{1}{(2n+1)\,x}\Bigl\lbrace (n+m)\,P_{n-1}^m(x)+(n-m+1)\,P_{n+1}^m(x)\Bigr\rbrace`$ |
| ![](--------/Associated%20Legendre%20polynomials/Symbol_UU.png) | ![](--------/Associated%20Legendre%20polynomials/Icon_UU_ON.png) | $`P_n^m(x) = \dfrac{1}{n+m+1}\Bigl\lbrace (2n+3)\,x\,P_{n+1}^m(x)-(n-m+2)\,P_{n+2}^m(x)\Bigr\rbrace`$ |
