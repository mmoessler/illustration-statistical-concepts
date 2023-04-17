
# inputs
input <- list()
input$rho <- 0.25

# inputs
RR <- 1000
NN <- 100
b0 <- -2
b1 <- 1
b2 <- 1
X1.int <- 10
X2.int <- 10
u.sd <- 10
rho <- input$rho

# function
bet_hat_sim_fun <- function(RR, NN,
                            b0, b1, b2,
                            X1.int, X2.int,
                            u.sd,
                            rho){
  
  # # inputs
  # RR <- 1000
  # NN <- 100
  # b0 <- -2
  # b1 <- 1
  # b2 <- 1
  # X1.int <- 10
  # X2.int <- 10
  # u.sd <- 10
  # rho <- input$rho
  
  
  
  
  
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
    Y1 <- b0 + b1 * X1 + b2 * X2 + u
    Y2 <- b0 + b1 * X1 + u
    
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

# simulation
# inputs
RR <- 1000
NN <- 100
b0 <- -2
b1 <- 1
b2 <- 1
X1.int <- 10
X2.int <- 10
u.sd <- 10
rho <- input$rho

# simulation
tmp.sim <- bet_hat_sim_fun(RR = RR, NN = NN,
                           b0 = b0, b1 = b1, b2 = b2,
                           X1.int = X1.int, X2.int = X2.int,
                           u.sd = u.sd,
                           rho = rho)

# # inputs
# RR <- 1000
# NN <- 100
# b0 <- -2
# b1 <- 1
# b2 <- 1
# X1.int <- 10
# X2.int <- 10
# u.sd <- 10
# rho <- input$rho
# 
# # reactive
# tmp.sim <- Sim()

# illustration
plot(x = tmp.sim$X1, y = tmp.sim$Y1,
     xlab = "X", ylab = "Y",
     xlim = c(-50, 50), ylim = c(-150, 150))
abline(a = b0, b = b1, lty = 2, col = "red", lwd = 2)

