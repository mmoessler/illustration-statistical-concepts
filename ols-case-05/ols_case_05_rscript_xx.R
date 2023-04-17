
# remove all objects
rm(list=ls())

# set working directory
setwd("./ols-case-05")

# load texreg extract functions
library(texreg)
source("../r-scripts/texreg_extract_fun_xx.R")

# set seed 
set.seed(12345)

# function to simulate b0_hat and b1_hat ----
bet_hat_sim_fun <- function(RR, NN,
                            b0, b1, b2,
                            X1.int, X2.int,
                            u.sd,
                            rho){
  
  # initialize vectors for simulation results
  b0h <- numeric(RR)
  b1h <- numeric(RR)
  
  var.b0 <- numeric(RR)
  var.b1 <- numeric(RR)
  
  b0h.z <- numeric(RR)
  b1h.z <- numeric(RR)
  
  for (ii in 1:RR) {
    
    X1 <- runif(NN, min = 0 - X1.int/2, max = 0 + X1.int/2)
    X2 <- runif(NN, min = 0 - X2.int/2, max = 0 + X2.int/2)
    
    X1.sd <- 1/12*((0 + X1.int/2) - (0 - X1.int/2))^2
    X2.sd <- 1/12*((0 + X2.int/2) - (0 - X2.int/2))^2
    
    # m.12 <- rho * (X2.sd/X1.sd)
    # X1 <- m.12 * X2 
    m.21 <- rho * (X1.sd/X2.sd)
    X2 <- m.21 * X1
    
    u <- rnorm(NN, mean = 0, sd = u.sd)
    Y1 <- b0 + b1 * X1 + b2 * X2 + u # "measured/observed" relationship
    Y2 <- b0 + b1 * X1 + u # "true" relationship
    
    tmp <- lm(Y1 ~ X1 + 1)
    
    # get estimates
    b0h[ii] <- tmp$coefficients[1]
    b1h[ii] <- tmp$coefficients[2]
    
    # compute the variance of beta_hat_0
    Hi <- 1 - mean(X1) / mean(X1^2) * X1
    var.b0[ii] <- var(Hi * u) / (NN * mean(Hi^2)^2)
    # compute the variance of hat_beta_1
    var.b1[ii] <- var( ( X1 - mean(X1) ) * u ) / ( NN * var(X1)^2 )
    
    # compute t-statistics
    b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii])
    b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
    
  }
  
  return(list(b0h = b0h, b1h = b1h,
              Y1 = Y1, Y2 = Y2, X1 = X1, X2 = X2, u = u,
              var.b0 = var.b0, var.b1 = var.b1,
              b0h.z = b0h.z, b1h.z = b1h.z))
  
}

# inputs (variable)
b2.vec <- seq(-3, 3, 1)
rho.vec <- seq(-1, 1, 0.2)

# inputs (fixed)
RR <- 1000
NN <- 100
b0 <- 1
b1 <- 1
X1.int <- 80
X2.int <- 80
u.sd <- 1

# plot inputs
xlim.01 <- c(-60, 60) # scatterplot
ylim.01 <- c(-100, 100)

xlim.02 <- c(-6, 6) # histogram (lln)
ylim.02.max <- 10

xlim.03 <- c(-6, 6) # histogram (clt)
ylim.03.max <- 0.5

rect.xleft.01 <- -60 # potion rectangle in scatterplot
rect.ybottom.01 <- 30
rect.xright.01 <- -20
rect.ytop.01 <- 95

text.x.01 <- -40 # position text line 01
text.y.01 <- 80
     
text.x.02 <- -40 # position text line 02
text.y.02 <- 50

# simulation

pb = txtProgressBar(min = 0, max = length(b2.vec), initial = 0) 

for (ii in 1:length(b2.vec)) {
  
  setTxtProgressBar(pb, ii)
  
  for (jj in 1:length(rho.vec)) {
  
    b2 <- b2.vec[ii]
    rho <- rho.vec[jj]
    
    #..................................................
    # 1) call sim function ----
    tmp.sim <- bet_hat_sim_fun(RR = RR, NN = NN,
                               b0 = b0, b1 = b1, b2 = b2,
                               X1.int = X1.int, X2.int = X2.int,
                               u.sd = u.sd, rho = rho)
    
    #..................................................
    # 2) fit linear model ----
    lm.01.tmp <- lm(tmp.sim$Y1 ~ tmp.sim$X1 + 1)
    lm.02.tmp <- lm(tmp.sim$Y2 ~ tmp.sim$X1 + 1)
    
    #..................................................
    # 3) scatterplot ----
    
    plt.nam <- paste("plot_01_b2", b2, "_rho", rho*10, ".svg", sep = "")
    svg(plt.nam) 
    
    # plot(x = tmp.sim$X, y = tmp.sim$Y,
    #      xlab = "X", ylab = "Y",
    #      xlim = c(-50, 50), ylim = c(-150, 150))
    # abline(a = b0, b = b1, lty = 2, col = "red", lwd = 2)
    
    main <- c("")
    sub <- c("")
    xlab <- c("X")
    ylab <- c("Y")
    
    xlim <- xlim.01
    ylim <- ylim.01
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    
    axis(1)
    axis(2)
    
    grid()
    
    lines(x = tmp.sim$X1, y = tmp.sim$Y1, type = "p", col = "red")
    lines(x = tmp.sim$X1, y = tmp.sim$Y2, type = "p", col = "darkgreen")
    
    abline(a = summary(lm.01.tmp)$coefficients[1,1], b = summary(lm.01.tmp)$coefficients[2,1], lty = 2, col = "red", lwd = 2)
    abline(a = summary(lm.02.tmp)$coefficients[1,1], b = summary(lm.02.tmp)$coefficients[2,1], lty = 2, col = "darkgreen", lwd = 2)
    
    rect(xleft = rect.xleft.01, ybottom = rect.ybottom.01, xright = rect.xright.01, ytop = rect.ytop.01, col = "white")
    
    text(x = text.x.01, y = text.y.01,
         # bquote(widehat(beta)[1] == .(round(summary(lm.tmp)$coefficients[2,1], 3))),
         bquote(widehat(beta)[1] == .(format(round(summary(lm.01.tmp)$coefficients[2,1], 3), nsmall = 3))),
         cex = 1.25)
    text(x = text.x.02, y = text.y.02,
         # bquote(widehat(sigma)[widehat(beta)[1]] == .(round(summary(lm.tmp)$coefficients[2,2], 3))),
         bquote(widehat(sigma)[widehat(beta)[1]] == .(format(round(summary(lm.01.tmp)$coefficients[2,2], 3), nsmall = 3))),
         cex = 1.25)
    
    dev.off()
    
    #..................................................
    # 4) linear model fit ----
    
    # tab.nam <- paste("table_01_N", NN, ".html", sep = "")
    # 
    # htmlreg(lm.tmp, file = tab.nam,
    #         single.row = TRUE,
    #         custom.model.names = "Y",
    #         custom.coef.names = c("const","X"),
    #         caption = "",
    #         digits = 3,
    #         include.adjrs = FALSE)
      
    #..................................................
    # 5) histogram (non-standardized) ----
  
    plt.nam <- paste("plot_02_b2", b2, "_rho", rho*10, ".svg", sep = "")
    svg(plt.nam) 
    
    # # plot histogram of estimator
    # hist(x = tmp.sim$b1h, freq = FALSE,
    #      xlim = c(-6, 6),
    #      ylim = c(0, 5),
    #      # main=paste("n=",N),
    #      main = "",
    #      xlab = "", 
    #      ylab = "Absolute Frequency")
    # 
    # # line for mean population parameter
    # abline(v = b1, lty = 2, col = "red", lwd = 2)
    # 
    # # legend
    # legend("topleft",
    #        legend = "Population coefficient",
    #        lty = 2,
    #        lwd = 1,
    #        col = "red",
    #        inset = 0.05)
    
    # generate histogram of estimator
    x <- hist(x = tmp.sim$b1h,
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram of estimator
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- xlim.02
    ylim <- c(0, max(c(x$density, ylim.02.max)))
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    # nB <- length(x$breaks)
    # rect(x$breaks[-nB], 0, x$breaks[-1L], x$density)
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # line for mean population parameter
    abline(v = b1, lty = 2, col = "red", lwd = 2)
    
    # legend
    legend("topleft",
           # legend = "Probability of Success",
           legend = c(expression("Value of "*beta[1]*" ")),
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)
      
    dev.off()
    
    #..................................................
    # 6) histogram (standardized) ----
    
    plt.nam <- paste("plot_03_b2", b2, "_rho", rho*10, ".svg", sep = "")
    svg(plt.nam) 
    
    # generate histogram of estimator
    x <- hist(x = tmp.sim$b1h.z,
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram of estimator
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- xlim.03
    ylim <- c(0, max(c(x$density, ylim.03.max)))
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    # nB <- length(x$breaks)
    # rect(x$breaks[-nB], 0, x$breaks[-1L], x$density)
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # pdf for normal distribution
    curve(dnorm(x, mean = 0, sd = 1), -3, 3,
          xlim = c(-3,3), 
          ylim=c(0,0.6),
          lty = 2,
          lwd = 2, 
          xlab = "", 
          ylab = "",
          add = TRUE,
          col = "red")
    
    # legend
    legend("topright",
           # legend = "Standard Normal PDF",
           legend = c(expression("pdf of "*italic("N")*"(0,1)")),
           lty = 2,
           lwd = 1,
           col = "red",
           inset = 0.05)
      
    dev.off()
  
  }
  
}

close(pb)
