
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ts-arma-sim-01/figures/"

# load libraries
library(plotrix)
library(forecast)
library(MTS)

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

# set seed 
set.seed(12345)

# function to simulate arma(2,2) models ----
arma_sim_fun <- function(ar1, ar2, ma1, ma2, sig = 1, tt = 100) {
  
  y.sim <- NULL
  
  try( y.sim <- arima.sim(n = tt,
                          model = list(ar = c(ar1, ar2), ma = c(ma1, ma2)),
                          rand.gen = function(n, ...) {rnorm(tt, 0, sig)}), silent = TRUE)
  
  # phi <- matrix(c(ar1, ar2), 1, 2)
  # sig <- matrix(c(sig), 1, 1)
  # the <- matrix(c(ma1, ma2), 1, 2)
  # m1 <- MTS::VARMAsim(tt, arlags = c(2), malags = c(2), phi = phi, theta = the, sigma = sig)
  # zt=m1$series
  # 
  # y.sim <- zt
  
  return(y.sim)
  
}

# inputs (fixed)
tt <- 100
sig <- 1

# inputs (variable)
ar1.vec <- c(-1, -0.6, -0.3, 0, 0.3, 0.6, 1)
ar2.vec <- c(-1, -0.6, -0.3, 0, 0.3, 0.6, 1)
ma1.vec <- c(-1, -0.6, -0.3, 0, 0.3, 0.6, 1)
ma2.vec <- c(-1, -0.6, -0.3, 0, 0.3, 0.6, 1)

# grid for names
tmp.grd <- expand.grid(seq(1,length(ar1.vec)), seq(1,length(ar2.vec)), seq(1,length(ma1.vec)), seq(1,length(ma2.vec)), stringsAsFactors = FALSE)

library(parallel)
library(doSNOW)
library(doRNG)

# packages needed in the foreach environment
needed.packages <- c("plotrix", "forecast", "MTS")

cl <- makeCluster(detectCores() - 1)
registerDoSNOW(cl)

pb <- txtProgressBar(max = nrow(tmp.grd), style = 3)
progress <- function(n) setTxtProgressBar(pb, n)
opts <- list(progress = progress)

# dp parallel simulation ----
result <- foreach(ind = 1:nrow(tmp.grd),
                  .packages = needed.packages,
                  .options.snow = opts,
                  .options.RNG = 12345) %dorng% {
  
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
                        
                        plot(y.sim, xlab = "time", ylab = "Value", ylim = c(-5, 5), type = "l")
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
                      
                        yt.acf <- forecast::Acf(x = y.sim, lag.max = 10, type = "correlation", plot = TRUE,
                                                ylab = "", xlab = "time", main = "",
                                                ylim = c(-0.8, 0.8))
                        
                      }
                    
                    dev.off()
                    
                    # plot no 04: pacf ----
                    plt.nam <- paste(fig.dir, "figure_04_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
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
                      
                      yt.pacf <- forecast::Acf(x = y.sim, lag.max = 10, type = "partial", plot = TRUE,
                                               ylab = "", xlab = "time", main = "",
                                               ylim = c(-0.8, 0.8))
                      
                    }
                    
                    dev.off()
                    
                  }

close(pb)
stopCluster(cl) 
