
library(magrittr)
library(ggplot2)

# Function to simulate b0_hat and b1_hat
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
NN.vec <- seq(1,100,10)

# inputs (fixed)
RR <- 1000
b0 <- -2
b1 <- 3.5
X.sd <- 10
u.sd <- 10

# simulation
tmp.sim <- vector(mode = "list")
for (ii in 1:length(NN.vec)) {
  
  tmp.sim[[ii]] <- bet_hat_sim_fun(RR = RR, NN = NN.vec[ii],
                             b0 = b0, b1 = b1,
                             X.sd = X.sd,
                             u.sd = u.sd)
  
}

ii <- 2

# tmp.sim[[ii]]$b0h[RR]



# 1) plot scatterplot 
data.frame(x = tmp.sim[[ii]]$X, y = tmp.sim[[ii]]$Y) %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(size = 2, color = "blue") +
  # geom_smooth(method = 'lm', formula= y ~ x, se = FALSE, color = "red", linetype = "dashed", size = 1) +
  geom_abline(intercept = tmp.sim[[ii]]$b0h[RR], slope = tmp.sim[[ii]]$b1h[RR], color = "red", linetype = "dashed", size = 1) +
  scale_x_continuous(limits = c(-25, 25)) +
  scale_y_continuous(limits = c(-75, 75)) +
  labs(title = "",
       x = "X", y = "Y")

# 2) plot histogram of estimates
tmp.his <- hist(x = tmp.sim[[ii]]$b1h, plot = FALSE)
tmp.his$breaks
length(tmp.his$breaks)
tmp.his$breaks[2] - tmp.his$breaks[1]

data.frame(x = tmp.sim[[ii]]$b1h) %>%
  ggplot(aes(x = x)) +
  # geom_histogram(aes(y = ..density..), breaks = tmp.his$breaks, fill = "blue", color = "white") +
  geom_histogram(aes(y = ..density..), binwidth = tmp.his$breaks[2] - tmp.his$breaks[1], fill = "blue", color = "white") +
  scale_x_continuous(limits = c(-5, 5)) +
  scale_y_continuous(limits = c(0, 0.5)) +
  labs(title = "",
       x = "", y = "Relative Frequency")

# 3) plot histogram of standardized estimates
data.frame(x = tmp.sim[[ii]]$b1h.z) %>%
  ggplot(aes(x = x)) +
  geom_histogram(aes(y = ..density..), fill = "blue", color = "white") +
  stat_function(fun = dnorm, n = 100, args = list(mean = 0, sd = 1), color = "red", linetype = "dashed", size = 1) + 
  scale_x_continuous(limits = c(-5, 5)) +
  scale_y_continuous(limits = c(0, 0.5)) +
  labs(title = "",
      x = "", y = "Relative Frequency")





library(ggplot2)

set.seed(1)

df <- data.frame(PF = 10*rnorm(1000))
ggplot(df, aes(x = PF)) + 
  geom_histogram(aes(y =..density..),
                 breaks = seq(-50, 50, by = 10), 
                 colour = "black", 
                 fill = "white") +
  stat_function(fun = dnorm, args = list(mean = mean(df$PF), sd = sd(df$PF)))

