# illustration-statistical-concepts

Illustration of statistical concepts using statistic software

## OLS estimator sampling properties

### Case 1

This illustrations shows the sampling properties of the OLS estimator for the slope coefficient $\beta_1$ based on the following DGP,

$$
Y_i &= -2 + 3.5 X_i + u_i, \\
X_i &\sim N\left(0,10\right), \\
u_i &\sim N\left(0,10\right).
$$

Run the following code in R

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/ols_case_01_run.R")

```



# Deployment

## Stand-alone

Check the deployment of the illustration in a "stand-alone" html file by calling the url in your browser.

Based on a "raw" html file,

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/html-files/bernoulli_illustration_xx.html

```

or, based on a rmd file,

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/rmd-files/index.html

```

## Using R

Check the deployment of a dummy shiny application by running the following chunk in R Studio.

```

source("https://raw.githubusercontent.com/mmoessler/illustration-statistical-concepts/main/r-shiny/r_shiny_dummy_run.R")

```

Note, the code generates problems when executed in R (only).

Called in R (only) generates problems with pandoc or pandoc version!
