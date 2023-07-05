# illustration-statistical-concepts

## Introduction

### General

This repository contains the implementation of a learning module with interactive illustrations of statistical concepts.

### Subject of the learning module (What?)

The focus of the learning module is the sampling properties of different estimators for the parameters of different statistical models.

Starting point is (1) the specification of the data generating process (DGP) based on a statistical model of interest and (2) the choice of an estimator to estimate the parameters of the statistical model of interest.

Based on simulation studies the effect of various changes to the DGP, e.g., increasing sample size $N$, on the sampling properties of different estimators are analyzed and illustrated.

### Method/implementation of the learning module (How?)

For an interactive and immediate user experience it is useful to seperate the simulation study and the interactive presentation of the simulation results. 

This two-step procedure allows also a flexibel implementation. I.e., the simulation studies can be conducted with any software such as *R*, *python*, etc. and the interactive presentation of the results can be achieved using basic web development languages such as `.html`, `.css` and `js`.

Simmulation study and illustration/reporting of the simulation results

* The DGP based on a given statistical model is simulated and the values of a given estimator is calculated.
* The simulation results, i.e., the sampling distribution of the estimator, are illustrated using  barplots, scatterplots and/or histograms.
* Other simulation results can be reported using tables.
* The simulation study is performed for different specifications of the statistical model or for different estimators.
* For each specification or estimator the results, e.g., figures and/or tables are save in different `.svg` and/or `html` files.
* The simulation study is performed using the programming language for statistical computing and graphics [R](https://www.r-project.org/). 

Interactive presentation of the simulation results

* The results for different specifications, e.g., figures and/or tables, are interactively embedded in a `.html` file and linked to a slider input tag.
* The effect of different specifications can be studied by changing the slider, i.e., the specification, and thus, the embedded results.
* The interactive integration of the illustrations into the `.html` file is based on javascript.

Additional material, e.g., for explanation purposes

* Verbal text or mathematical formula.
* Audio or video explanations
* Any additional can be added into the `html` file interactively or non-interactively.

Integration in the lecture

* The material of this learning module can be provided on a gradual basis using links to the specific illustrations/sub modules or as a complete course/module with a starting page and links to the sub modules.
* The material can be hosted on *GitHub* or on a learning platform such as *ILIAS*. The easiest way to host the material on a learning platform such as *ILIAS* is using a import interface for `.html` structures. In the case of the learning platform *ILIAS* this procedure is quite easy and flexibel.

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

### Goal of the learning module (Why?)

The understanding of the sampling properties of estimators is one of the most important concepts of statistical inference, i.e, of learning from data about a (population) model of interest. 

A popular approach to analyze and understand the sampling properties of estimators under different set-ups (DGPs) is through simulation studies. The results of the simulation studies can be reported using tables or illustrations, e.g., histograms.

To understand the sampling properties it is useful to illustrate the sampling properties interactively, i.e, the student can change the DGP, e.g. increase the sample size" and can immediately observe the effects on the sampling distribution. 

## DGPs and Estimators

### Univariate random experiments and sample average

##### Bernoulli distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the probability of success $p$ of the Bernoulli distribution on the sampling distribution of the sample average as estimator for mean of the Bernoulli distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-ber/lln_clt_ber_html_xx.html

```

### Continuous uniform distribution and sample average

This illustration shows the effect of changing the sample size $n$ and the lower bound $a$ and the upper bound $b$ of the continuous uniform distribution on the sampling distribution of the sample average as estimator for mean of the continuous uniform distribution.

```

https://raw.githack.com/mmoessler/illustration-statistical-concepts/main/lln-clt-con-uni/lln_clt_con_uni_html_xx.html

```

### Simple linear regression model and OLS estimator

Illustration of the properties of the OLS estimator to estimate the slope coefficient \(\beta_{1}\) of a linear regression model, i.e.,

$$
\begin{align}
Y_{i} = \beta_{0} + \beta_{1} X_{i} + u_{i}
\end{align}
$$

#### Large sample properties of the OLS estimator

This illustration shows the effect of increasing the sample size \(N\) on the sampling distribution of the OLS estimator for the slope coefficient of a simple linear regression model.

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