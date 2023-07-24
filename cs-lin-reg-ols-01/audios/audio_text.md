
# Figure 1

## Overall

The figure shows the scatter plot of the values of x and y and the corresponding fitted regression line estimated by OLS for one particular realization of the underlying DGP.

The red shaded area illustrates the range of all fitted regression lines estimated by OLS across all realizations for the underlying DGP.

## Slider 1

A different realization of the DGP results in a different estimate and thus a different fitted regression line estimated by OLS illustrated by the red dashed line.

## Slider 2

Increasing the sample size decreases the range of the different fitted regression lines across all realizations of the underlying DGP illustrated by the red shaded area.

# Figure 2

## Overall

The figure shows the scatter plot of the valus of x and the fitted residuals of a simple linear regression model estimated by OLS.

Note, since the estimated parameters includes an intercept and a slope coefficient, the fitted residuals have a mean equal to zero and are uncorrelated with x by construction of the OLS estimator.

## Slider 1

A different realization of the DGP results in a different estimate and thus a different fitted residual estimated by OLS illustrated by the scatterplot.

## Slider 2

Increasing the sample size increases the number of fitted residuals estimated by OLS.

# Figure 3

## Overall

The figure shows the histogram of the estimated slope coefficient across all realizations of the underlying DGP.

The red vertical dashed line represents the estimated slope coefficient for one particular realization of the underlying DGP.

The green vertical dashed line represents the slope coefficient of the underlying DGP.

## Slider 1

A different realization of the underlying DGP results in a different estimate for the slope coefficients represented by the red vertical dashed line.

## Slider 2

By increasing the sample size the estimated slope coefficients concentrate more around the slope coefficient of the underlying DGP.

This is the result of law of large numbers.

Thus, to conduct hypothesis tests we need a sampling distribution which is stable across sample sizes. For this we have to standardize the estimate usign the sample size.

# Figure 4

## Overall

The figure shows the histogram of the standardized estimated slope coefficient across all realizations of the DGP.

For the standardization with subtract the slope coefficient and divide by an estimate of the variance of the estimated slope coefficient.

The red vertical dashed line represents the standardized estimated slope coefficient for one particular realization of the DGP.

The green vertical dashed curve represents the pdf of the standard normal distribution.

Note, the estimate for the variance of the estimated slope coefficient is explained below and is a function of the sample size, the variance of u, the variance of x, and the covariance of u and x.

## Slider 1

A different realization of the underlying DGP results in a different standardized estimate for the slope coefficient represented by the red vertical dashed line.

## Slider 2

By increasing the sample size the sampling distribution of the standardized estimated slope coefficient gets closer to the standard normal distribution which pdf is illustrated by the green dashed curve.

This is the result of central limit theorem.

Note, the sampling distribution of the standardized estimate is stable across the sample size.

Thus, for large n the standardized estimate can be used to conduct hypothesis tests.