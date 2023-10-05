# Head -------------------------------------------------------------------------

rm(list=ls())

library(scales)
library(forecast)
library(plotrix)

# Simulation -------------------------------------------------------------------

# Define a function to simulate ARMA for a given set of parameters
simulateARMA <- function(ar1, ar2, ma1, ma2, tt = 200) {
  set.seed(125)
  sd <- 1
  
  y.sim <- NULL
  
  try( y.sim <- arima.sim(n = tt, model = list(ar = c(ar1, ar2), ma = c(ma1, ma2)),
                          rand.gen = function(n, ...) {rnorm(tt, 0, sd)}), silent = TRUE)
  
  return(y.sim)
}

# Define a grid of parameter combinations to iterate through
ar_values <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)
ma_values <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)
parameter_combinations <- expand.grid(ar1 = ar_values, ar2 = ar_values, ma1 = ma_values, ma2 = ma_values)

# Plots ------------------------------------------------------------------------

# set directory of figures
fig.dir <- "C:/Users/Benjamin/OneDrive - uni-hohenheim.de/Harsch_Moessler/Shiny_Applications_RPlots/figures/"


# Iterate through parameter combinations and generate plots
for (i in 1:nrow(parameter_combinations)) {
  params <- parameter_combinations[i, ]
  ar1 <- params$ar1
  ar2 <- params$ar2
  ma1 <- params$ma1
  ma2 <- params$ma2
  
  y.sim <- simulateARMA(ar1, ar2, ma1, ma2)
  
  # plot no 01, r=1:
  r = 1
  #plt.nam <- paste(fig.dir, "figure_", r, "_", i, ".svg", sep = "")
  #svg(plt.nam)

  # Check if any element in y.sim is NA or NULL
  if (any(is.na(y.sim)) || is.null(y.sim)) {
    plot(x = 0:1, # Create empty plot
         y = 0:1,
         ann = FALSE,
         bty = "n",
         type = "n",
         xaxt = "n",
         yaxt = "n")
    text(x = 0.5,
         y = 0.5,
         "Choose a stable ARMA specification \n to display the time series",
         cex = 2)
  } else {
    plot(y.sim, xlab = "tt", ylab = "Value", ylim = c(-4, 4))
    abline(a = 0, b = 0, col = "red")
  }

  # Close the plot device
  dev.off()
  
  
  
  # plot no 02, r=2:
  r = 2
  plt.nam <- paste(fig.dir, "figure_", r, "_", i, ".svg", sep = "")
  svg(plt.nam)

  plot(1/polyroot(c(1,-c(ar1,ar2))),
       col = "red", cex = 1.5, lwd = 3,
       ylim=c(-1.5,1.5),xlim=c(-1.5,1.5),
       xlab = c("Real Part"),
       ylab = c("Imaginary Part"),
       asp=1)
  abline(h=0,lty=2)
  abline(v=0,lty=2)
  draw.circle(x=0,y=0,r=1)

  # Close the plot device
  dev.off()

  
  # plot no 03, r=3:
  r = 3
  plt.nam <- paste(fig.dir, "figure_", r, "_", i, ".svg", sep = "")
  svg(plt.nam)
  
  if (!is.null(y.sim)) {
    Pacf(y.sim, main="Partial autocorrelation function")
    
  } else {
    plot(x = 0:1, # Create empty plot
         y = 0:1,
         ann = F,
         bty = "n",
         type = "n",
         xaxt = "n",
         yaxt = "n")
    text(x = 0.5, # Add text to empty plot
         y = 0.5,
         # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
         "Choose a stable ARMA specification \n to display the pacf",
         cex = 2)
  }
  
  # Close the plot device
  dev.off()
  
}













