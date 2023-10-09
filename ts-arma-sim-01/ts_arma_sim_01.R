
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ts-arma-sim-01/figures/"

# load libraries
library(plotrix)
library(forecast)

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

#--------------------------------------------------------------------
# Returns a matrix (or vector) stripped of the specified rows
#
#   Inputs: 
#             x  = input matrix (or vector) (n x k)
#             rb = first n1 rows to strip
#             re = last  n2 rows to strip
#
#--------------------------------------------------------------------
trimr <- function(x,rb,re) {
  x <- cbind(x)
  n <- nrow(x)
  if ((rb+re) >= n) {
    stop('Attempting to trim too much')
  }
  z <- x[(rb+1):(n-re),]
  return(z)  
}

#--------------------------------------------------------------------
# Computes a vector of autoregressive recursive series
#
#   Inputs: 
#             x  = a matrix of dimensions (n,k) (exogenous variables)
#             y0 = a matrix of dimensions (p,k) (starting values)
#             a  = a matrix of dimensions (p,k) (lag parameters)
#
#  Mimics the Gauss routine. 
#--------------------------------------------------------------------
recserar <- function(x,y0,a){
  rx <- nrow(x)
  cx <- ncol(x)
  
  ry <- nrow(y0)
  cy <- ncol(y0)
  
  ra <- nrow(a)
  ca <- ncol(a)
  nargin <- length(as.list(match.call())) - 1      
  if ((nargin != 3) 
      || (cx != cy) 
      || (cx != ca) 
      || (ry != ra)) {
    stop('Check function inputs')    
  }    
  y <- array(0, c(rx,cx))
  for (j in 1:ry){
    y[j,] <- y0[j,]    
  }
  for (j in (ry+1):rx){
    y[j,] <- x[j,]
    for (k in 1:ry) {
      y[j,] <- y[j,] + a[k,] * y[j-k,]
    }     
  }   
  return(y)
}

# set seed 
set.seed(12345)

# function to simulate arma(2,2) models ----
# -> see MHH: stsm_simulate.R
arma_sim_fun <- function(ar1, ar2, ma1, ma2, sig = 1, tt = 100) {
  
  y.sim <- NULL
  
  mue <- 0
  phi1 <- ar1
  phi2 <- ar2
  si1 <- ma1
  si2 <- ma2
  
  # Generate error process
  ut <- sig*rnorm(tt) # No additional 100 observations
  yt <- recserar( cbind(mue + trimr(ut,2,0) + si1*trimr(ut,1,1)+ si2*trimr(ut,0,2)) , cbind(c(0.0, 0.0)) , cbind(c(phi1,phi2)))  
  # yt <- trimr(yt,100,0)
  
  y.sim <- yt
  
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
                        
                        plot(y.sim, xlab = "time", ylab = "Value", ylim = c(-6, 6), type = "l")
                        abline(a = 0, b = 0, col = "red")
                        
                      }
                      
                    dev.off()
                    
                    # plot no 02: polyroot ----
                    plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
                    svg(plt.nam) 
                    
                      if (ar1 == 0 & ar2 == 0) {
                        plot(0, 0,
                             col = "red", cex = 1.5, lwd = 3,
                             ylim = c(-1.5, 1.5), xlim = c(-1.5, 1.5),
                             xlab = c("Real Part"),
                             ylab = c("Imaginary Part"),
                             asp = 1)
                      } else {
                        plot(1/polyroot(c(1, -c(ar1, ar2))),
                             col = "red", cex = 1.5, lwd = 3,
                             ylim = c(-1.5, 1.5), xlim = c(-1.5, 1.5),
                             xlab = c("Real Part"),
                             ylab = c("Imaginary Part"),
                             asp = 1)
                      }
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
                                                ylab = "", xlab = "lag", main = "",
                                                ylim = c(-1, 1))
                        
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
                                               ylab = "", xlab = "lag", main = "",
                                               ylim = c(-1, 1))
                      
                    }
                    
                    dev.off()
                    
                  }

close(pb)
stopCluster(cl) 
