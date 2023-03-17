# illustration-statistical-concepts

Illustration of statistical concepts and methods using simulation studies.

## Sampling properties of sample average

The illustrations below show the sampling properties of the sample average as estimator for the probability of success $p$ in a Bernoulli experiment, i.e., based on the following DGP,

$$
\begin{align*}
Y_i &\sim B\left(p\right). \\
\end{align*}
$$

### Case 1

This illustration shows the effect of changing the sample size $N$ for fixed $p=0.4$.

Open the following link in your browser.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-case-01/lln_clt_case_01_html_xx.html

```

### Case 2

This illustration shows the effect of changing the sample size $N$ and the probability of success $p$.

Open the following link in your browser.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-case-02/lln_clt_case_02_html_xx.html

```

## Sampling properties of OLS estimator

The illustrations below shows the sampling properties of the OLS estimator as estimator for the slope coefficient $\beta_1$ in a simple linear regression model, i.e., based on a sample of size $N$ of the following statistical model,

$$
\begin{align*}
Y_i &= -2 + 3.5 X_i + u_i, \\
X_i &\sim N\left(0,10\right), \\
u_i &\sim N\left(0,10\right),
\end{align*}
$$

with $\beta_0 = -2$, $\beta_1 = 3.5$, $\sigma_X^2 = 10$ and $\sigma_u^2 = 10$ and with,

$$
\begin{align*}
\text{E}\left[u|X\right] = 0, \\
\text{Var}\left[u|X\right] = 0,
\end{align*}
$$

with ...

Each case below focus on the effect of changing a parameter of the statistical model above.

### Case 1

This illustration shows the effect of changing the sample size $N$.

Open the following link in your browser:

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/ols-case-01/ols_case_01_html_xx.html

```

Run the following codes in R  (old approach):

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_01_run.R")

```

### Case 2

This illustration shows the effect of changing the variance of $u$, i.e., $\sigma_u^2$.

### Case 3

This illustration shows the effect of changing the variance of $X$, i.e., $\sigma_X^2$.

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
