
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ts-arma-sim-01/figures/"

# load libraries
library(forecast)
library(plotrix)

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

# set seed 
set.seed(12345)

# function to simulate arma(2,2) models ----
arma_sim_fun <- function(ar1, ar2, ma1, ma2, sig = 1, tt = 200) {
  
  y.sim <- NULL
  
  try( y.sim <- arima.sim(n = tt,
                          model = list(ar = c(ar1, ar2), ma = c(ma1, ma2)),
                          rand.gen = function(n, ...) {rnorm(tt, 0, sig)}), silent = TRUE)
  
  return(y.sim)
  
}

# inputs (fixed)
tt <- 200
sig <- 1

# inputs (variable)
ar1.vec <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)
ar2.vec <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)
ma1.vec <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)
ma2.vec <- c(-1, 0.6, 0.3, 0, 0.3, 0.6, 1)

ar1.vec <- c(0.3, 0.3)
ar2.vec <- c(0.3, 0.3)
ma1.vec <- c(0.3, 0.3)
ma2.vec <- c(0.3, 0.3)

# grid for names
tmp.grd <- expand.grid(seq(1,length(ar1.vec)), seq(1,length(ar2.vec)), seq(1,length(ma1.vec)), seq(1,length(ma2.vec)), stringsAsFactors = FALSE)

# simulation/illustration ----
for (ind in 1:length(tmp.grd)) {
  
  # inputs
  ii <- tmp.grd[ind, 1]
  jj <- tmp.grd[ind, 2]
  kk <- tmp.grd[ind, 3]
  ll <- tmp.grd[ind, 4]
  
  ar1 <- ar1.vec[ii]
  ar2 <- ar2.vec[jj]
  ma1 <- ma1.vec[kk]
  ma2 <- ma2.vec[ll]
  
  # simulation
  y.sim <- arma_sim_fun(ar1 = ar1, ar2 = ar2, ma1 = ma1, ma2 = ma2, sig = sig, tt = tt)
  
  # plot no 01: ts-plot ----
  plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
  svg(plt.nam) 
  
    if(is.null(y.sim)) {
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
      plot(y.sim, xlab = "time", ylab = "Value", ylim = c(-4, 4))
      abline(a = 0, b = 0, col = "red")
    }
    
  dev.off()
  
  # plot no 02: polyroot ----
  plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
  svg(plt.nam) 
  
    plot(1/polyroot(c(1, -c(ar1, ar2))),
         col = "red", cex = 1.5, lwd = 3,
         ylim = c(-1.5, 1.5), xlim = c(-1.5, 1.5),
         xlab = c("Real Part"),
         ylab = c("Imaginary Part"),
         asp = 1)
    abline(h = 0, lty = 2)
    abline(v = 0, lty = 2)
    draw.circle(x = 0, y = 0, r = 1)
  
  dev.off()
  
  # plot no 03: acf ----
  plt.nam <- paste(fig.dir, "figure_03_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
  svg(plt.nam) 
  
    yt.pacf <- forecast::Acf(x = y.sim, lag.max = 10, type = "correlation", plot = TRUE,
                             ylab = "", xlab = "time", main = "")
  
  
  dev.off()
  
  # plot no 04: pacf ----
  plt.nam <- paste(fig.dir, "figure_04_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
  svg(plt.nam) 
  
  yt.pacf <- forecast::Acf(x = y.sim, lag.max = 10, type = "partial", plot = TRUE,
                           ylab = "", xlab = "time", main = "")
  
  
  dev.off()
  
}
