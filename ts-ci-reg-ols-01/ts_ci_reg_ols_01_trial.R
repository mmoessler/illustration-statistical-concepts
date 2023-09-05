
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ts-ci-reg-ols-01/figures/"

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

# set seed 
set.seed(12345)

# function to simulate b0_hat and b1_hat based cointegrating regression model ----
bet_hat_sim_fun_01 <- function(rr, nn,
                               b0, b1,
                               c1, sig) {
  
  # # input
  # rr <- 1000
  # nn <- 250
  # c1 <- matrix(c(0.75, 0, 0, 0), nrow = 2, ncol = 2)
  # c1
  # sig <- matrix(c(0.5, 0, 0, 0.5), nrow = 2, ncol = 2)
  # sig
  # b0 <- 0.1
  # b1 <- 0.8
  
  
  
  # initialize vectors for sols t.acts
  t.act.0.sols.01 <- numeric(rr) # based on ordinary vcov
  t.act.1.sols.01 <- numeric(rr) 
  t.act.0.sols.02 <- numeric(rr) # based on hc vcov
  t.act.1.sols.02 <- numeric(rr)
  
  # initialize vectors for dols t.acts
  t.act.0.dols.01 <- numeric(rr)
  t.act.1.dols.01 <- numeric(rr)

  # initialize vectors for fmols t.acts
  t.act.0.fmols.01 <- numeric(rr)
  t.act.1.fmols.01 <- numeric(rr)
  
  for (ii in 1:rr) {
    
    # simulate white noise residuals
    et <- MASS::mvrnorm(n = nn, mu = c(0, 0), Sigma = sig)
    # simulate correlated residuals
    ut <- matrix(0, nn, nrow(sig))
    for (tt in (1+1):nn) {
      ut[tt,] <- c1 %*% t(ut[tt-1,,drop = FALSE]) + et[tt,]
    }
    
    # ts.plot(ut[,1])
    # ts.plot(ut[,2])
    # 
    # acf(ut[,1], type = "partial")
    # acf(ut[,2], type = "partial")
    
    y2 <- ut[,2,drop=FALSE]
    y1 <- b0 + b1 * y2 + ut[,1,drop=FALSE]
    yt <- cbind(y1, y2)
    
    head(et)
    head(ut)
    head(yt)
    
    # plot(seq(1, length(y1)), y1, type = "l", col = "blue")
    # lines(seq(1, length(y2)), y2, type = "l", col = "red")
    
    # fit using sols
    sols.fit <- lm(y1 ~ y2 + 1)
    # inference based on ordinary se's
    t.act.0.sols.01[ii] <- (sols.fit$coefficients[1] - b0) / sqrt(diag(sandwich::vcovHC(sols.fit, type = "const")))[1]
    t.act.1.sols.01[ii] <- (sols.fit$coefficients[2] - b1) / sqrt(diag(sandwich::vcovHC(sols.fit, type = "const")))[2]
    # inference based on HC se's
    t.act.0.sols.02[ii] <- (sols.fit$coefficients[1] - b0) / sqrt(diag(sandwich::vcovHC(sols.fit, type = "HC1")))[1]
    t.act.1.sols.02[ii] <- (sols.fit$coefficients[2] - b1) / sqrt(diag(sandwich::vcovHC(sols.fit, type = "HC2")))[2]
    
    # fit using d-ols
    dols.fit <- cointReg::cointRegD(x = y2, y = y1, deter = rep(1, nn))
    t.act.0.dols.01[ii] <- (dols.fit$theta[1] - b0) / sqrt(diag(dols.fit$varmat))[1]
    t.act.1.dols.01[ii] <- (dols.fit$theta[2] - b1) / sqrt(diag(dols.fit$varmat))[2]
    # note: robust inference is based on
    # -> (1) varmat <- Omega.dols[1, 1] * alltrunc.inv
    # -> (2) Omega.dols <- lrvar[[1]]
    
    # fit using fm-ols
    fmols.fit <- cointReg::cointRegFM(x = y2, y = y1, deter = rep(1, nn))
    t.act.0.fmols.01[ii] <- (dols.fit$theta[1] - b0) / sqrt(diag(fmols.fit$varmat))[1]
    t.act.1.fmols.01[ii] <- (dols.fit$theta[2] - b1) / sqrt(diag(fmols.fit$varmat))[2]
    # note: robust inference is based on
    # -> (1) varmat <- Omega.u.v[1, 1] * Zfm2s
    # -> (2) Omega.u.v <- Omega$uu - (Omega$uv %*% Omegavv.inv.vu)
    
  }
  
  ret.lis <- list(et = et, ut = ut, yt = yt,
                  t.act.0.sols.01 = t.act.0.sols.01, t.act.1.sols.01 = t.act.1.sols.01,
                  t.act.0.sols.02 = t.act.0.sols.02, t.act.1.sols.02 = t.act.1.sols.02,
                  t.act.0.dols.01 = t.act.0.dols.01, t.act.1.dols.01 = t.act.1.dols.01,
                  t.act.0.fmols.01 = t.act.0.fmols.01, t.act.1.fmols.01 = t.act.1.fmols.01)
  
  return(ret.lis)
  
}

# input
rr <- 1000
nn <- 250
c1 <- matrix(c(0.75, 0, 0, 0), nrow = 2, ncol = 2)
c1
sig <- matrix(c(0.5, 0, 0, 0.5), nrow = 2, ncol = 2)
sig
b0 <- 0.1
b1 <- 0.8

# sim.res <- bet_hat_sim_fun_01(rr = rr, nn = nn, b0 = b0, b1 = b1, c1 = c1, sig = sig)



# # plot sols ----
# plt.nam <- paste(fig.dir, "figure_sols.svg", sep = "")
# svg(plt.nam)
# 
# set_plt_mar()
# 
# x <- sim.res$t.act.1.sols.01
# 
# # generate histogram of estimator
# h1 <- hist(x = x, freq = FALSE)
# 
# # plot histogram of estimator
# plot.new()
# plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
# title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
# axis(1)
# axis(2)
# grid()
# 
# # plot h1
# nB <- length(h1$breaks)
# rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
# 
# # add pdf for normal distribution
# curve(dnorm(x, mean = 0, sd = 1), -6, 6,
#       lty = 2,
#       lwd = 2, 
#       xlab = "", 
#       ylab = "",
#       add = TRUE,
#       col = "darkgreen")
# 
# dev.off()

# # plot d-ols ----
# plt.nam <- paste(fig.dir, "figure_dols.svg", sep = "")
# svg(plt.nam)
# 
# set_plt_mar()
# 
# x <- sim.res$t.act.1.dols.01
# 
# # generate histogram of estimator
# h1 <- hist(x = x, freq = FALSE)
# 
# # plot histogram of estimator
# plot.new()
# plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
# title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
# axis(1)
# axis(2)
# grid()
# 
# # plot h1
# nB <- length(h1$breaks)
# rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
# 
# # add pdf for normal distribution
# curve(dnorm(x, mean = 0, sd = 1), -6, 6,
#       lty = 2,
#       lwd = 2, 
#       xlab = "", 
#       ylab = "",
#       add = TRUE,
#       col = "darkgreen")
# 
# dev.off()

# # plot fm-ols ----
# plt.nam <- paste(fig.dir, "figure_fmols.svg", sep = "")
# svg(plt.nam)
# 
# set_plt_mar()
# 
# x <- sim.res$t.act.1.fmols.01
# 
# # generate histogram of estimator
# h1 <- hist(x = x, freq = FALSE)
# 
# # plot histogram of estimator
# plot.new()
# plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
# title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
# axis(1)
# axis(2)
# grid()
# 
# # plot h1
# nB <- length(h1$breaks)
# rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
# 
# # add pdf for normal distribution
# curve(dnorm(x, mean = 0, sd = 1), -6, 6,
#       lty = 2,
#       lwd = 2, 
#       xlab = "", 
#       ylab = "",
#       add = TRUE,
#       col = "darkgreen")
# 
# dev.off()





# inputs (variable)
nn.vec <- c(25, 50, 100)
c1.11.vec <- c(-0.5, 0, 0.5)
c1.12.vec <- c(-0.5, 0, 0.5)
c1.21.vec <- c(-0.5, 0, 0.5)
c1.22.vec <- c(-0.5, 0, 0.5)
sig.11.vec <- c(0.5, 1, 1.5)
sig.12.vec <- c(-0.5, 0, 0.5)
sig.22.vec <- c(0.5, 1, 1.5)
sig.21.vec <- c(-0.5, 0, 0.5)

# inputs (fixed)
rr <- 1000
nn <- 100
b0 <- 0
b1 <- 0.75

# set up parallelization ----

# grid for names
tmp.grd <- expand.grid(seq(1,length(nn.vec)),
                       seq(1,length(c1.11.vec)),
                       seq(1,length(c1.12.vec)),
                       seq(1,length(c1.21.vec)),
                       seq(1,length(c1.22.vec)),
                       seq(1,length(sig.11.vec)),
                       seq(1,length(sig.12.vec)),
                       seq(1,length(sig.21.vec)),
                       seq(1,length(sig.22.vec)), stringsAsFactors = FALSE)

pp <- which(tmp.grd[,1] == 3 & tmp.grd[,2] == 2 & tmp.grd[,3] == 2 & tmp.grd[,4] == 2 & tmp.grd[,5] == 2 & tmp.grd[,6] == 2 & tmp.grd[,7] == 2 & tmp.grd[,8] == 2 & tmp.grd[,9] == 2)
pp

library(parallel)
library(doSNOW)
library(doRNG)

# packages needed in the foreach environment
needed.packages <- c("MASS", "scales", "cointReg")

cl <- makeCluster(detectCores() - 1)
registerDoSNOW(cl)

pb <- txtProgressBar(max = nrow(tmp.grd), style = 3)
progress <- function(n) setTxtProgressBar(pb, n)
opts <- list(progress = progress)

# do parallel simulation ----
result <- foreach(ind = 1:nrow(tmp.grd),
                  .packages = needed.packages,
                  .options.snow = opts,
                  .options.RNG = 12345) %dorng% {
                    
                    i1 <- tmp.grd[ind, 1]
                    i2 <- tmp.grd[ind, 2]
                    i3 <- tmp.grd[ind, 3]
                    i4 <- tmp.grd[ind, 4]
                    i5 <- tmp.grd[ind, 5]
                    i6 <- tmp.grd[ind, 6]
                    i7 <- tmp.grd[ind, 6]
                    i8 <- tmp.grd[ind, 6]
                    i9 <- tmp.grd[ind, 6]
                    
                    nn <- nn.vec[i1]
                    c1.11 <- c1.11.vec[i2]
                    c1.12 <- c1.12.vec[i3]
                    c1.21 <- c1.21.vec[i4]
                    c1.22 <- c1.22.vec[i5]
                    sig.11 <- sig.11.vec[i6]
                    sig.12 <- sig.12.vec[i7]
                    sig.21 <- sig.21.vec[i8]
                    sig.22 <- sig.22.vec[i9]
                    
                    c1 <- matrix(c(c1.11, c1.12, c1.21, c1.22), nrow = 2, ncol = 2)
                    sig <- matrix(c(sig.11, sig.12, sig.21, sig.22), nrow = 2, ncol = 2)
                    
                    # simulation
                    tmp.sim <- bet_hat_sim_fun_01(rr = rr, nn = nn,
                                                  b0 = b0, b1 = b1,
                                                  c1 = c1, sig = sig)
                    
                    # plot no 01: sols ----
                    plt.nam <- paste(fig.dir, "figure_01_", i1, "_", i2, "_", i3, "_", i4, "_", i5, "_", i6, "_", i7, "_", i8, "_", i9, ".svg", sep = "")
                    svg(plt.nam)
                    
                      set_plt_mar()
                    
                      x <- tmp.sim$t.act.1.sols.01
                      
                      # generate histogram of estimator
                      h1 <- hist(x = x, freq = FALSE)
                      
                      # plot histogram of estimator
                      plot.new()
                      plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
                      title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
                      axis(1)
                      axis(2)
                      grid()
                      
                      # plot h1
                      nB <- length(h1$breaks)
                      rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
                      
                      # add pdf for normal distribution
                      curve(dnorm(x, mean = 0, sd = 1), -6, 6,
                            lty = 2,
                            lwd = 2, 
                            xlab = "", 
                            ylab = "",
                            add = TRUE,
                            col = "darkgreen")

                    dev.off()
                    
                    # plot no 02: dols ----
                    plt.nam <- paste(fig.dir, "figure_02_", i1, "_", i2, "_", i3, "_", i4, "_", i5, "_", i6, "_", i7, "_", i8, "_", i9, ".svg", sep = "")
                    svg(plt.nam)
                    
                      set_plt_mar()
                      
                      x <- tmp.sim$t.act.1.dols.01
                      
                      # generate histogram of estimator
                      h1 <- hist(x = x, freq = FALSE)
                      
                      # plot histogram of estimator
                      plot.new()
                      plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
                      title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
                      axis(1)
                      axis(2)
                      grid()
                      
                      # plot h1
                      nB <- length(h1$breaks)
                      rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
                      
                      # add pdf for normal distribution
                      curve(dnorm(x, mean = 0, sd = 1), -6, 6,
                            lty = 2,
                            lwd = 2, 
                            xlab = "", 
                            ylab = "",
                            add = TRUE,
                            col = "darkgreen")
                    
                    dev.off()
                    
                    # plot no 03: fmols ----
                    plt.nam <- paste(fig.dir, "figure_03_", i1, "_", i2, "_", i3, "_", i4, "_", i5, "_", i6, "_", i7, "_", i8, "_", i9, ".svg", sep = "")
                    svg(plt.nam)
                    
                      set_plt_mar()
                    
                      x <- tmp.sim$t.act.1.fmols.01
                      
                      # generate histogram of estimator
                      h1 <- hist(x = x, freq = FALSE)
                      
                      # plot histogram of estimator
                      plot.new()
                      plot.window(xlim = c(-6, 6), ylim = c(0, 0.5), log = "")
                      title(main = "", sub = "", xlab = "", ylab = "Relative Frequency")
                      axis(1)
                      axis(2)
                      grid()
                      
                      # plot h1
                      nB <- length(h1$breaks)
                      rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = "grey")
                      
                      # add pdf for normal distribution
                      curve(dnorm(x, mean = 0, sd = 1), -6, 6,
                            lty = 2,
                            lwd = 2, 
                            xlab = "", 
                            ylab = "",
                            add = TRUE,
                            col = "darkgreen")

                    dev.off()
                    
                  }

close(pb)
stopCluster(cl) 
