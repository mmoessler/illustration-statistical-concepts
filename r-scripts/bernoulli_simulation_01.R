
#..................................................
# simulation and illustration
# of LLN and CLT for
# sample average for Bernoulli distribution
#..................................................

rm(list=ls())



#..................................................
# Function ----
# Function to simulate sample average for bernoulli experiment
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

  return(list(Y.bar = Y.bar, Y.bar.z = Y.bar.z))
  
}



#..................................................
# Simulation No 01 ----
# Simulation and illustration of for LLN for Bernoulli distribution

seed <- 12345
set.seed(seed)
RR <- 1000
N.seq <- as.integer(seq(1, 100, 1))
# p.seq <- as.double(seq(0, 1, 0.1))
p <- 0.4

# initialize list to collect histogram results
his.res <- list()

# loop over different sample sizes N
for (ii in 1:length(N.seq)) {
  
  tmp.sim <- Y_bar_ber_sim_fun(RR = RR, NN = N.seq[ii], p = p)
  
  # select reasonable bin width
  brk.int <- 1/N.seq[ii] 
  
  try( his.res[[ii]] <- hist(x = tmp.sim$Y.bar,
                                   breaks = seq(0, 1, brk.int),
                                   freq = FALSE, plot = FALSE), silent = TRUE)
  
  # store dgp parameters
  try( his.res[[ii]]$par <- data.frame(N = N.seq[ii], p = p, seed = seed), silent = TRUE)
    
}

# save histogram results 
save(his.res, file="./simulation-results/ber_lln_sim_res_01.RData")



#..................................................
# Simulation No 02 ----
# Simulation and illustration of for CLT for Bernoulli distribution

seed <- 12345
set.seed(seed)
RR <- 1000
N.seq <- seq(1, 100, 1)
p <- 0.4

# initialize list to collect histogram results
his.res <- list()

for (ii in 1:length(N.seq)) {
  
  tmp.sim <- Y_bar_ber_sim_fun(RR = RR, NN = N.seq[ii], p = p)
  
  # select reasonable bin width
  kk <- unique(tmp.sim$Y.bar.z)
  ll <- order(kk)
  brk.int <- diff(kk[ll])[2]

  try( his.res[[ii]] <- hist(x = tmp.sim$Y.bar.z,
                             breaks = c(rev(seq(0, -10, -brk.int)), seq(brk.int, 10, brk.int)),
                             freq = FALSE, plot = FALSE), silent = TRUE)
  
  # store dgp parameters
  try( his.res[[ii]]$par <- data.frame(N = N.seq[ii], p = p, seed = seed), silent = TRUE)
    
}

# save histogram results 
save(his.res, file="./simulation-results/ber_clt_sim_res_01.RData")
