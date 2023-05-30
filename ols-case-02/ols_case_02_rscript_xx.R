
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./ols-case-02/figures/"

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
  # b0 <- 1
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
    fit.01 <- lm(y ~ x1 + x2 + 1) # correct/unobserved fit
    fit.02 <- lm(y ~ x1 + 1)      # biased/observed fit
    
    # get some residuals
    res.01 <- y - fit.01$fitted.values + b2 * x2 # correlated correct/unobserved residuals
    
    # regression of residuals on x1
    fit.03 <- lm(res.01 ~ x1)
    
    # get some estimates
    b0h[ii] <- fit.02$coefficients[1] # biased coefficients
    b1h[ii] <- fit.02$coefficients[2]
    
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
    fit.04 <- lm(x1 ~ z - 1)
    # 2nd stage
    fit.05 <- lm(y ~ fit.03$fitted.values - 1)
    
    # or, see, s&w, equ. 12.04
    szy <- crossprod(z, y) / nn
    szx <- crossprod(z, x1) / nn
    szy / szx
    fit.04$coefficients
    
  }
  
  # bootstrap analysis of bias
  b1h.boot.mea <- 1/rr * sum(b1h)
  b1h.z.boot.mea <- 1/rr * sum(b1h.z)
  b1h.z.boot.sd <- 1/(rr - 1) * sum((b1h.z - b1h.z.boot.mea)^2)
  
  b0h.boot.mea <- 1/rr * sum(b0h)
  b0h.z.boot.mea <- 1/rr * sum(b0h.z)
  b0h.z.boot.sd <- 1/(rr - 1) * sum((b0h.z - b0h.z.boot.mea)^2)
  
  ret.lis <- list(b0h = b0h, b1h = b1h,
                  y = y, x1 = x1, x2 = x2, z = z, u = u,
                  var.b0 = var.b0, var.b1 = var.b1, var.b1.ord = var.b1.ord,
                  b0h.z = b0h.z, b1h.z = b1h.z, b1h.z.ord = b1h.z.ord,
                  b1h.z.boot.mea = b1h.z.boot.mea, b1h.z.boot.sd = b1h.z.boot.sd, b1h.boot.mea = b1h.boot.mea,
                  b0h.z.boot.mea = b0h.z.boot.mea, b0h.z.boot.sd = b0h.z.boot.sd, b0h.boot.mea = b0h.boot.mea,
                  fit.01 = fit.01, fit.02 = fit.02, fit.03 = fit.03, fit.04 = fit.04, fit.05 = fit.05,
                  res.01 = res.01)
  
  return(ret.lis)
  
}

# inputs (variable)
nn.vec <- c(5, 10, 25, 50, 100)
x1.sd.vec <- c(1, 5, 10)
u.sd.vec <- c(1, 5, 10)
g1.vec <- c(-0.2, -0.1, 0, 0.1, 0.2)

nn.vec <- c(5, 100)
x1.sd.vec <- c(1, 15)
u.sd.vec <- c(1, 15)
g1.vec <- c(-0.2, 0.2)

# inputs (fixed)
rr <- 1000
b1 <- 1
b0 <- 1
b2 <- 0
x2.sd <- 1
z.sd <- 1
rho.21 <- 0
rho.z1 <- 0
g0 <- 0

# simulation/illustration ----
run.all <- length(nn.vec) * length(x1.sd.vec) * length(u.sd.vec) * length(g1.vec)
pb = txtProgressBar(min = 0, max = run.all, initial = 0) 
run <- 1

for (ii in 1:length(nn.vec)) {
  
  for (jj in 1:length(x1.sd.vec)) {
    
    for (kk in 1:length(u.sd.vec)) {
      
      for (ll in 1:length(g1.vec)) {
        
        setTxtProgressBar(pb, run)
        
        nn <- nn.vec[ii]
        x1.sd <- x1.sd.vec[jj]
        u.sd <- u.sd.vec[kk]
        g1 <- g1.vec[ll]
        
        # simulation
        tmp.sim <- bet_hat_sim_fun_01(rr = rr, nn = nn,
                                      b0 = b0, b1 = b1, b2 = b2,
                                      x1.sd = x1.sd, x2.sd = x2.sd, z.sd = z.sd, u.sd = u.sd,
                                      rho.21 = rho.21, rho.z1 = rho.z1, g0 = g0, g1 = g1)
        
        # fit linear model
        lm.tmp <- lm(tmp.sim$y ~ tmp.sim$x1 + 1)
        
        # plot no 01: scatterplot obsevations ----
        plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
        svg(plt.nam) 
        
        plot.new()
        plot.window(xlim = c(-100, 100), ylim = c(-100, 100), log = "")
        title(main = "", sub = "", xlab = "", ylab = "")
        
        axis(1)
        axis(2)
        
        grid()
        
        lines(x = tmp.sim$x1, y = tmp.sim$y, type = "p", col = "red")
        
        abline(a = summary(lm.tmp)$coefficients[1,1], b = summary(lm.tmp)$coefficients[2,1], lty = 2, col = "red", lwd = 2)

        rect(xleft = 45, ybottom = 67.5, xright = 95, ytop = 97.5, col = "white")
        
        text(x = 70, y = 90,
             bquote(widehat(beta)[1] == .(format(round(summary(lm.tmp)$coefficients[2,1], 3), nsmall = 3))),
             cex = 1.25)
        text(x = 70, y = 75,
             bquote(widehat(sigma)[widehat(beta)[1]] == .(format(round(summary(lm.tmp)$coefficients[2,2], 3), nsmall = 3))),
             cex = 1.25)
        
        dev.off()
        
        # plot no 01: scatterplot fitted residuals ----
        plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
        svg(plt.nam) 
        
        plot.new()
        plot.window(xlim = c(-100, 100), ylim = c(-10, 10), log = "")
        title(main = "", sub = "", xlab = "", ylab = "")
        
        axis(1)
        axis(2)
        
        grid()
        
        lines(x = tmp.sim$x1, y = tmp.sim$res.01, type = "p", col = "red")
        
        # add zero line
        abline(h = 0, lty = 2, lwd = 2)
        
        # add legend
        legend("topright",
               legend = c(expression("Fitted residuals "*u[i]*" ")),
               lty = 2,
               lwd = 1,
               col = "red",
               inset = 0.05)

        dev.off()
        
        # plot no 02: histogram estimator (non-standardized ----
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
        
        # add line for population mean
        abline(v = b1, lty = 2, col = "red", lwd = 2)
        
        # add legend
        legend("topleft",
               legend = c(expression("Value of "*beta[1]*" ")),
               lty = 2,
               lwd = 1,
               col = "red",
               inset = 0.05)
        
        dev.off()
        
        # plot no 03 histogram estimator (standardized) ----
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
        rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = scales::alpha("darkgreen", 0.25))
        
        # plot h2
        nB <- length(h2$breaks)
        rect(h2$breaks[-nB], 0, h2$breaks[-1L], h2$density, col = scales::alpha("red", 0.25))
        
        # add pdf for normal distribution
        curve(dnorm(x, mean = 0, sd = 1), -6, 6,
              lty = 2,
              lwd = 2, 
              xlab = "", 
              ylab = "",
              add = TRUE,
              col = "red")
        
        # add legend no 01
        legend("topleft",
               legend = c(expression("using robust"*~italic("SE")), expression("using ordinary"*~italic("SE"))),
               fill =  c(scales::alpha("darkgreen", 0.25), scales::alpha("red", 0.25)),
               inset = 0.05)
        
        # add legend no 03
        legend("topright",
               legend = c(expression("pdf of "*italic("N")*"(0,1)")),
               lty = 2,
               lwd = 1,
               col = "red",
               inset = 0.05)
        
        dev.off()
        
        run <- run + 1
        
      }
      
    }

  }
  
}
