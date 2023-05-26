# illustration-statistical-concepts

Illustration of statistical concepts and methods using simulation studies.

### Bernoulli distribution

Consider iid draws from the Bernoulli distribution,

$$
Y_{i} \sim \text{Bernoulli} \left(p\right)
$$

This illustration shows the effect of changing the sample size $n$ and probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-ber/lln_clt_ber_html_xx.html

```

### Continuous uniform distribution

Consider i.i.d. draws from the continuous uniform distribution,

$$
\begin{align*}
Y_i &\sim U_{\left[a,b\right]}.
\end{align*}
$$

This illustration shows the effect of changing the sample size $n$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-con-uni/lln_clt_con_uni_html_xx.html

```

## Sampling properties of OLS estimator

This illustratio shows the effect of the sample size $n$, the slope parameter $\beta_{1}$, the variance of $X_{i}$, i.e., $\sigma_{X}$, and the variance of $u_{i}$, i.e., $\sigma_{u}$ of the regression model,

$$
\begin{align}
Y_{i} = \beta_{0} + \beta_{1} X_{i} + u_{i},
\end{align}
$$

with,

$$
\begin{align}
X_{i} &\sim N\left(0, \sigma_{X}\right), \\
u_{i} &\sim N\left(0, \sigma_{u}\right),
\end{align}
$$

on the sampling distribution of the OLS estimator $\widehat{\beta}_{1}$ for the slope parameter $\beta_{1}$.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-01/ols_case_01_html_xx.html

```
