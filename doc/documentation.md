# Interactive Illustration of the Sampling Properties of Estimators

**Author**: Markus Mößler

## Abstract

This documentation describes the implementation of a learning module designed to provide an interactive illustration of the sampling properties of estimators.

## Introduction

This repository contains the implementation of a learning module with interactive and animated illustrations of fundamental statistical concepts and properties.

## Goal of the Learning Module (Why?)

Understanding the concept and properties of sampling distributions of estimators is one of the most important concepts in statistical inference, particularly in the context of learning from data about the underlying data generating process (DGP). This concept is central to empirical studies in social science and econometrics.

However, students often struggle with grasping the concept of sampling distributions due to the abstract way they are typically presented. The goal of this module is to provide a more intuitive understanding of the sampling properties of estimators through interactive and animated illustrations of simulation results.

### Example

One example of this learning module is demonstrating the effect of increasing the sample size ($n$) on the sampling properties of the sample average $\overline{X}$, which is used to estimate the mean ($\mu$) of a random variable. This concept is articulated through the Law of Large Numbers (LLN) and the Central Limit Theorem (CLT).

Through interactive simulations, students can observe how increasing the sample size brings the sample average closer to the true mean (LLN) and how the sampling distribution of the standardized sample average converges to a standard normal distribution (CLT).

## Subject of the Learning Module (What?)

### General Overview

The focus of this module is on the sampling properties of estimators for various data generating processes (DGPs). These processes are based on statistical models with parameters of interest, such as the mean of a Bernoulli random variable. The estimators, such as the sample average, are used to estimate these parameters.

This module demonstrates how changes in the DGP, such as increasing the sample size, affect the sampling distribution of an estimator.

### Univariate Random Variables and Sample Average

#### Bernoulli Distribution and Sample Average

This example shows the effect of changing the sample size ($n$) and the probability of success ($p$) in the Bernoulli distribution on the sampling distribution of the sample average, which is used to estimate the mean of the Bernoulli distribution.

#### Continuous Uniform Distribution and Sample Average

This example illustrates the effect of changing the sample size ($n$), as well as the lower bound ($a$) and upper bound ($b$) of the continuous uniform distribution, on the sampling distribution of the sample average, which estimates the mean of the continuous uniform distribution.

### Linear Regression Model and Ordinary Least Squares

#### Sampling Distribution and Sample Size

This illustration shows the effect of increasing the sample size ($n$) on the sampling distribution of the OLS estimator for the slope coefficient ($\beta_1$) in a simple linear regression model.

#### Sample Size and Parameterization of the DGP

This illustration explores the effect of changing various parameters of the DGP, such as:

1. Sample size ($n$),
2. Variance of the error term ($\sigma_{u_i}^2$),
3. Variance of the predictor ($\sigma_X^2$),

on the sampling distribution of the OLS estimator for the slope coefficient in a simple linear regression model.

#### Effect of Heteroskedasticity

...

#### Effect of Omitted Variable Bias

...

## Method of the Learning Module (How?)

### General Overview

For an interactive and immediate user experience, this module separates the simulation study from the presentation of the results. This two-step process allows flexibility in implementation, where the simulations can be conducted using suitable software like R or Python, and the results are presented interactively using web technologies (HTML, CSS, and JavaScript).

#### Appealing and Interactive Presentation

The simulation results for different settings are presented in a `.html` file linked to sliders that allow the user to change the parameters interactively. The results (e.g., figures or tables) are dynamically updated based on the selected parameter values.

#### Additional Material for Explanation

The module can include explanatory text, mathematical formulas, interactive animations with audio explanations, or additional material like videos.

### Structure of the Files

The structure of the files includes:

1. **Simulation Study File**: This file contains the code for the simulation and the generation of figures based on different parameter values.
   
2. **HTML, CSS, and JavaScript Files**: These files are used to present the results interactively. The `.html` file contains the structure, the `.css` file provides the styling, and the `.js` file enables interactivity and animations.

The flexible setup allows the module to be implemented using core web technologies like HTML, CSS, and JavaScript, with the help of libraries like Bootstrap for responsive design.

## Integration in Lectures

The material from this learning module can be integrated gradually or provided as a complete course. It can be hosted on platforms like GitHub or learning management systems such as ILIAS.
