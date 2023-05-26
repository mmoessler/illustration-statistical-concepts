# illustration-statistical-concepts

Illustration of statistical concepts and methods using simulation studies.

### Bernoulli distribution

Consider iid draws from the Bernoulli distribution,

$$
Y_{i} \sim \text{Bernoulli} \left(p\right)
$$

This illustration shows the effect of changing the sample size $N$ and probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-ber/lln_clt_ber_html_xx.html

```

### Continuous uniform distribution

Consider iid draws from the continuous uniform distribution,

$$
\begin{align*}
Y_i &\sim U_{\left[a,b\right]}.
\end{align*}
$$

This illustration shows the effect of changing the sample size $N$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-con-uni/lln_clt_con_uni_html_xx.html

```

## Sampling properties of OLS estimator

The illustrations below shows the sampling properties of the OLS estimator as estimator for the slope coefficient $\beta_1$ in the following simple linear regerssion model,

$$
\begin{align*}
Y_i &= -2 + 3.5 X_i + u_i, \\
X_i &\sim N\left(0,10\right), \\
u_i &\sim N\left(0,10\right),
\end{align*}
$$

with $\beta_0 = 1$, $\beta_1 = 2$, $\sigma_X^2 = 10$ and $\sigma_u^2 = 10$ and with,

$$
\begin{align*}
\text{E}\left[u|X\right] = 0, \\
\text{Var}\left[u|X\right] = 0,
\end{align*}
$$

Each case below focus on the effect of changing a parameter of the statistical model above.

### Case 1

This illustration shows the effect of changing the sample size $N$.

Open the following link in your browser:

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-01/ols_case_01_html_xx.html

```

Run the following codes in R (shiny, i.e., old approach):

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_01_run.R")

```

### Case 2

This illustration shows the effect of changing the sample size $N$ and changing the value of the slope parameter, i.e., $\beta_1$.

Open the following link in your browser:

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-02/ols_case_02_html_xx.html

```

<!--

### Case 3

This illustration shows the effect of changing the sample size $N$ and changing the variance of $u$, i.e., $\sigma_u^2$.

### Case 4

This illustration shows the effect of changing the sample size $N$ and changing the variance of $X$, i.e., $\sigma_X^2$.

Run the following codes in R (old approach):

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_02_run.R")

```

### Case 4

This illustration shows the effect of ..., i.e., of omitted variable bias (OVB).

Run the following codes in R (old approach):

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_03_run.R")

```

-->

### Case xx (shiny approach)

This illustration shows the effect/consequences of omitted variable bias and heteroskedasticity on the sampling distribution of the slope parameter $\beta_1$.

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_xx_run.R")

```
