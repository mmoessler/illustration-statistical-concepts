
# Figure 1

## Overall

The figure shows the scatter plot of the values of the observed variables y and x one and the corresponding fitted regression line in red and the scatter plot of the observed variable y and x one adjusted for the effects of the unobserved variable x two and the corresponding fitted regression line in green for one particular realization of the underlying DGP.

The red and green shaded area illustrates the range of all fitted regression lines estimated by OLS across all realizations for the underlying DGP.

Note, the green fitted regression line is the correct or unbiased relationship between y and x whereas the red fitted regression line is potentially biased due to the omission of the unobserved variable x two.

## Slider 1

Increasing the sample size decreases the range of the different fitted regression lines estimated by OLS across different realizations of the underlying DGP illustrated by the red and the green shaded area.

## Slider 2

Changing the slope coefficient of x one of the underlying DGP rotates the fitted regression lines estimated by OLS.

## Slider 3

As long as the correlation between x one and x two is zero changing the slope coefficient of x two away from zero only increases the range of the different fitted regression lines using the observed varibales y and x one across different realization of the underlying DGP illustrated by the red shaded area.

Note here, the red shaded area still includes the green shaded area, i.e., the range of the different fitted regression lines using the observed variables y and x one adjusted for the effect of the unobserved variable x two across different realization of the underlying DGP.

This is the result of including a variable relevant for the determination of y but unrelated to the variable of interest. This increases the fitting of your regression model but it is not necessary for causal inference with respect to your variable of interest.

However, in the case the correlation between x one and x two is not zero changing the slope coefficient of x two away from zero rotates the fitted regression lines using the observed variables y and x one while the fitted regression lines using the observed variables y and x one adjusted for the effect of the unobserved variable x two is not affected.

Note here, the red shaded area no longer includes the green shaded area, i.e., the regression of the observed variables y on x one is biased.

## Slider 4

As long as the slope coefficient of x two is zero changing the correlation between x one and x two away from zero does not affect the range of the different fitted regression lines using the observe variables y and x one across different realization of the underlying DGP illustrated by the red shaded area.

Instead, it increases the range of the different fitted regression lines using the observed variables y and x one adjusted for the effect of the unobserved variable x two across different realization of the underlying DGP.

This is the case of including an irrelevant variable in your regression. This increases only the variance of your estimate of the variable of interest.

However, in the case the slope coefficient of x two is not zero changing the correlation between x one and x two away from zero rotates the fitted regression lines using the observed variables y and x one while the fitted regression lines using the observed variables y and x one adjusted for the effect of the unobserved variable x two is not affected.

Note here, the red shaded area no longer includes the green shaded area, i.e., the regression of the observed variables y on x one is biased.

# Figure 2

## Overall

The figure shows the scatter plot of the observed values of x one and the fitted residuals of the estimated regression model using the observed variables y and x one adjusted for the effect of the unobserved variable x two.

The corresponding fitted regression line of a particular realization of the DGP is illustrated by green dashed line.

The green shaded are illustrates the different fitted regression lines across different realizations of the underlying DGP.

Note, the correlation between the observed variable x one and the estimated residual from the regression model are zero by construction of the OLS estimator.

However, this must be still true after controlling or adjusting y and x one for all potentially unobserved variables.

Note, this condition cannot be checked using observed variables but we can simuluate it here using the simulated observed variable x one and the simulated unobserved variable x two.

## Slider 1

Increasing the sample size increases the number of fitted residuals estimated by OLS.

## Slider 2

Changing the slope coefficient does not significantly change the relationship between the fitted residuals and x one.

## Slider 3

As long as the correlation between x one and x two is zero changing the slope coefficient of x two away from zero only increases the range of the different fitted regression lines using the fitted residuals of the estimated observed regression relationship across different realization of the underlying DGP illustrated by the green shaded area.

Note here, the range of the fitted regression lines spreads around the zero line symetrically and they converges to the zero line as the sample size increases.

Thus, for large number of observations the condition that the residuals u and the explanatory variable x one are uncorrelated is true.

However, in the case the correlation between x one and x two is not zero changing the slope coefficient of x two away from zero rotates the fitted regression lines using the fitted residuals of the estimated observed regression relationship.

Note here, the range of the fitted regression lines no longer spreads around the zero line symmetrically and they no longer converges to the zero line as the sample size increases.

Thus, the condition that the residuals u and the explanatory variable x one are uncorrelated is violated.

## Slider 4

As long as the slope coefficient of x two is zero changing the correlation between x one and x two away from zero does not affect the fitted residuals of the estimated observed regression relationship.

Thus, the condition that the residuals u and the explanatory variable x one are uncorrelated is true.

However, in the case the slope coefficient of x two is not zero changing the correlation between x one and x two away from zero rotates the fitted regression lines using the fitted residuals of the estimated observed regression relationship.

Note here, the range of the fitted regression lines no longer spreads around the zero line symmetrically and they no longer converges to the zero line as the sample size increases.

Thus, the condition that the residuals u and the explanatory variable x one are uncorrelated is violated.

# Figure 3

## Overall

The figure shows the histogram of the estimated slope coefficient across all realizations of the underlying DGP.

The red vertical dashed line represents the estimated slope coefficient of regressing the observed variables y on x one for one particular realization of the underlying DGP.

The green vertical dashed line represents the slope coefficient of the underlying DGP, i.e., the the slope coefficient of regressing the observeed variables y on x one adjusted for x two.

## Slider 1

By increasing the sample size the estimated slope coefficients concentrate more around the slope coefficient of the underlying DGP.

This is the result of law of large numbers.

## Slider 2

Changing the slope coefficient of x one of the underlying DGP shifts the histogram of the estimated slope coefficient.

## Slider 3

As long as the correlation between x one and x two is zero changing the slope coefficient of x two away from zero only increases the range of OLS estimates for the slope coefficient of x one.

However, in the case the correlation between x one and x two is not zero changing the slope coefficient of x two away from zero shifts the histogram of the OLS estimates for the slope coefficients of the observed relationship away from the green vertical dashed line.

Thus, the OLS estimator for the slope coefficient based on the observed variables y and x one is biased and inconsistent.

## Slider 4

As long as the slope coefficient of x two is zero changing the correlation between x one and x two away from zero does not affect range of OLS estimates for the slope coefficient of x one.

However, in the case the slope coefficient of x two is not zero changing the correlation between x one and x two away from zero shifts the histogram of the OLS estimates for the slope coefficients of the observed relationship away from the green vertical dashed line.

Thus, the OLS estimator for the slope coefficient based on the observed variables y and x one is biased and inconsistent.

# Figure 4

## Overall

The figure shows the histogram of the standardized estimated slope coefficient across all realizations of the DGP.

For the standardization we subtract the slope coefficient of the variable x one and divide by an estimate of the variance of the estimated slope coefficient.

The red vertical dashed line represents the standardized estimated slope coefficient of regressing the observed variables y on x one for one particular realization of the underlying DGP.

The green vertical dashed line represents the standardized estimated slope coefficient of regressing the observed variables y on x one adjusted for the unobserve variable x two for one particular realization of the underlying DGP.

The green dashed curve represents the pdf of the standard normal distribution.

## Slider 1

In the case the effect of x two or the correlation between x one and x two is zero the sampling distribution of the standardized estimated slope coefficient of regressing the observed variables y on x one gets closer to the standard normal distribution which pdf is illustrated by the green dashed curve for increasing sample sizes.

Howerver, in the case the effect of x two and the correlation between x one and x two are different from zero the standardized estimated slope coefficient shifts further away from the standard normal distribution for increasing sample size.

The latter case illustrates the effect of omitted variable bias on the sampling distribution of the standardized estimated slope coefficient.

## Slider 2

In the case the effect of x two or the correlation between x one and x two is zero the sampling distribution of the standardized estimated slope coefficient of regressing the observed variables y on x one is not affected by the effect of x one on y.

Howerver, in the case the effect of x two and the correlation between x one and x two are different from zero the standardized estimated slope coefficient is shifted away from the standard normal distribution for increasing sample size.

The latter case illustrates the effect of omitted variable bias on the sampling distribution of the standardized estimated slope coefficient.

## Slider 3

As long as the correlation between x one and x two is zero changing the slope coefficient of x two away from zero does not affect the sampling distribution of the standardized estimated slope coefficient of the relationship between the observed variables y and x one.

However, in the case the correlation between x one and x two is not zero changing the slope coefficient of x two away from zero shifts the histogram of the standardized OLS estimates for the slope coefficients of the observed relationship away from the standard normal distribution.

The latter case illustrates the effect of omitted variable bias on the sampling distribution of the standardized estimated slope coefficient.

## Slider 4

As long as the slope coefficient of x two is zero changing the correlation between x one and x two away from zero does not affect the sampling distribution of the standardized estimated slope coefficient of the relationship between the observed variables y and x one.

However, in the case the correlation between x one and x two is not zero changing the correlation between x one and x two away from zero shifts the histogram of the standardized OLS estimates for the slope coefficients of the observed relationship away from the standard normal distribution.

The latter case illustrates the effect of omitted variable bias on the sampling distribution of the standardized estimated slope coefficient.
