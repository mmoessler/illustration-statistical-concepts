# illustration-statistical-concepts

## Introduction

### General

This repository contains the implementation of a learning module with interactive illustrations of statistical concepts.

### Subject - What?

The focus is the sampling properties of different estimators for the parameters of different statistical models.

Starting point is the specification of the data generating process (DGP) based on a statistical model and the choice of an estimator to estimate the parameters of the statistical model.

### Method - How?

Simmulation study and illustration/reporting of simulation results

* The DGP based on a given statistical model is simulated and the values of a given estimator is calculated.
* The simulation results, i.e., the sampling distribution of the estimator, are illustrated using  barplots, scatterplots and/or histograms.
* Other simulation results can be reported using tables.
* The simulation study is performed for different specifications of the statistical model or for different estimators.
* For each specification or estimator the results, e.g., figures and/or tables are save in different `.svg` and/or `html` files.
* The simulation study is performed using the programming language for statistical computing and graphics [R](https://www.r-project.org/). 

Interactive presentation of simulation results

* The results for different specifications, e.g., figures and/or tables, are interactively embedded in a `.html` file and linked to a slider input tag.
* The effect of different specifications can be studied by changing the slider, i.e., the specification, and thus, the embedded results.
* The interactive integration of the illustrations into the `.html` file is based on javascript.

Structure of the learning module

* The learning module contains different sub modules where each sub module has a specific learning goal, e.g., "understand the effect of the sample size on the sample properties of the sample average to estimate the mean of a Bernouli distribution".
* The material of a sub module is collected in a sub folder, e.g., `ln-clt_ber`.
* The sub folder contains:
    * `.R` file, e.g., `lln_clt_ber_rscript.R`, with the simulation study and the results stored in the `figures` and/or `tables`subdirectory
        * `figures` subdirectory with the illustrations of the simulation results
        * `tables` subdirectory with the reports of the simulation results (optional)
    * `.html` file, e.g., `lln_clt_ber_html.html`, with the interactive representation of the illustrations
    * `myScript.js` with the javascript for the interactive illustrations
    * `myStyle.css` with the css styles for the interactive illustrations
    * Additional assets, e.g.,:
        * `.png` file with a logo for the header of the `.html` file
        * ...
    
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