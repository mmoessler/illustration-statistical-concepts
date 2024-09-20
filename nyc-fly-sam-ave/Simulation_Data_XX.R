rm(list=ls())
library(dplyr)
library(nycflights13)
flights <- flights

n_samples <- 1000
# Mean and Variance for flight data
pop_mean <- mean(flights$dep_delay, na.rm = T)
pop_var <- var(flights$dep_delay, na.rm = T)

bootstrap_results_all_sizes <- function(data, n_samples, sample_size_vec, pop_mean, pop_var) {
  
  n_sizes <- length(sample_size_vec)
  results <- vector("list", n_sizes)
  
  for (i in seq_along(sample_size_vec)) {
    sample_size <- sample_size_vec[i]
    
    bo_mean <- numeric(n_samples)
    bo_mean_z <- numeric(n_samples)
    
    for (j in 1:n_samples) {
      samp <- sample_n(data, size = sample_size)
      samp_mean_dep <- mean(samp$dep_delay, na.rm = TRUE)
      bo_mean[j] <- samp_mean_dep
      bo_mean_z[j] <- (samp_mean_dep - pop_mean) / sqrt(pop_var / sample_size)
    }
    
    results[[i]] <- list(sample_size = sample_size, 
                         bootstrap_means = bo_mean,
                         z_scores = bo_mean_z,
                         pop_mean = pop_mean,
                         pop_var = pop_var)
  }
  
  return(results)
}

set.seed(123)
sample_size_vec <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 350, 500, 750, 1000)
boot_results_all_sizes <- bootstrap_results_all_sizes(flights, n_samples = 1000, 
                                                      sample_size_vec = sample_size_vec, 
                                                      pop_mean = pop_mean, pop_var = pop_var)

save(boot_results_all_sizes, file = "./data/simulation_results_cont_v3.RData")
