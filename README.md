# illustration-statistical-concepts

<!-- Illustration of statistical concepts and methods using simulation studies. -->

This repository contains tools to illustrate the sampling properties of (parametric) estimators for (parametric) models. 

Starting point is a model for the data generating process (DGP)

## Sampling properties of sample average

### Bernoulli distribution

This illustration shows the effect of changing the sample size $n$ and probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-ber/lln_clt_ber_html_xx.html

```

### Continuous uniform distribution

This illustration shows the effect of changing the sample size $n$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-con-uni/lln_clt_con_uni_html_xx.html

```

## Sampling properties of OLS estimator

Illustration of the properties of the OLS estimator to estimate the slope coefficient \(\beta_{1}\) of a linear regression model, i.e.,

$$
\begin{align}
Y_{i} = \beta_{0} + \beta_{1} X_{i} + u_{i}
\end{align}
$$

### Large sample properties of the OLS estimator

This illustration shows the effect of increasing the sample size \(N\) on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-01/ols_case_01_html_xx.html

```

### Effect of Heteroskedasticitiy

This illustration shows the effect of heteroskedasticity on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-02/ols_case_02_html_xx.html

```

### Effect of Omitted Variables

This illustration shows the effect of omitted variables on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-03/ols_case_03_html_xx.html

```



# Licence

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.