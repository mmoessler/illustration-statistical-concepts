# illustration-statistical-concepts

## Introduction

This repository contains the implementation of a learning module with interactive illustrations of statistical concepts.

### Subject - What?

The focus is the sampling properties of different estimators for the parameters of different statistical models.

Starting point is the specification of the data generating process (DGP) based on a statistical model and the choice of an estimator to estimate the parameters of the statistical model.

### Method - How?

Simmulation and illustration

* The DGP based on a given statistical model is simulated and the values of a given estimator is calculated.
* The simulation results of the DGP are illustrated using, i.e., barplots, scatterplots, etc,, and the distribution of the estimates are illustrated using histograms.
* The simulation and illustration is performed for different specifications of the statistical model or for different estimators.
* For each specification or estimator the illustrations are save in a different `.svg` file.
* The simulations illustrations are performed using the programming language for statistical computing and graphics [R](https://www.r-project.org/). 

Interactive presentation

* The different illustrations for different specifications are interactively embedded in a `.html` file and linked to a slider input tag.
* The effect of different specifications can be studied by changing the slider, i.e., the specification, and thus, the embedded illustration.
* The interactive integration of the illustrations into the `.html` file is based on javascript. 

Structure of the learning module

* The learning module contains different sub modules where each sub module has a specific learning goal, e.g., "understand the effect of the sample size on the sample properties of the sample average to estimate the mean of a Bernouli distribution".
* The material of a sub module is collected in a sub folder, e.g., `ln-clt_ber`.
* The sub folder contains the 

## DGPs and Estimators

### Bernoulli distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-ber/lln_clt_ber_html_xx.html

```

### Continuous uniform distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-con-uni/lln_clt_con_uni_html_xx.html

```

## Simple linear regression model and OLS estimator

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

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a>

<br />

This work is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
</a>.