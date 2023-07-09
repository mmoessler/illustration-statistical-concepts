# illustration-statistical-concepts

## Introduction

## DGPs and Estimators

### Univariate random experiments and sample average

##### Bernoulli distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ber-dis-sam-ave/ber_dis_sam_ave_html_xx.html

```

### Continuous uniform distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/con-uni-dis-sam-ave/con_uni_dis_sam_ave.html

```

### Simple linear regression model and OLS estimator

Illustration of the properties of the OLS estimator to estimate the slope coefficient \(\beta_{1}\) of a linear regression model, i.e.,

$$
\begin{align}
Y_{i} = \beta_{0} + \beta_{1} X_{i} + u_{i}
\end{align}
$$

#### Sampling distribution and sample size

This illustration shows the effect of increasing the sample size \(N\) on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/cs-lin-reg-ols-01/cs_lin_reg_ols_html.html

```

#### Parameters of the DGP

This illustration shows the effect of changing the parameters of the DFP, i.e.,  

(1) changing the sample size \(n\),
(2) changing the variance of \(u_{i}\), i.e., \(\sigma_{u_{i}}^{2}\), and,
(3) changing the variance of \(X_{i}\), i.e., \(\sigma_{X}^{2}\), 

on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-01/ols_case_01_html_xx.html

```

#### Effect of Heteroskedasticitiy

This illustration shows the effect of heteroskedasticity on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-02/ols_case_02_html_xx.html

```

#### Effect of Omitted Variables

This illustration shows the effect of omitted variables on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-03/ols_case_03_html_xx.html

```

## To Dos

* Include start page for complete distribution of the learning module
* Extend parallelization beyond ols case 2-4 
* Adapt the arrangement and style for an appealing appearance on mobile devices, e.g., via chrome explorer
* Add a `.tex` slide presentation for the presentation of the learning module

## Licence

This project is part of the [DeLLFi](https://www.uni-hohenheim.de/en/project-dellfi) (Integrating digitalization along teaching, learning, and research) project of the University of Hohenheim and funded by [Foundation for Innovation in University Teaching](https://stiftung-hochschullehre.de/)

The materials may be used and further developed for teaching purposes with credit to the author and funding and under the terms of the license (see below).

<hr>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a>

<br />

This work is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
</a>.