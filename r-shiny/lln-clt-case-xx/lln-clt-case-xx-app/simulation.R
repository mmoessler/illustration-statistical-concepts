
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

# function to simulate sample average from continuous uniform distribution ----
Y_bar_uni_sim_fun <- function(RR, NN, a, b){
  
  # theoretical moments
  mu <- 1/2 * (a + b)      # mean
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
