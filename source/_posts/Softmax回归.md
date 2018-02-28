---
title: Softmax 回归
categories: 机器学习
comments: true
mathjax: true
tags:
  - 分类
  - Scikit-Learn
abbrlink: 6236
date: 2018-02-28 16:03:44
---

[逻辑回归](/posts/60504/) 解决的是二分类问题，这里的 Softmax 回归解决的是多分类问题。

<!--more-->

## 预测概率

k 类的得分如下：

$$
s\_k\left(x\right) = \theta\_k^T\cdot x
$$

这里和逻辑回归类似，但是对于每个类别都有一个参数向量 $\theta\_k$ 。  

有了在每个类别上的得分，然后就是归一化计算概率。

$$
\hat p\_k = \sigma\left(s\left(x\right)\right)\_k = \frac{\text{exp}\left(s\_k\left(x\right)\right)}{\sum\_{j=1}^k\text{exp}\left(s\_j\left(x\right)\right)}
$$

- k 代表第 k 类
- $s\left(x\right)$ 输入 x 对于每一类的得分
- $\sigma\left(s\left(x\right)\right)\_k$ 是 x 属于第 k 类的概率

有了 x 属于各个类别的概率就可以的到最大可能属于哪一类别了。

$$
\hat y = \mathop{argmax}\_k \sigma\left(s\left(x\right)\right)\_k = \mathop{argmax}\_k s\_k\left(x\right) = \mathop{argmax}\_k \left(\theta\_k^T\cdot x\right)
$$

## 训练和损失函数

损失函数和逻辑回归的损失函数十分类似。

$$
J\left(\Theta\right) = - \frac{1}{m}\sum\_{i=1}^m \sum\_{k=1}^k y\_k^{\left(i\right)} \log \left(\hat p\_k^{\left(i\right)}\right)
$$

其中如果第 i 个输入被判断为第 k 类， 那么$y\_k^{\left(i\right)}$ 等于 1 ，否则等于 0 。也就是说把所有判断出得概率经过 $- \log\left(t\right)$ 函数处理后相加。

>信息熵代表的是随机变量或整个系统的不确定性，熵越大，随机变量或系统的不确定性就越大。
>交叉熵，其用来衡量在给定的真实分布下，使用非真实分布所指定的策略消除系统的不确定性所需要付出的努力的大小。
>相对熵，其用来衡量两个取值为正的函数或概率分布之间的差异。
>相对熵 = 某个策略的交叉熵 - 信息熵

然后就是求损失函数的最小值了，证明方法和逻辑回归的类似，可以参考[逻辑回归损失函数求导](/posts/60504/#训练和损失函数)。

$$
\frac{\partial}{\partial \theta \_k}J\left(\theta \right) = \frac{1}{m}\sum\_{i=1}^m \left(\hat p\_k^{\left(i\right)} - y\_k^{\left(i\right)}\right) x^{\left(i\right)}
$$

这里需要注意的是，Softmax 回归又个不寻常的特点，就是有冗余参数，比如从参数向量 $\theta\_j$ 减去向量 $\psi$ ，结果就是完全不影响预测结果。可以加入正则化来让损失函数成为严格的凸函数。

```python
from sklearn.linear_model import LogisticRegression
from sklearn import datasets
iris = datasets.load_iris()
x = iris["data"][:, (2, 3)]
y = iris["target"]
softmax_reg = LogisticRegression(multi_class="multinomial", solver="lbfgs", C=10)
softmax_reg.fit(x, y)
softmax_reg.predict([[5, 2]])
```

在 sklearn 中，默认使用了 $l\_2$ 正则系数。