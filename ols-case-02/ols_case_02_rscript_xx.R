
# remove all objects
rm(list=ls())

# set working directory
setwd("C:/Users/Markus/Dropbox/Teaching/SoSe2023/illustration-statistical-concepts/ols-case-02")

# load texreg extract functions
library(texreg)
source("../r-scripts/texreg_extract_fun_xx.R")

# set seed 
set.seed(12345)

# function to simulate b0_hat and b1_hat ----
bet_hat_sim_fun <- function(RR, NN,
                            b0, b1,
                            X.sd,
                            u.sd){
  
  # # inputs
  # RR <- 10000
  # NN <- 2
  # b0 <- -2
  # b1 <- 3.5
  # X.sd <- 1
  # u.sd <- 100
  
  
  
  # initialize vectors for simulation results
  b0h <- numeric(RR)
  b1h <- numeric(RR)
  
  var.b0 <- numeric(RR)
  var.b1 <- numeric(RR)
  
  b0h.z <- numeric(RR)
  b1h.z <- numeric(RR)
  
  for (ii in 1:RR) {
    
    X <- rnorm(NN, mean = 0, sd = X.sd)
    u <- rnorm(NN, mean = 0, sd = u.sd)
    Y <- b0 + b1 * X + u
    
    tmp <- lm(Y ~ X + 1)
    
    # get estimates
    b0h[ii] <- tmp$coefficients[1]
    b1h[ii] <- tmp$coefficients[2]
    
    # compute the variance of beta_hat_0
    Hi <- 1 - mean(X) / mean(X^2) * X
    var.b0[ii] <- var(Hi * u) / (NN * mean(Hi^2)^2)
    # compute the variance of hat_beta_1
    var.b1[ii] <- var( ( X - mean(X) ) * u ) / ( NN * var(X)^2 )
    
    # compute t-statistics
    b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii])
    b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
    
  }
  
  return(list(b0h = b0h, b1h = b1h,
              Y = Y, X = X, u = u,
              var.b0 = var.b0, var.b1 = var.b1,
              b0h.z = b0h.z, b1h.z = b1h.z))
  
}

# inputs (variable)
NN.vec <- seq(3, 100, 1)
b1.vec <- seq(-3, 3, 1)

# inputs (fixed)
RR <- 1000
b0 <- 1
X.sd <- 10
u.sd <- 10

# plot inputs
xlim.01 <- c(-60, 60) # scatterplot
ylim.01 <- c(-150, 150)

xlim.02 <- c(-6, 6) # histogram (lln)
ylim.02.max <- 10

xlim.03 <- c(-60, 60) # histogram (clt)
ylim.03.max <- 0.5

rect.xleft.01 <- -60 # potion rectangle in scatterplot
rect.ybottom.01 <- 80
rect.xright.01 <- -20
rect.ytop.01 <- 145

text.x.01 <- -40 # position text line 01
text.y.01 <- 130
     
text.x.02 <- -40 # position text line 02
text.y.02 <- 100

# simulation

pb = txtProgressBar(min = 0, max = length(NN.vec), initial = 0) 

for (ii in 1:length(NN.vec)) {
  
  setTxtProgressBar(pb, ii)
  
  for (jj in 1:length(b1.vec)) {
  
    NN <- NN.vec[ii]
    b1 <- b1.vec[jj]
    
    #..................................................
    # 1) call sim function ----
    tmp.sim <- bet_hat_sim_fun(RR = RR, NN = NN,
                               b0 = b0, b1 = b1,
                               X.sd = X.sd,
                               u.sd = u.sd)
    
    
    #..................................................
    # 2) fit linear model ----
    lm.tmp <- lm(tmp.sim$Y ~ tmp.sim$X + 1)
    
    #..................................................
    # 3) scatterplot ----
    
    plt.nam <- paste("plot_01_N", NN, "_b", b1, ".svg", sep = "")
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
    
    lines(x = tmp.sim$X, y = tmp.sim$Y, type = "p")
    # abline(a = tmp.sim$b0h, b = tmp.sim$b1h, lty = 2, col = "red", lwd = 2)
    abline(a = summary(lm.tmp)$coefficients[1,1], b = summary(lm.tmp)$coefficients[2,1], lty = 2, col = "red", lwd = 2)
    
    rect(xleft = rect.xleft.01, ybottom = rect.ybottom.01, xright = rect.xright.01, ytop = rect.ytop.01, col = "white")
    
    text(x = text.x.01, y = text.y.01,
         # bquote(widehat(beta)[1] == .(round(summary(lm.tmp)$coefficients[2,1], 3))),
         bquote(widehat(beta)[1] == .(format(round(summary(lm.tmp)$coefficients[2,1], 3), nsmall = 3))),
         cex = 1.25)
    text(x = text.x.02, y = text.y.02,
         # bquote(widehat(sigma)[widehat(beta)[1]] == .(round(summary(lm.tmp)$coefficients[2,2], 3))),
         bquote(widehat(sigma)[widehat(beta)[1]] == .(format(round(summary(lm.tmp)$coefficients[2,2], 3), nsmall = 3))),
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
  
    plt.nam <- paste("plot_02_N", NN, "_b", b1, ".svg", sep = "")
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
    
    plt.nam <- paste("plot_03_N", NN, "_b", b1, ".svg", sep = "")
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
