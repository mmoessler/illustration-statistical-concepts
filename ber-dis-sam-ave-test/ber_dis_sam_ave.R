
# remove all objects
rm(list=ls())

# set directory of figures and tables
fig.dir <- "./ber-dis-sam-ave/figures/"

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

# set seed 
set.seed(12345)

# function to simulate sample average ----
Y_bar_ber_sim_fun <- function(RR, NN, p){
  
  # theoretical moments
  mu <- p # mean
  s2 <- p*(1-p) # variance
  
  Y.bar   <- numeric(RR)
  Y.bar.z <- numeric(RR)
  
  for (ii in 1:RR) {
    Y.sim <- rbinom(n=NN, size=1, prob=p)
    Y.bar[ii]   <- mean(Y.sim)
    Y.bar.z[ii] <- (mean(Y.sim)-mu)/sqrt(s2/NN)
  }
  
  return(list(Y.bar = Y.bar, Y.bar.z = Y.bar.z, Y.sim = Y.sim))
  
}

# inputs (variable)
n.vec <- c(5, 10, 25, 50, 100)
p.vec <- c(0.2, 0.4, 0.6, 0.8)

# inputs (fixed)
RR <- 10000

# simulation/illustration ----

for (ii in 1:length(n.vec)) {
  
  for (jj in 1:length(p.vec)) {
    
    NN <- n.vec[ii]
    p <- p.vec[jj]
    
    # simulation
    tmp.sim <- Y_bar_ber_sim_fun(RR = RR, NN = NN, p = p)
    
    # construct population mean
    mu <- p
    # construct sample mean (last realization)
    lm.tmp <- lm(tmp.sim$Y.sim ~ 1)

    # plot no 01: barplot ----
    plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, ".svg", sep = "")
    svg(plt.nam) 
    
    set_plt_mar()
    
    tmp <- c(NN - sum(tmp.sim$Y.sim), sum(tmp.sim$Y.sim))
    
    tmp.bp <- barplot(tmp,
                      ylim = c(0, 100),
                      names.arg = c("0","1"))
    grid()
    
    barplot(tmp,
            ylim = c(0, 100),
            names.arg = c("0","1"), add = TRUE)
    
    rect(xleft = 0.25, ybottom = 82.5, xright = 0.75, ytop = 97.5, col = "white")

    text(x = 0.5, y = 93,
         bquote(bar(Y) ~" " == .(format(round(summary(lm.tmp)$coefficients[1,1], 3), nsmall = 3))),
         cex = 1.25)
    text(x = 0.5, y = 87,
         bquote(widehat(sigma)[~bar(Y)] == .(format(round(summary(lm.tmp)$coefficients[1,2], 3), nsmall = 3))),
         cex = 1.25)
    
    dev.off()
    
    # plot no 02: histogram estimator (non-standardized ----
    plt.nam <- paste(fig.dir, "figure_02_", ii, "_", jj, ".svg", sep = "")
    svg(plt.nam) 
    
    set_plt_mar()
    
    # select reasonable bin width
    brk.int <- 1/n.vec[ii]
    
    x <- hist(x = tmp.sim$Y.bar,
              breaks = seq(0, 1, brk.int),
              freq = FALSE,
              plot = FALSE)
    
    # plot histogram of estimator
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- c(0, 1)
    ylim <- c(0, 12)
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    axis(1)
    axis(2)
    
    grid()
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # add line for population mean
    abline(v = p, lty = 2, col = "darkgreen", lwd = 2)
    
    # add line for particular estimate
    abline(v = tmp.sim$Y.bar[[RR]], lty = 2, col = "red", lwd = 2)
    
    # add legend
    legend("topleft",
           legend = c(as.expression(bquote(bar(Y) ~" " == .(format(round(tmp.sim$Y.bar[[RR]], 3), nsmall = 3)) ~ " ")),
                      as.expression(bquote(p ~" " == .(format(round(mu, 3), nsmall = 3))))),
           lty = c(2, 2),
           lwd = c(1, 1),
           col = c("red", "darkgreen"),
           inset = 0.05)
    
    dev.off()
    
    # plot no 03: histogram estimator (standardized) ----
    plt.nam <- paste(fig.dir, "figure_03_", ii, "_", jj, ".svg", sep = "")
    svg(plt.nam) 
    
    set_plt_mar()
    
    # select reasonable bin width
    kk <- unique(tmp.sim$Y.bar.z)
    ll <- order(kk)
    brk.int <- diff(kk[ll])[2]
    
    x <- hist(x = tmp.sim$Y.bar.z,
              breaks = c(rev(seq(0, -10, -brk.int)), seq(brk.int, 10, brk.int)),
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
    
    nbx <- length(x$breaks[which(x$counts > 0)])
    rect(x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-(nbx+1)], 0, x$breaks[c(which(x$counts > 0), which(x$counts > 0)[nbx] + 1)][-1L], x$density[which(x$counts > 0)],
         col = "grey")
    
    # add line for particular standardized estimate
    abline(v = tmp.sim$Y.bar.z[[RR]], lty = 2, col = "red", lwd = 2)
    
    # add standard normal density curve
    curve(dnorm(x, mean = 0, sd = 1), -6, 6,
          xlim = c(-3,3), 
          ylim=c(0,0.6),
          lty = 2,
          lwd = 2, 
          xlab = "", 
          ylab = "",
          add = TRUE,
          col = "darkgreen")
    
    # add legend
    legend("topright",
           legend = c(bquote(z[bar(Y)] == .(format(round(tmp.sim$Y.bar.z[[RR]], 3), nsmall = 3)) ~ " "),
                      expression("pdf of "*italic("N")*"(0,1)")),
           lty = 2,
           lwd = 1,
           col = c("red", "darkgreen"),
           inset = 0.05)
      
    dev.off()
    
  }
  
}
