
# clear workspace
rm(list = ls(all = TRUE))

# load some simulation
load(url("https://github.com/mmoessler/illustration-statistical-concepts/raw/main/simulation-results/ber_clt_sim_res_01.RData"))

# define inputs (for shiny)
input <- list()
input$NM <- 100

# assign illustration
x <- his.res[[input$NM]]

# plot illustration
if (is.null(x$breaks[1])) {
  
  plot(x = 0:1, # Create empty plot
       y = 0:1,
       ann = F,
       bty = "n",
       type = "n",
       xaxt = "n",
       yaxt = "n")
  text(x = 0.5, # Add text to empty plot
       y = 0.5,
       "Choose reasonable parameters!", 
       cex = 2)
  
} else {
  
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
  curve(dnorm(x, mean = 0, sd = 1), -3, 3,
        xlim = c(-3,3), 
        ylim=c(0,0.6),
        lty = 2,
        lwd = 2, 
        xlab = "", 
        ylab = "",
        add = TRUE,
        col = "red")
  
}

# plot illustration function
his_ill_fun <- function(x, ii, nam.01) {
  
  # ii <- 10
  # x <- his.res[[ii]]
  # nam.01 <- "./illustration-results/ber_clt_ill_res_01_N"
  
  
  
  
  
  # construct plot name
  nam.02 <- ii
  plt.nam <- paste(nam.01, nam.02, ".svg", sep = "")
  
  # open svg device
  svg(plt.nam) 
  
  if (is.null(x$breaks[1])) {
    
    plot(x = 0:1, # Create empty plot
         y = 0:1,
         ann = F,
         bty = "n",
         type = "n",
         xaxt = "n",
         yaxt = "n")
    text(x = 0.5, # Add text to empty plot
         y = 0.5,
         "Choose reasonable parameters!", 
         cex = 2)
    
  } else {
    
    main <- c("")
    sub <- c("")
    xlab <- c("")
    ylab <- c("Relative Frequency")
    
    xlim <- c(x$breaks[1], x$breaks[length(x$breaks)])
    ylim <- c(0, max(c(x$density, 0.40)))
    
    xlim <- c(-10, 10)
    ylim <- c(0, 0.5)
    
    plot.new()
    plot.window(xlim, ylim, "")
    title(main = main, sub = sub, xlab = xlab, ylab = ylab)
    
    axis(1)
    axis(2)
    
    nB <- length(x$breaks)
    rect(x$breaks[-nB], 0, x$breaks[-1L], x$density)
    curve(dnorm(x, mean = 0, sd = 1), -3, 3,
          xlim = c(-3,3), 
          ylim=c(0,0.6),
          lty = 2,
          lwd = 2, 
          xlab = "", 
          ylab = "",
          add = TRUE,
          col = "red")
    
  }
  
  # close svg device
  dev.off()
  
}


# save one illustration
his_ill_fun(x = his.res[[100]], ii = 100,
            nam.01 = "./illustration-results/ber_clt_ill_res_01_N")

# save all illustration
N.seq <- seq(1, 100, 1)

for (ii in 1:length(N.seq)) {
  
  his_ill_fun(x = his.res[[ii]], ii = ii,
              nam.01 = "./illustration-results/ber_clt_ill_res_01_N")
  
}
