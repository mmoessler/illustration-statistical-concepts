
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ols-case-04/figures/"

# set seed 
set.seed(12345)

# function to simulate correlated multivariate normal distribution for n=3
tri_mv_nor <- function(mu, sig, rho, nn) {
  
  C <- diag(3)
  C[2,1] <- rho[1]
  C[3,1] <- rho[2]
  C[3,2] <- rho[3]
  C[1,2] <- rho[1]
  C[1,3] <- rho[2]
  C[2,3] <- rho[3]
  
  V <- diag(sig) %*% C %*% diag(sig)
  
  y <- MASS::mvrnorm(n = nn, mu = mu, Sigma = V)
  
  y
  
}

# function to simulate b0_hat and b1_hat based on normal distribution ----
bet_hat_sim_fun_01 <- function(rr, nn,
                               b0, b1, b2,
                               x1.sd, x2.sd, z.sd, u.sd,
                               rho.21, rho.z1,
                               g0, g1){
  
  # # inputs for checks
  # rr <- 1000
  # nn <- 100
  # b0 <- 10
  # b1 <- 1
  # b2 <- 0
  # x1.sd <- 1
  # x2.sd <- 1
  # z.sd <- 1
  # u.sd <- 1
  # rho.21 <- 0.9
  # rho.z1 <- 0
  # g0 <- 0
  # g1 <- 0
  
  
  
  # initialize vectors for simulation results
  b0h <- numeric(rr)
  b1h <- numeric(rr)
  
  var.b0 <- numeric(rr)
  var.b1 <- numeric(rr)
  var.b1.ord <- numeric(rr)
  
  b0h.z <- numeric(rr)
  b1h.z <- numeric(rr)
  b1h.z.ord <- numeric(rr)
  
  x1.pre <- cbind(1, seq(-100, 100, 1))
  pre.mat.05 <- matrix(NA, nrow = nrow(x1.pre), ncol = rr) # based on biased/observed fit
  pre.mat.06 <- matrix(NA, nrow = nrow(x1.pre), ncol = rr) # based on true/unobserved fit
  pre.mat.07 <- matrix(NA, nrow = nrow(x1.pre), ncol = rr) # tru/unobserved residuals on x1
  
  for (ii in 1:rr) {
    
    # simulate bivariate normal data
    x <- tri_mv_nor(mu = cbind(0, 0, 0),
                    sig = c(x1.sd, x2.sd, z.sd),
                    rho = c(rho.21, rho.z1, 0),
                    nn = nn)
    
    # construct rhs series
    x1 <- x[,1,drop=FALSE]
    x2 <- x[,2,drop=FALSE]
    z <-  x[,3,drop=FALSE]
    u  <- sqrt( exp(g0 + g1 * x1) ) * rnorm(nn, 0, u.sd)
    
    # construct lhs series
    y <- b0 + b1 * x1 + b2 * x2 + u 
    
    # fit linear model
    fit.01 <- lm(y - b2 * x2 ~ x1 + 1) # correct/unobserved fit
    # fit.02 <- lm(y ~ x2 + 1) # y corrected for unobserved x2
    # fit.03 <- lm(x1 ~ x2 + 1) # x1 corrected for unobserved x2
    # fit.04 <- lm(fit.x1$residuals ~ fit.x2$residuals + 1) # correct/unobserved fit
    fit.05 <- lm(y ~ x1 + 1) # biased/observed fit
    fit.06 <- lm(I(y - b2 * x2) ~ I(x1 - b2 * x2) + 1) # constructed correct/unobserved fit (vs. fit.03 - fit.05)
    
    # get some residuals
    res.01 <- fit.01$residuals + b2 * x2 # correlated correct/unobserved residuals
    res.02 <- y - b2 * x2
    res.03 <- x1 - b2 * x2
  
    # regression of residuals on x1
    fit.07 <- lm(res.01 ~ x1)
  
    # get some predictions
    pre.mat.05[,ii] <- x1.pre %*% cbind(fit.05$coefficients)
    pre.mat.06[,ii] <- x1.pre %*% cbind(fit.06$coefficients)
    pre.mat.07[,ii] <- x1.pre %*% cbind(fit.07$coefficients)
      
    # get some estimates
    b0h[ii] <- fit.05$coefficients[1] # biased coefficients
    b1h[ii] <- fit.05$coefficients[2]
    
    # compute the variance of beta_hat_0
    # note, only correct for simple regression, i.e., for b2=0!
    hi <- 1 - mean(x1) / mean(x1^2) * x1
    var.b0[ii] <- var(hi * u) / (nn * mean(hi^2)^2)
    # compute the variance of hat_beta_1
    # var.b1[ii] <- var( ( x1 - mean(x1) ) * u ) / ( nn * var(x1)^2 ) # robust
    var.b1[ii] <- var( ( x1 - mean(x1) ) * (u + b2 * x2) ) / ( nn * var(x1)^2 ) # robust
    # var.b1.ord[ii] <- var( u ) / ( nn * var(x1) ) # ordinary
    var.b1.ord[ii] <- var( (u + b2 * x2) ) / ( nn * var(x1) ) # ordinary
    
    # compute t-statistics
    b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii]) # robust
    b1h.z.ord[ii] <- (b1h[ii] - b1) / sqrt(var.b1.ord[ii]) # ordinary
    
    b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
    
    # 1st stage
    fit.08 <- lm(x1 ~ z - 1)
    # 2nd stage
    fit.09 <- lm(y ~ fit.08$fitted.values - 1)
    
    # or, see, s&w, equ. 12.04
    szy <- crossprod(z, y) / nn
    szx <- crossprod(z, x1) / nn
    szy / szx
    fit.08$coefficients
    
  }
  
  # bootstrap analysis of bias
  b1h.boot.mea <- 1/rr * sum(b1h)
  b1h.z.boot.mea <- 1/rr * sum(b1h.z)
  b1h.z.boot.sd <- 1/(rr - 1) * sum((b1h.z - b1h.z.boot.mea)^2)
  
  b0h.boot.mea <- 1/rr * sum(b0h)
  b0h.z.boot.mea <- 1/rr * sum(b0h.z)
  b0h.z.boot.sd <- 1/(rr - 1) * sum((b0h.z - b0h.z.boot.mea)^2)
  
  pre.low.05 <- apply(pre.mat.05, 1, function(x){ quantile(x, 0.025, na.rm = TRUE) })
  pre.upp.05 <- apply(pre.mat.05, 1, function(x){ quantile(x, 0.975, na.rm = TRUE) })
  pre.low.06 <- apply(pre.mat.06, 1, function(x){ quantile(x, 0.025, na.rm = TRUE) })
  pre.upp.06 <- apply(pre.mat.06, 1, function(x){ quantile(x, 0.975, na.rm = TRUE) })
  pre.low.07 <- apply(pre.mat.07, 1, function(x){ quantile(x, 0.025, na.rm = TRUE) })
  pre.upp.07 <- apply(pre.mat.07, 1, function(x){ quantile(x, 0.975, na.rm = TRUE) })
  
  pre.min.05 <- apply(pre.mat.05, 1, function(x){ min(x, na.rm = TRUE) })
  pre.max.05 <- apply(pre.mat.05, 1, function(x){ max(x, na.rm = TRUE) })
  pre.min.06 <- apply(pre.mat.06, 1, function(x){ min(x, na.rm = TRUE) })
  pre.max.06 <- apply(pre.mat.06, 1, function(x){ max(x, na.rm = TRUE) })
  pre.min.07 <- apply(pre.mat.07, 1, function(x){ min(x, na.rm = TRUE) })
  pre.max.07 <- apply(pre.mat.07, 1, function(x){ max(x, na.rm = TRUE) })
  
  ret.lis <- list(b0h = b0h, b1h = b1h,
                  y = y, x1 = x1, x2 = x2, z = z, u = u,
                  var.b0 = var.b0, var.b1 = var.b1, var.b1.ord = var.b1.ord,
                  b0h.z = b0h.z, b1h.z = b1h.z, b1h.z.ord = b1h.z.ord,
                  b1h.z.boot.mea = b1h.z.boot.mea, b1h.z.boot.sd = b1h.z.boot.sd, b1h.boot.mea = b1h.boot.mea,
                  b0h.z.boot.mea = b0h.z.boot.mea, b0h.z.boot.sd = b0h.z.boot.sd, b0h.boot.mea = b0h.boot.mea,
                  fit.01 = fit.01,
                  # fit.02 = fit.02, fit.03 = fit.03, fit.04 = fit.04,
                  fit.05 = fit.05, fit.06 = fit.06, fit.07 = fit.07, fit.08 = fit.08, fit.09 = fit.09,
                  res.01 = res.01, res.02 = res.02, res.03 = res.03,
                  pre.low.05 = pre.low.05, pre.upp.05 = pre.upp.05,
                  pre.low.06 = pre.low.06, pre.upp.06 = pre.upp.06,
                  pre.low.07 = pre.low.07, pre.upp.07 = pre.upp.07,
                  pre.min.05 = pre.min.05, pre.max.05 = pre.max.05,
                  pre.min.06 = pre.min.06, pre.max.06 = pre.max.06,
                  pre.min.07 = pre.min.07, pre.max.07 = pre.max.07,
                  fit.05.pre = x1.pre %*% cbind(fit.05$coefficients),
                  fit.06.pre = x1.pre %*% cbind(fit.06$coefficients),
                  fit.07.pre = x1.pre %*% cbind(fit.07$coefficients),
                  x1.pre = x1.pre)
  
  return(ret.lis)
  
}

# inputs (variable)
nn.vec <- c(5, 10, 25, 50, 100)
b1.vec <- c(-1, 0, 1)
b2.vec <- c(-1, 0, 1)
rho.vec <- c(-0.9, -0.5, 0, 0.5, 0.9)

# nn.vec <- c(5, 100)
# b1.vec <- c(-1, 1)
# b2.vec <- c(-1, 1)
# rho.vec <- c(-0.9, 0.9)

# inputs (fixed)
rr <- 10000
nn <- 100
b0 <- -10
b1 <- 1
b2 <- 0
x1.sd <- 10
x2.sd <- 10
z.sd <- 10
u.sd <- 10
rho.21 <- 0
rho.z1 <- 0
g0 <- 0
g1 <- 0

# set up parallelization ----

# grid for names
tmp.grd <- expand.grid(seq(1,length(nn.vec)), seq(1,length(b1.vec)), seq(1,length(b2.vec)), seq(1,length(rho.vec)), stringsAsFactors = FALSE)
run.vec <- seq(1,nrow(tmp.grd))

library(parallel)
library(doSNOW)
library(doRNG)

# packages needed in the foreach environment
needed.packages <- c("MASS", "scales")

cl <- makeCluster(detectCores() - 1)
registerDoSNOW(cl)

pb <- txtProgressBar(max = nrow(tmp.grd), style = 3)
progress <- function(n) setTxtProgressBar(pb, n)
opts <- list(progress = progress)

# dp parallel simulation ----
result <- foreach(rr = run.vec,
                  .packages = needed.packages,
                  .options.snow = opts,
                  # .verbose = T,
                  .options.RNG = 12345) %dorng% {
                    
                    ii <- tmp.grd[rr, 1]
                    jj <- tmp.grd[rr, 2]
                    kk <- tmp.grd[rr, 3]
                    ll <- tmp.grd[rr, 4]
                    
                    nn <- nn.vec[ii]
                    b1 <- b1.vec[jj]
                    b2 <- b2.vec[kk]
                    rho.21 <- rho.vec[ll]
                    
                    # simulation
                    tmp.sim <- bet_hat_sim_fun_01(rr = rr, nn = nn,
                                                  b0 = b0, b1 = b1, b2 = b2,
                                                  x1.sd = x1.sd, x2.sd = x2.sd, z.sd = z.sd, u.sd = u.sd,
                                                  rho.21 = rho.21, rho.z1 = rho.z1, g0 = g0, g1 = g1)
                    
                    # plot no 01: scatterplot obsevations ----
                    plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
                    svg(plt.nam) 
                    
                    plot.new()
                    plot.window(xlim = c(-100, 100), ylim = c(-100, 100), log = "")
                    title(main = "", sub = "", xlab = expression(X[1]^obs~and~X[1]^unobs), ylab = expression(Y^obs~and~Y^unobs))
                    
                    axis(1)
                    axis(2)
                    
                    grid()
                    
                    # add polygon biased/observed
                    x.pol <- c(seq(-100, 100, 1), rev(seq(-100, 100, 1)))
                    y.pol <- c(tmp.sim$pre.max.05, rev(tmp.sim$pre.min.05))
                    ii <- which(y.pol >=- 100 & y.pol <= 100)
                    polygon(x.pol[ii], y.pol[ii], border = NA, col = scales::alpha("red", 0.25))
                    
                    # add polygon unbiased/unobserved
                    x.pol <- c(seq(-100, 100, 1), rev(seq(-100, 100, 1)))
                    y.pol <- c(tmp.sim$pre.max.06, rev(tmp.sim$pre.min.06))
                    ii <- which(y.pol >= -100 & y.pol <= 100)
                    polygon(x.pol[ii], y.pol[ii], border = NA, col = scales::alpha("darkgreen", 0.25))
                    
                    # add points biased/observed
                    lines(x = tmp.sim$x1, y = tmp.sim$y, type = "p", col = "red")
                    
                    # add points unbiased/unobserved
                    lines(x = tmp.sim$res.03, y = tmp.sim$res.02, type = "p", col = "darkgreen")
                    
                    # add line biased/observed
                    ii <- which(tmp.sim$x1.pre[,2] >= -100 & tmp.sim$x1.pre[,2] <= 100 & tmp.sim$fit.05.pre >= -100 & tmp.sim$fit.05.pre <= 100)
                    lines(x = tmp.sim$x1.pre[ii,2], y = tmp.sim$fit.05.pre[ii], lty = 2, col = "red", lwd = 2)
                    
                    # add line unbiased/unobserved
                    ii <- which(tmp.sim$x1.pre[,2] >= -100 & tmp.sim$x1.pre[,2] <= 100 & tmp.sim$fit.06.pre >= -100 & tmp.sim$fit.06.pre <= 100)
                    lines(x = tmp.sim$x1.pre[ii,2], y = tmp.sim$fit.06.pre[ii], lty = 2, col = "darkgreen", lwd = 2)
                    
                    # add text
                    rect(xleft = 45, ybottom = 67.5, xright = 95, ytop = 97.5, col = "white")
                    
                    text(x = 70, y = 90,
                         bquote(widehat(beta)[1] == .(format(round(summary(tmp.sim$fit.05)$coefficients[2,1], 3), nsmall = 3))),
                         cex = 1.25)
                    text(x = 70, y = 75,
                         bquote(widehat(sigma)[widehat(beta)[1]] == .(format(round(summary(tmp.sim$fit.05)$coefficients[2,2], 3), nsmall = 3))),
                         cex = 1.25)
                    
                    # add legend
                    legend("topleft",
                           legend = c("Unobserved", "Observed"),
                           lty = c(2, 2),
                           lwd = c(1, 1),
                           col = c("darkgreen", "red"),
                           inset = 0.05)
                    
                    dev.off()
                    
                    # plot no 02: scatterplot fitted residuals ----
                    plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
                    svg(plt.nam) 
                    
                    plot.new()
                    plot.window(xlim = c(-100, 100), ylim = c(-100, 100), log = "")
                    title(main = "", sub = "", xlab = expression(X[1]^obs), ylab = expression(u^unobs))
                    
                    axis(1)
                    axis(2)
                    
                    grid()
                    
                    # add polygon
                    x.pol <- c(seq(-100, 100, 1), rev(seq(-100, 100, 1)))
                    y.pol <- c(tmp.sim$pre.max.07, rev(tmp.sim$pre.min.07))
                    ii <- which(y.pol >=- 100 & y.pol <= 100)
                    polygon(x.pol[ii], y.pol[ii], border = NA, col = scales::alpha("darkgreen", 0.25))
                    
                    # add points
                    lines(x = tmp.sim$x1, y = tmp.sim$res.01, type = "p", col = "darkgreen")
                    
                    # add zero line
                    lines(x = seq(-100, 100, 1), y = rep(0, length(seq(-100, 100, 1))), lty = 2, lwd = 2)
                    
                    # added fitted regression line        
                    ii <- which(tmp.sim$x1.pre[,2] >= -100 & tmp.sim$x1.pre[,2] <= 100 & tmp.sim$fit.07.pre >= -100 & tmp.sim$fit.07.pre <= 100)
                    lines(x = tmp.sim$x1.pre[ii,2], y = tmp.sim$fit.07.pre[ii], lty = 2, col = "darkgreen", lwd = 2)
                    
                    # add legend
                    legend("topright",
                           # legend = c(expression("Fitted residuals "*u[i]*" ")),
                           legend = c(expression("Unobserved")),
                           lty = 2,
                           lwd = 1,
                           col = "darkgreen",
                           inset = 0.05)
                    
                    dev.off()
                    
                    # plot no 03: histogram estimator (non-standardized ----
                    plt.nam <- paste(fig.dir, "figure_03_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
                    svg(plt.nam) 
                    
                    x <- hist(x = tmp.sim$b1h,
                              freq = FALSE,
                              plot = FALSE)
                    
                    # plot histogram of estimator
                    plot.new()
                    plot.window(xlim = c(-3, 3), ylim = c(0, 12), log = "")
                    title(main = "", sub = "", xlab = "", ylab = "Absolute frequency")
                    axis(1)
                    axis(2)
                    grid()
                    
                    # add bars of histogram
                    nbx <- length(x$breaks[which(x$counts > 0)])
                    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
                         col = "grey")
                    
                    # add line for population parameter
                    abline(v = b1, lty = 2, col = "darkgreen", lwd = 2)
                    
                    # add line for estimated parameter
                    abline(v = tmp.sim$b1h.boot.mea, lty = 2, col = "red", lwd = 2)
                    
                    # add legend
                    legend("topleft",
                           legend = c(expression("True value of "*beta[1]*" "), expression("Biased value of "*beta[1]*" ")),
                           lty = c(2, 2),
                           lwd = c(1, 1),
                           col = c("darkgreen", "red"),
                           inset = 0.05)
                    
                    dev.off()
                    
                    # plot no 04 histogram estimator (standardized) ----
                    plt.nam <- paste(fig.dir, "figure_04_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
                    svg(plt.nam)
                    
                    # generate histogram of estimator
                    h1 <- hist(x = tmp.sim$b1h.z, freq = FALSE)
                    h2 <- hist(x = tmp.sim$b1h.z.ord, freq = FALSE)
                    
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
                    
                    # # plot h2
                    # nB <- length(h2$breaks)
                    # rect(h2$breaks[-nB], 0, h2$breaks[-1L], h2$density, col = scales::alpha("red", 0.25))
                    
                    # add pdf for normal distribution
                    curve(dnorm(x, mean = 0, sd = 1), -6, 6,
                          lty = 2,
                          lwd = 2, 
                          xlab = "", 
                          ylab = "",
                          add = TRUE,
                          col = "red")
                    
                    # # add legend no 01
                    # legend("topleft",
                    #        legend = c(expression("using robust"*~italic("SE")), expression("using ordinary"*~italic("SE"))),
                    #        fill =  c(scales::alpha("darkgreen", 0.25), scales::alpha("red", 0.25)),
                    #        inset = 0.05)
                    
                    # add legend no 03
                    legend("topright",
                           legend = c(expression("pdf of "*italic("N")*"(0,1)")),
                           lty = 2,
                           lwd = 1,
                           col = "red",
                           inset = 0.05)
                    
                    dev.off()
                    
                  }

close(pb)
stopCluster(cl) 
