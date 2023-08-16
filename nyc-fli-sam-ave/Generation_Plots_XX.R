# remove all objects
rm(list=ls())

# load data
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# set directory of figures and tables
fig.dir <- "./Figures/"

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}


ylimmax = function(value) {
  if (value<=5) {
    ylimmax = 1
  } else if (value>=6) {
    ylimmax = 0.6
    # } else if (value>=30) {
    #   ylimmax = 0.5
  } else {
    ylimmax = 0.4
  }
}


load("./Data/simulation_results_cont_v3.RData")

for (i in 1:length(boot_results_all_sizes[])){
  
  set_plt_mar()
  
  # Plot 1 Boxplots
  
  svg(paste(fig.dir,"figure_01_", i, ".svg", sep = ""))
  N <- boot_results_all_sizes[[i]]$sample_size
  res <- boot_results_all_sizes[[i]]
  pop_mean <- res$pop_mean
  
  boxplot(boot_results_all_sizes[[i]][["bootstrap_means"]],
          main = "",
          xlab = paste("Sample Size", N),
          ylab = "",
          ylim = c(0, 25))
  abline(h = pop_mean, col = "red")
  text(x= 0.6, y=13.1, 'Population Mean', col = "red")
  dev.off() 
  
  # Plot 2 LLN
  
  svg(paste(fig.dir,"figure_02_", i, ".svg", sep = ""))
  res <- boot_results_all_sizes[[i]]
  sample_size <- res$sample_size
  bootstrap_means <- res$bootstrap_means
  pop_mean <- res$pop_mean
  
  hist(bootstrap_means, freq = FALSE,
       main = "", 
       xlab = "Simulated Means", ylab = "Density",
       xlim = c(0, 30),
       ylim = c(0, 0.35))
  abline(v = pop_mean, col = "red")
  dev.off() 
  
  # Plot 3 CLT
  
  svg(paste(fig.dir,"figure_03_", i, ".svg", sep = "")) 
  res <- boot_results_all_sizes[[i]]
  sample_size <- res$sample_size
  bootstrap_means_z <- res$z_scores
  
  hist(bootstrap_means_z, freq = FALSE,
       main = "",
       xlim = c(-3,3),
       ylim=c(0,ylimmax(res$sample_size)),
       xlab = "Standardized Means", ylab = "Density")
  curve(dnorm(x, mean = 0, sd = 1), -3, 3,
        xlim = c(-3,3),
        #ylim=c(0,0.6),
        lty = 2,
        lwd=1,
        xlab = "",
        ylab = "",
        add = TRUE,
        col = "red")
  dev.off() 
  
}
