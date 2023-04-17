
# inputs
input <- list()
input$NN <- 11

RR <- 1000
NN <- input$NN
b0 <- -2
b1 <- 3.5
X.sd <- 10
u.sd <- 10

# function
bet_hat_sim_fun <- function(RR, NN,
                            b0, b1,
                            X.sd,
                            u.sd){
  
  # # inputs
  # RR <- 10000
  # NN <- 100
  # b0 <- -2
  # b1 <- 3.5
  # X.sd <- 10
  # u.sd <- 1
  
  
  
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

# simulation
tmp.sim <- bet_hat_sim_fun(RR = RR, NN = NN,
                           b0 = b0, b1 = b1,
                           X.sd = X.sd,
                           u.sd = u.sd)

x <- hist(x = tmp.sim$b1h.z, freq = FALSE)

# plot histrogram of estimator
main <- c("")
sub <- c("")
xlab <- c("")
ylab <- c("Relative Frequency")

xlim <- c(x$breaks[1], x$breaks[length(x$breaks)])
ylim <- c(0, max(c(x$density, 0.40)))

xlim <- c(-10, 10)
ylim <- c(0, 0.425)

plot.new()
plot.window(xlim, ylim, "")
title(main = main, sub = sub, xlab = xlab, ylab = ylab)
axis(1)
axis(2)

nB <- length(x$breaks)
rect(x$breaks[-nB], 0, x$breaks[-1L], x$density)
# curve(dnorm(x, mean = 0, sd = 1), -3, 3,
#       xlim = c(-3,3), 
#       ylim=c(0,0.6),
#       lty = 2,
#       lwd = 2, 
#       xlab = "", 
#       ylab = "",
#       add = TRUE,
#       col = "red")





# histogram of estimator
hist(x = tmp.sim$b1h.z, freq = FALSE,
     # xlim = c(0, 1),
     # main=paste("n=",N),
     main = "",
     xlab = "", 
     ylab = "Relative Frequency")
# line for population parameter
abline(v = 0, lty = 2, col = "red", lwd = 2)
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
legend("topleft",
       legend = "Standard Normal PDF",
       lty = 2,
       lwd = 1,
       col = "red",
       inset = 0.05)
