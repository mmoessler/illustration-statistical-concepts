
# remove all objects
rm(list=ls())

# set working directory
setwd("./lln-clt-case-02")

# set seed 
set.seed(12345)

# function to simulate sample average for bernoulli experiment ----
Y_bar_ber_sim_fun <- function(RR, NN, p){
  
  # theoretical moments
  mu <- p      # mean
  s2 <- p*(1-p) # variance
  
  Y.bar   <- numeric(RR)
  Y.bar.z <- numeric(RR)
  
  for (ii in 1:RR) {
    Y.sim <- rbinom(n=NN, size=1, prob=p)
    Y.bar[ii]   <- mean(Y.sim)
    Y.bar.z[ii] <- (mean(Y.sim)-mu)/sqrt(s2/NN)
    # see, S&W, 2020, p.89
  }
  
  return(list(Y.bar = Y.bar, Y.bar.z = Y.bar.z, Y.sim = Y.sim))
  
}

# inputs (variable)
NN.vec <- seq(5, 95, 10)
p.vec <- seq(0.2, 0.8, 0.2)

# inputs (fixed)
RR <- 1000

# plot inputs
xlim.01 <- c(0, 1) # barplot
ylim.01 <- c(0, 100)

xlim.02 <- c(0, 1) # histogram (lln)
ylim.02.max <- 10

xlim.03 <- c(-6, 6) # histogram (clt)
ylim.03.max <- 0.5

rect.xleft.01 <- 0.25 # position rectangle in scatterplot
rect.ybottom.01 <- 82.5
rect.xright.01 <- 0.75
rect.ytop.01 <- 97.5

text.x.01 <- 0.5 # position text line 01
text.y.01 <- 93

text.x.02 <- 0.5 # position text line 02
text.y.02 <- 87

# simulation

pb = txtProgressBar(min = 0, max = length(NN.vec), initial = 0) 

for (ii in 1:length(NN.vec)) {
  
  setTxtProgressBar(pb, ii)
  
  for (jj in 1:length(p.vec)) {
    
    NN <- NN.vec[ii]
    p <- p.vec[jj]
    
    # 1) call simulation function ----
    tmp.sim <- Y_bar_ber_sim_fun(RR = RR, NN = NN, p = p)
    
    # # 2) table of observations ----
    # tab.nam <- paste("table_01_N", NN, "_p", p*10, ".html", sep = "")
    # print(xtable::xtable(data.frame(y = tmp.sim$Y.sim)), type = "html", file = tab.nam)
    # 
    # tab.nam <- paste("table_02_N", NN, "_p", p*10, ".html", sep = "")
    # lm.tmp <- lm(tmp.sim$Y.sim ~ 1)
    # texreg::htmlreg(lm.tmp, file = tab.nam)
    
    # # 2) barplot ----
    lm.tmp <- lm(tmp.sim$Y.sim ~ 1)
    
    plt.nam <- paste("plot_01_N", NN, "_p", p*10, ".svg", sep = "")
    svg(plt.nam) 
    
    tmp <- c(NN - sum(tmp.sim$Y.sim), sum(tmp.sim$Y.sim))
    tmp.bp <- barplot(tmp,
                      ylim = ylim.01,
                      names.arg = c("0","1"))
    grid()
    
    barplot(tmp,
            ylim = xlim.01,
            names.arg = c("0","1"), add = TRUE)
    
    rect(xleft = rect.xleft.01, ybottom = rect.ybottom.01, xright = rect.xright.01, ytop = rect.ytop.01, col = "white")
    
    text(x = text.x.01, y = text.y.01,
         # bquote(widehat(beta)[1] == .(round(summary(lm.tmp)$coefficients[2,1], 3))),
         bquote(bar(Y) ~" " == .(format(round(summary(lm.tmp)$coefficients[1,1], 3), nsmall = 3))),
         cex = 1.25)
    text(x = text.x.02, y = text.y.02,
         # bquote(widehat(sigma)[widehat(beta)[1]] == .(round(summary(lm.tmp)$coefficients[2,2], 3))),
         bquote(widehat(sigma)[~bar(Y)] == .(format(round(summary(lm.tmp)$coefficients[1,2], 3), nsmall = 3))),
         cex = 1.25)
    
    dev.off()
    
    # 3) histogram (non-standardized) ----
    
    plt.nam <- paste("plot_02_N", NN, "_p", p*10, ".svg", sep = "")
    svg(plt.nam) 
    
    if (NN <= 2) {
      
      # see: https://statisticsglobe.com/plot-only-text-in-r
      plot(x = 0:1, # Create empty plot
           y = 0:1,
           ann = F,
           bty = "n",
           type = "n",
           xaxt = "n",
           yaxt = "n")
      text(x = 0.5, # Add text to empty plot
           y = 0.5,
           # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
           "Choose a sample size greater than two!", 
           cex = 1)
      
    } else {
      
      # plot histogram of estimator
      
      # select reasonable bin width
      brk.int <- 1/NN.vec[ii] 
      
      # hist(x = tmp.sim$Y.bar,
      #      breaks = seq(0, 1, brk.int),
      #      freq = FALSE,
      #      main = "",
      #      xlab = "", 
      #      ylab = "Absolute Frequency")
      
      # generate histogram of estimator
      x <- hist(x = tmp.sim$Y.bar,
                breaks = seq(0, 1, brk.int),
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
      abline(v = p, lty = 2, col = "red", lwd = 2)
      
      # legend
      legend("topright",
             # legend = "Probability of Success",
             legend = c(expression("Value of "*italic("p"))),
             lty = 2,
             lwd = 1,
             col = "red",
             inset = 0.05)
      
    }
    
    dev.off()
    
    # 4) histogram (standardized) ----
    
    plt.nam <- paste("plot_03_N", NN, "_p", p*10, ".svg", sep = "")
    svg(plt.nam) 
    
    if (NN <= 2) {
      
      # see: https://statisticsglobe.com/plot-only-text-in-r
      plot(x = 0:1, # Create empty plot
           y = 0:1,
           ann = F,
           bty = "n",
           type = "n",
           xaxt = "n",
           yaxt = "n")
      text(x = 0.5, # Add text to empty plot
           y = 0.5,
           # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
           "Choose a sample size greater than two!", 
           cex = 1)
      
    } else if (p==0 | p==1) {
      
      # see: https://statisticsglobe.com/plot-only-text-in-r
      plot(x = 0:1, # Create empty plot
           y = 0:1,
           ann = F,
           bty = "n",
           type = "n",
           xaxt = "n",
           yaxt = "n")
      text(x = 0.5, # Add text to empty plot
           y = 0.5,
           # "This is my first line of text!\nAnother line of text.\n(Created by Base R)", 
           "Choose a probability of success \n
           higher than 0 or \n
           lower than 1!", 
           cex = 1)
      
    } else {
      
      # select reasonable bin width
      kk <- unique(tmp.sim$Y.bar.z)
      ll <- order(kk)
      brk.int <- diff(kk[ll])[2]
      
      # generate histogram of estimator
      x <- hist(x = tmp.sim$Y.bar.z,
                breaks = c(rev(seq(0, -10, -brk.int)), seq(brk.int, 10, brk.int)),
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
      
    }
    
    dev.off()
    
  }
  
}

close(pb)
