---
title: MathJax 笔记
categories: 笔记
comments: true
mathjax: true
tags:
  - MathJax
abbrlink: 62603
date: 2018-02-28 21:58:56
---

MathJax 是一款运行在浏览器中的开源的数学符号渲染引擎，使用 MathJax 可以方便的在浏览器中显示数学公式，不需要使用图片。本文整理记录常用的用法，来作为 cheatsheet 。

<!--more-->

## 插入公式

- 行中公式表示：

```
$数学公式$
```

- 独立公式表示：

```
$$数学公式$$
```

## 方法大括号

### 方法一

```
$$
f(x)=\left\{
\begin{aligned}
x & = & \cos(t) \\
y & = & \sin(t) \\
z & = & \frac xy
\end{aligned}
\right.
$$
```

$$
f(x)=\left\\{
\begin{aligned}
x & = & \cos(t) \\\\
y & = & \sin(t) \\\\
z & = & \frac xy
\end{aligned}
\right.
$$

### 方法二

```
$$
F^{HLLC}=\left\{
\begin{array}{rcl}
F_L       &      & {0      <      S_L}\\
F^*_L     &      & {S_L \leq 0 < S_M}\\
F^*_R     &      & {S_M \leq 0 < S_R}\\
F_R       &      & {S_R \leq 0}
\end{array} \right. 
$$
```

$$
F^{HLLC}=\left\\{
\begin{array}{rcl}
F\_L       &      & {0      <      S\_L}\\\\
F^\*\_L     &      & {S\_L \leq 0 < S\_M}\\\\
F^\*\_R     &      & {S\_M \leq 0 < S\_R}\\\\
F\_R       &      & {S\_R \leq 0}
\end{array} \right. 
$$

### 方法三

```
$$
f(x)=
\begin{cases}
0& \text{x=0}\\
1& \text{x!=0}
\end{cases}
$$
```

$$
f(x)=
\begin{cases}
0& \text{x=0}\\\\
1& \text{x!=0}
\end{cases}
$$

## 上下标

`^`表示上标, `_`表示下标。如果上下标的内容多于一个字符，要用`{}`把这些内容括起来当成一个整体。上下标是可以嵌套的，也可以同时使用。

```
$x^{y^z}=(1+{\rm e}^x)^{-2xy^w}$
```

$x^{y^z}=(1+{\rm e}^x)^{-2xy^w}$

左右两边都有上下标，可以用`\sideset`命令。

```
$\sideset{^1_2}{^3_4}\bigotimes$
```

$\sideset{^1_2}{^3_4}\bigotimes$

```
$$\max_{k}$$
```

$$\max_{k}$$

```
$$\mathop{argmax}_{K}$$
```

$$\mathop{argmax}_{K}$$

## 括号和分隔符

要显示大号的括号或分隔符时，要用`\left`和`\right`命令。这样的话括号才会自适应大小。

```
$f(x,y,z) = 3y^2z \left( 3+\frac{7x+5}{1+y^2} \right)$
```

$f(x,y,z) = 3y^2z \left( 3+\frac{7x+5}{1+y^2} \right)$

`\left.`或`\right.`进行匹配而不显示本身。

```
$\left. \frac{\rm d u}{\rm d x} \right | _{x=0}$
```

$\left. \frac{\rm d u}{\rm d x} \right | \_{x=0}$

## 分数

```
$\frac{1}{3}$
```

$\frac{1}{3}$

```
$1 \over 3$
```

$1 \over 3$

## 开方

```
$\sqrt{2}$
$\sqrt[n]{3}$
```

$\sqrt{2}$
$\sqrt[n]{3}$

## 省略号

数学公式中常见的省略号有两种，`\ldots` 表示与文本底线对齐的省略号，`\cdots` 表示与文本中线对齐的省略号。

```
$f(x_1,x_2,\ldots,x_n) = x_1^2 + x_2^2 + \cdots + x_n^2$
```

$f(x\_1,x\_2,\ldots,x\_n) = x\_1^2 + x\_2^2 + \cdots + x\_n^2$

## 矢量

```
$\vec{a} \cdot \vec{b}=0$
```

$\vec{a} \cdot \vec{b}=0$

## 积分

```
$\int_0^1 x^2 {\rm d}x$
```

$\int_0^1 x^2 {\rm d}x$

## 极限运算

行间极限公式

```
$\lim\limits_{n \rightarrow +\infty} \frac{1}{n(n+1)}$
```

$\lim\limits\_{n \rightarrow +\infty} \frac{1}{n(n+1)}$

独立成行极限公式

```
$$\lim_{n \rightarrow +\infty} \frac{1}{n(n+1)}$$
```

$$\lim\_{n \rightarrow +\infty} \frac{1}{n(n+1)}$$

>在latex中输入极限，主要的一种形式是使用 `\lim` ，输出的就是极限的原样。 
如果在 \\$\*\*\*\*\*\\$ 环境中，使用上下标起不到作用，在 \\$\\$\*\*\*\*\*\*\\$\\$ 中使用下标，会使下标部分出现在 `limit` 之下。 
在文章中间，使用这种形式的极限，可以选择使用这种形式 `\lim\limits_{t \to \infty }{x(t)}` 。 
上下极限的输入 `textfriend` 里面直接就有。 
另外一点需要注意的是，极限的下标如果有多行的话，使用断行，有几种方法：可以使用 `array` 或者 `substack` 命令，也可以使用 `\stackrel{top}{bot}` 或者 `mathop` 命令.

## 累加、累乘运算

```
$\sum_{i=0}^n \frac{1}{i^2}$
$\prod_{i=0}^n \frac{1}{i^2}$
```

$\sum\_{i=0}^n \frac{1}{i^2}$
$\prod\_{i=0}^n \frac{1}{i^2}$

## 公式应用

```
$r = r_F+ \beta(r_M – r_F) + \epsilon$
```

$r = r\_F+ \beta(r\_M – r\_F) + \epsilon$

```
\begin{align}
\sqrt{37} & = \sqrt{\frac{73^2-1}{12^2}} \\
 & = \sqrt{\frac{73^2}{12^2}\cdot\frac{73^2-1}{73^2}} \\ 
 & = \sqrt{\frac{73^2}{12^2}}\sqrt{\frac{73^2-1}{73^2}} \\
 & = \frac{73}{12}\sqrt{1 - \frac{1}{73^2}} \\ 
 & \approx \frac{73}{12}\left(1 - \frac{1}{2\cdot73^2}\right)
\end{align}
```

\begin{align}
\sqrt{37} & = \sqrt{\frac{73^2-1}{12^2}} \\\\
 & = \sqrt{\frac{73^2}{12^2}\cdot\frac{73^2-1}{73^2}} \\\\
 & = \sqrt{\frac{73^2}{12^2}}\sqrt{\frac{73^2-1}{73^2}} \\\\
 & = \frac{73}{12}\sqrt{1 - \frac{1}{73^2}} \\\\
 & \approx \frac{73}{12}\left(1 - \frac{1}{2\cdot73^2}\right)
\end{align}

## 矩阵

```
$$
    \begin{matrix}
    1 & x & x^2 \\
    1 & y & y^2 \\
    1 & z & z^2 \\
    \end{matrix}
$$
```

$$
    \begin{matrix}
    1 & x & x^2 \\\\
    1 & y & y^2 \\\\
    1 & z & z^2 \\\\
    \end{matrix}
$$

### 括号

```
$$
    \begin{pmatrix}
    1 & x & x^2 \\
    1 & y & y^2 \\
    1 & z & z^2 \\
    \end{pmatrix}
$$
```

$$
    \begin{pmatrix}
    1 & x & x^2 \\\\
    1 & y & y^2 \\\\
    1 & z & z^2 \\\\
    \end{pmatrix}
$$

还有其他不同的括号，只需要把 `matrix` 替换即可。比如 `bmatrix` 代表 $\begin{bmatrix}1&2\\\\3&4\\\\ \end{bmatrix}$ ，`Bmatrix` 代表 $\begin{Bmatrix}1&2\\\\3&4\\\\ \end{Bmatrix}$ ，`vmatrix` 代表 $\begin{vmatrix}1&2\\\\3&4\\\\ \end{vmatrix}$ ，`Vmatrix` 代表 $\begin{Vmatrix}1&2\\\\3&4\\\\ \end{Vmatrix}$ 。

### 省略号

`\cdots` 代表 $\cdots$ ，`\ddots` 代表 $\ddots$ ，`\vdots` 代表 $\vdots$ 。

$$
\begin{pmatrix}
 1 & a\_1 & a\_1^2 & \cdots & a\_1^n \\\\
 1 & a\_2 & a\_2^2 & \cdots & a\_2^n \\\\
 \vdots  & \vdots& \vdots & \ddots & \vdots \\\\
 1 & a\_m & a\_m^2 & \cdots & a\_m^n    
 \end{pmatrix}
$$

### 增广矩阵

```
$$ \left[
\begin{array}{cc|c}
  1&2&3\\
  4&5&6
\end{array}
\right]
$$
```

$$ \left[
\begin{array}{cc|c}
  1&2&3\\\\
  4&5&6
\end{array}
\right]
$$

```
$$
  \begin{pmatrix}
    a & b\\
    c & d\\
  \hline
    1 & 0\\
    0 & 1
  \end{pmatrix}
$$
```

$$
  \begin{pmatrix}
    a & b\\\\
    c & d\\\\
  \hline
    1 & 0\\\\
    0 & 1
  \end{pmatrix}
$$

### 行间小矩阵

```
$\bigl( \begin{smallmatrix} a & b \\ c & d \end{smallmatrix} \bigr)$
```

$\bigl( \begin{smallmatrix} a & b \\\\ c & d \end{smallmatrix} \bigr)$

## 希腊字母

| 输入        | 输出 |
|-------------|---------------|
| \alpha      | $\alpha     $ |
| A           | $A          $ |
| \beta       | $\beta      $ |
| B           | $B          $ |
| \gamma      | $\gamma     $ |
| \Gamma      | $\Gamma     $ |
| \delta      | $\delta     $ |
| \Delta      | $\Delta     $ |
| \epsilon    | $\epsilon   $ |
| E           | $E          $ |
| \varepsilon | $\varepsilon$ |
| \zeta       | $\zeta      $ |
| Z           | $Z          $ |
| \eta        | $\eta       $ |
| H           | $H          $ |
| \theta      | $\theta     $ |
| \Theta      | $\Theta     $ |
| \vartheta   | $\vartheta  $ |
| \iota       | $\iota      $ |
| I           | $I          $ |
| \kappa      | $\kappa     $ |
| K           | $K          $ |
| \lambda     | $\lambda    $ |
| \Lambda     | $\Lambda    $ |
| \mu         | $\mu        $ |
| M           | $M          $ |
| \nu         | $\nu        $ |
| N           | $N          $ |
| \xi         | $\xi        $ |
| \Xi         | $\Xi        $ |
| o           | $o          $ |
| O           | $O          $ |
| \pi         | $\pi        $ |
| \Pi         | $\Pi        $ |
| \varpi      | $\varpi     $ |
| \rho        | $\rho       $ |
| P           | $P          $ |
| \varrho     | $\varrho    $ |
| \sigma      | $\sigma     $ |
| \Sigma      | $\Sigma     $ |
| \varsigma   | $\varsigma  $ |
| \tau        | $\tau       $ |
| T           | $T          $ |
| \upsilon    | $\upsilon   $ |
| \Upsilon    | $\Upsilon   $ |
| \phi        | $\phi       $ |
| \Phi        | $\Phi       $ |
| \varphi     | $\varphi    $ |
| \chi        | $\chi       $ |
| X           | $X          $ |
| \psi        | $\psi       $ |
| \Psi        | $\Psi       $ |
| \omega      | $\omega     $ |
| \Omega      | $\Omega     $ |

## 其它特殊字符

### 关系运算符

| 输入        | 输出         |
|------------|--------------|
| \pm        | $\pm       $ |
| \times     | $\times    $ |
| \div       | $\div      $ |
| \mid       | $\mid      $ |
| \nmid      | $\nmid     $ |
| \cdot      | $\cdot     $ |
| \circ      | $\circ     $ |
| \ast       | $\ast      $ |
| \bigodot   | $\bigodot  $ |
| \bigotimes | $\bigotimes$ |
| \bigoplus  | $\bigoplus $ |
| \leq       | $\leq      $ |
| \geq       | $\geq      $ |
| \neq       | $\neq      $ |
| \approx    | $\approx   $ |
| \equiv     | $\equiv    $ |
| \sum       | $\sum      $ |
| \prod      | $\prod     $ |
| \coprod    | $\coprod   $ |

### 集合运算符

| 输入      | 输出 |
|-----------|------|
| \emptyset | $\emptyset$ |
| \in       | $\in      $ |
| \notin    | $\notin   $ |
| \subset   | $\subset  $ |
| \supset   | $\supset  $ |
| \subseteq | $\subseteq$ |
| \supseteq | $\supseteq$ |
| \bigcap   | $\bigcap  $ |
| \bigcup   | $\bigcup  $ |
| \bigvee   | $\bigvee  $ |
| \bigwedge | $\bigwedge$ |
| \biguplus | $\biguplus$ |
| \bigsqcup | $\bigsqcup$ |

### 对数运算符

| 输入      | 输出 |
|-----------|------|
| \log      |   $\log$   |
| \lg       |  $\lg$    |
| \ln       |  $\ln $    |

### 三角运算符

| 输入      | 输出 |
|-----------|------|
| \bot      | $\bot     $     |
| \angle    | $\angle   $     |
| 30^\circ | $30^\circ$     |
| \sin      | $\sin     $     |
| \cos      | $\cos     $     |
| \tan      | $\tan     $     |
| \cot      | $\cot     $     |
| \sec      | $\sec     $     |
| \csc      | $\csc     $     |

### 微积分运算符

| 输入      | 输出 |
|-----------|------|
| \prime    | $\prime $     |
| \int      | $\int   $     |
| \iint     | $\iint  $     |
| \iiint    | $\iiint $     |
| \iiiint   | $\iiiint$     |
| \oint     | $\oint  $     |
| \lim      | $\lim   $     |
| \infty    | $\infty $     |
| \nabla    | $\nabla $     |

### 逻辑运算符

| 输入        | 输出 |
|-------------|------|
| \because    | $\because   $     |
| \therefore  | $\therefore $     |
| \forall     | $\forall    $     |
| \exists     | $\exists    $     |
| \not=       | $\not=      $     |
| \not>       | $\not>      $     |
| \not\subset | $\not\subset$     |

### 戴帽符号

| 输入        | 输出 |
|-------------|------|
| \hat{y}     |  $\hat{y}   $    |
| \check{y}   |  $\check{y} $    |
| \breve{y}   |  $\breve{y} $    |

### 连线符号

| 输入                                         | 输出 |
|----------------------------------------------|------|
| \overline{a+b+c+d}                           | $\overline{a+b+c+d}                          $     |
| \underline{a+b+c+d}                          | $\underline{a+b+c+d}                         $     |
| \overbrace{a+\underbrace{b+c}_{1.0}+d}^{2.0} | $\overbrace{a+\underbrace{b+c}_{1.0}+d}^{2.0}$     |

### 箭头符号

| 输入            | 输出 |
|-----------------|------|
| \uparrow        | $\uparrow       $     |
| \downarrow      | $\downarrow     $     |
| \Uparrow        | $\Uparrow       $     |
| \Downarrow      | $\Downarrow     $     |
| \rightarrow     | $\rightarrow    $     |
| \leftarrow      | $\leftarrow     $     |
| \Rightarrow     | $\Rightarrow    $     |
| \Leftarrow      | $\Leftarrow     $     |
| \longrightarrow | $\longrightarrow$     |
| \longleftarrow  | $\longleftarrow $     |
| \Longrightarrow | $\Longrightarrow$     |
| \Longleftarrow  | $\Longleftarrow $     |

## 字体转换

| 公式           | 字体         |
|----------------|--------------|
| \rm            | 罗马体       |
| \it            | 意大利体     |
| \bf            | 黑体         |
| \cal           | 花体         |
| \sl            | 倾斜体       |
| \sf            | 等线体       |
| \mit           | 数学斜体     |
| \tt            | 打字机字体   |
| \sc            | 小体大写字母 |


## 注意事项

在 Hexo 中的 Markdown 文件写 MathJax 公式要注意转义，比如 Hexo 自带 Markdown 渲染功能会把 `_` 当成关键词，所以在公式中要进行反转义。同理 `\` 要写成 `\\` ，其他语义冲突的符号还有 `*`、 `{`、 `}` 。

## 参考链接

- [MathJax basic tutorial and quick reference](https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
- [MathJax使用LaTeX语法编写数学公式教程](https://www.zybuluo.com/knight/note/96093)
