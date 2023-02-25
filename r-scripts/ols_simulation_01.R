
#..................................................
# simulation and illustration
# sample distribution of the OLS estimator
#..................................................

rm(list=ls())



#..................................................
# Function ----
# Function to simulate b0_hat and b1_hat
# see: https://www.econometrics-with-r.org/4.5-tsdotoe.html#simulation-study-1
# see: https://www.econometrics-with-r.org/4.5-tsdotoe.html#simulation-study-2
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
    b1h.z[ii] <- (b1h[ii] - 0) / var.b1[ii]
    b0h.z[ii] <- (b0h[ii] - 0) / var.b0[ii]
    
  }

  return(list(b0h = b0h, b1h = b1h,
              Y = Y, X = X, u = u,
              var.b0 = var.b0, var.b1 = var.b1,
              b0h.z = b0h.z, b1h.z = b1h.z))
  
}



#..................................................
# Simulation No 01 ----
# Simulation and illustration of the sample distribution of the OLS estimator

seed <- 12345
set.seed(seed)
RR <- 1000
# NN <- 10
N.seq <- seq(1, 100, 1)
b0 <- -2
b1 <- 3.5
X.sd <- 10
u.sd <- 10

# initialize list to collect histogram results
his.res.01 <- list()
his.res.02 <- list()
his.res.03 <- list()
his.res.04 <- list()

# loop over different sample sizes N
for (ii in 1:length(N.seq)) {
  
  tmp.sim <- bet_hat_sim_fun(RR = RR, NN = N.seq[ii],
                             b0 = b0, b1 = b1,
                             X.sd = X.sd,
                             u.sd = u.sd)
  
  # results for b0h
  try( his.res.01[[ii]] <- hist(x = tmp.sim$b0h,
                                freq = FALSE, plot = FALSE), silent = TRUE)

  # results for b1h
  try( his.res.02[[ii]] <- hist(x = tmp.sim$b1h,
                                freq = FALSE, plot = FALSE), silent = TRUE)

  # results for b0h.z
  try( his.res.03[[ii]] <- hist(x = tmp.sim$b0h.z,
                                freq = FALSE, plot = FALSE), silent = TRUE)

  # results for b1h.z
  try( his.res.04[[ii]] <- hist(x = tmp.sim$b1h.z,
                                freq = FALSE, plot = FALSE), silent = TRUE)
  
  # store dgp parameters
  try( his.res.01[[ii]]$par <- data.frame(N = N.seq[ii],
                                          b0 = b0, b1 = b1,
                                          X.sd = X.sd, u.sd = u.sd,
                                          seed = seed), silent = TRUE)
  # store dgp parameters
  try( his.res.02[[ii]]$par <- data.frame(N = N.seq[ii],
                                          b0 = b0, b1 = b1,
                                          X.sd = X.sd, u.sd = u.sd,
                                          seed = seed), silent = TRUE)
  # store dgp parameters
  try( his.res.03[[ii]]$par <- data.frame(N = N.seq[ii],
                                          b0 = b0, b1 = b1,
                                          X.sd = X.sd, u.sd = u.sd,
                                          seed = seed), silent = TRUE)
  # store dgp parameters
  try( his.res.04[[ii]]$par <- data.frame(N = N.seq[ii],
                                          b0 = b0, b1 = b1,
                                          X.sd = X.sd, u.sd = u.sd,
                                          seed = seed), silent = TRUE)
}

# save histogram results 
his.res <- his.res.01
save(his.res, file="./simulation-results/ols_b0_sim_res_01.RData")
his.res <- his.res.02
save(his.res, file="./simulation-results/ols_b1_sim_res_01.RData")
his.res <- his.res.03
save(his.res, file="./simulation-results/ols_b0z_sim_res_01.RData")
his.res <- his.res.04
save(his.res, file="./simulation-results/ols_b1z_sim_res_01.RData")
