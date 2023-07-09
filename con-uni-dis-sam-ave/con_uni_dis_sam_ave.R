
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./con-uni-dis-sam-ave/figures/"

# set seed 
set.seed(12345)

# function to simulate sample average  ----
Y_bar_uni_sim_fun <- function(RR, NN, a, b){
  
  # theoretical moments
  mu <- 1/2 * (a + b)    # mean
  s2 <- 1/12 * (b - a)^2 # variance
  
  Y.bar   <- numeric(RR)
  Y.bar.z <- numeric(RR)
  
  for (ii in 1:RR) {
    Y.sim <- runif(n=NN, min=a, max=b)
    Y.bar[ii]   <- mean(Y.sim)
    Y.bar.z[ii] <- (mean(Y.sim)-mu)/sqrt(s2/NN)
  }
  
  return(list(Y.bar = Y.bar, Y.bar.z = Y.bar.z, Y.sim = Y.sim))
  
}

# inputs (variable)
NN.vec <- c(5, 10, 25, 50, 100)
a.vec <- seq(-4, -2, 0.5)
b.vec <- seq(2, 4, 0.5)

# inputs (fixed)
RR <- 1000

# simulation/illustration ----
for (ii in 1:length(NN.vec)) {
  
  for (jj in 1:length(a.vec)) {
    
    for(kk in 1:length(b.vec)) {
      
      NN <- NN.vec[ii]
      a <- a.vec[jj]
      b <- b.vec[kk]
      
      # simulation
      tmp.sim <- Y_bar_uni_sim_fun(RR = RR, NN = NN, a = a, b = b)
      
      # construct sample mean
      lm.tmp <- lm(tmp.sim$Y.sim ~ 1)
      
      # plot no 01: histogram ----
      plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, "_", kk, ".svg", sep = "")
      svg(plt.nam) 
      
      # construct histogram
      x <- hist(x = tmp.sim$Y.sim,
                freq = FALSE,
                plot = FALSE)
      
      # plot histogram
      main <- c("")
      sub <- c("")
      xlab <- c("")
      ylab <- c("Relative Frequency")
      
      xlim <- c(-5, 5)
      ylim <- c(0, 1.2)
      
      plot.new()
      plot.window(xlim, ylim, "")
      title(main = main, sub = sub, xlab = xlab, ylab = ylab)
      axis(side = 1, at = seq(-5, 5, 1))
      axis(2)
      
      grid()
      
      nbx <- length(x$breaks[which(x$counts > 0)])
      rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
           col = "grey")
      
      # add vertical line for mean
      abline(v = 1/2 * (a + b), lty = 2, col = "red", lwd = 2)
      
      # legend
      legend("topright",
             legend = c(expression("Value of "*mu)),
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
      
      # add blank rectangle
      rect.xleft.01 <- -5.25
      rect.xright.01 <- -2.75
      rect.ybottom.01 <- 0.95
      rect.ytop.01 <- 1.15
      
      rect(xleft = rect.xleft.01, ybottom = rect.ybottom.01, xright = rect.xright.01, ytop = rect.ytop.01, col = "white")
      
      # add mu text
      text.x.01 <- -4
      text.y.01 <- 1.1
      
      text(x = text.x.01, y = text.y.01,
           bquote(bar(Y) ~" " == .(format(round(summary(lm.tmp)$coefficients[1,1], 3), nsmall = 3))),
           cex = 1.25)
      
      # add sigma text
      text.x.02 <- -4
      text.y.02 <- 1.0
      
      text(x = text.x.02, y = text.y.02,
           bquote(widehat(sigma)[~bar(Y)] == .(format(round(summary(lm.tmp)$coefficients[1,2], 3), nsmall = 3))),
           cex = 1.25)
      
      dev.off()
      
      # plot no 02: histogram sample average (non-standardized) ----
      plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, "_", kk, ".svg", sep = "")
      svg(plt.nam) 
      
      # generate histogram of estimator
      x <- hist(x = tmp.sim$Y.bar,
                freq = FALSE,
                plot = FALSE)
      
      # plot histogram of estimator
      main <- c("")
      sub <- c("")
      xlab <- c("")
      ylab <- c("Absolute Frequency")
      
      xlim <- c(-6, 6)
      ylim <- c(0, 5)
      
      plot.new()
      plot.window(xlim, ylim, "")
      title(main = main, sub = sub, xlab = xlab, ylab = ylab)
      axis(1)
      axis(2)
      
      grid()
      
      nbx <- length(x$breaks[which(x$counts > 0)])
      rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
           col = "grey")
      
      # add line for mean population parameter
      abline(v = 1/2 * (a + b), lty = 2, col = "red", lwd = 2)
      
      # # # legend
      # # legend("topright",
      # #        legend = c(expression(mu==frac(1,2)~~(a + b))),
      # #        lty = 2,
      # #        lwd = 1,
      # #        col = "red",
      # #        inset = 0.05)
      # 
      # # legend
      # leg <- legend("topright",
      #               legend = c(expression(mu==frac(1,2)~~(a + b))),
      #               lty = 2,
      #               lwd = 1,
      #               col = "red",
      #               inset = 0.05,
      #               plot = FALSE)
      # 
      # # adjust as desired
      # leftx <- leg$rect$left
      # rightx <- (leg$rect$left + leg$rect$w * 1.0) * 1
      # topy <- leg$rect$top
      # bottomy <- (leg$rect$top - leg$rect$h * 1.2) * 1
      # 
      # legend(x = c(leftx, rightx), y = c(topy, bottomy),
      #        legend = c(expression(mu==frac(1,2)~~(a + b))),
      #        lty = 2,
      #        lwd = 1,
      #        col = "red",
      #        inset = 0.05)
      
      # legend
      legend("topright",
             legend = c(expression("Value of "*mu)),
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
      
      dev.off()
      
      # plot no 03 histogram sample average (standardized) ----
      plt.nam <- paste(fig.dir, "figure_03_", ii, "_", jj, "_", kk, ".svg", sep = "")
      svg(plt.nam) 
    
      # construct histogram
      x <- hist(x = tmp.sim$Y.bar.z,
                freq = FALSE,
                plot = FALSE)
      
      # plot histogram
      main <- c("")
      sub <- c("")
      xlab <- c("")
      ylab <- c("Relative Frequency")
      
      xlim <- c(-6, 6)
      ylim <- c(0, 0.5)
      
      plot.new()
      plot.window(xlim, ylim, "")
      title(main = main, sub = sub, xlab = xlab, ylab = ylab)
      axis(1)
      axis(2)
      
      grid()
      
      nB <- length(x$breaks)
      rect(x$breaks[-nB], 0, x$breaks[-1L], x$density, col = scales::alpha("grey", 0.25))
      
      # add standard normal density curve
      curve(dnorm(x, mean = 0, sd = 1), -6, 6,
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
             legend = c(expression("pdf of "*italic("N")*"(0,1)")),
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
      
      dev.off()
      
    }
    
  }
  
}
