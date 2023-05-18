
plot_new_fun_xx <- function(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                            main = "", sub = "", xlab = "", ylab = "",
                            x.mar = 0, y.mar = 0,
                            par.inp = NULL, date = FALSE) {
  
  # # inputs
  # x.axi.tic.01 <- seq.Date(from = as.Date("1999-01-01"), to = as.Date("2020-01-01"), by = "1 year") 
  # x.axi.tic.02 <- seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-01-01"), by = "5 year") 
  # 
  # y.axi.tic.01 <- seq(from = 0.98, to = 1.02, by = 0.010)
  # y.axi.tic.02 <- seq(from = 0.98, to = 1.02, by = 0.005)
  # 
  # main <- ""
  # sub <- ""
  # xlab <- ""
  # ylab <- ""
  # x.mar <- 0
  # y.mar <- 0
  # par.inp <- NULL
  
  
  
  
  
  # start
  if (!is.null(par.inp)) {
    par()$mfrow <- par.inp$mfrow
    par()$mar <- par.inp$mar
    par()$cex.axis <- par.inp$cex.axis
    par()$mgp <- par.inp$mgp
  }
  
  xlim <- c(min(x.axi.tic.01), max(x.axi.tic.01))
  ylim <- c(min(y.axi.tic.01), max(y.axi.tic.01))
  
  plot.new()
  
  plot.window(xlim = xlim, ylim = ylim, log = "")
  
  title(main = main, sub = sub, xlab = xlab, ylab = ylab)
  
  rect(min(x.axi.tic.01) - x.mar, min(y.axi.tic.01) - y.mar,
       max(x.axi.tic.01) + x.mar, max(y.axi.tic.01) + y.mar,
       col = rgb(224, 224, 224, maxColorValue = 255), border = NA) # Color
  
  for(ii in 1:length(x.axi.tic.01)) {
    abline(v = x.axi.tic.01[ii], col = "white", lty = 2)
  }
  
  for(ii in 1:length(y.axi.tic.01)) {
    abline(h = y.axi.tic.01[ii], col = "white", lty = 2)
  }
  
  # x-axis
  if (date == TRUE) {
    axis.Date(side = 1, at = x.axi.tic.01, labels = FALSE, tck = -0.01)
    axis.Date(side = 1, at = x.axi.tic.02, labels = TRUE, tck = -0.02)
  } else {
    axis(side = 1, at = x.axi.tic.01, labels = FALSE, tck = -0.01)
    axis(side = 1, at = x.axi.tic.02, labels = TRUE, tck = -0.02)
  }
  
  # y-axis
  axis(side = 2, at = y.axi.tic.01, labels = FALSE, tck = -0.01)
  axis(side = 2, at = y.axi.tic.02, labels = TRUE, tck = -0.02)
  
}



plot_new_fun_01 <- function(x.axi.tic.01, x.axi.tic.02, y.axi.tic.01, y.axi.tic.02,
                            main = "", sub = "", xlab = "", ylab = "",
                            x.mar = 0, y.mar = 0,
                            par.inp = NULL) {
  
  # inputs
  x.axi.tic.01 <- seq.Date(from = as.Date("1999-01-01"), to = as.Date("2020-01-01"), by = "1 year")
  x.axi.tic.02 <- seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-01-01"), by = "5 year")

  x.axi.tic.01 <- seq(-6, 6, 1.0)
  x.axi.tic.02 <- seq(-6, 6, 0.5)
  
  y.axi.tic.01 <- seq(from = 0.98, to = 1.02, by = 0.010)
  y.axi.tic.02 <- seq(from = 0.98, to = 1.02, by = 0.005)

  y.axi.tic.01 <- seq(0, 0.5, 0.10)
  y.axi.tic.02 <- seq(0, 0.5, 0.05)
  
  main <- ""
  sub <- ""
  xlab <- ""
  ylab <- ""
  x.mar <- 0
  y.mar <- 0
  par.inp <- NULL
  
  
  
  
  
  # start
  if (!is.null(par.inp)) {
    par()$mfrow <- par.inp$mfrow
    par()$mar <- par.inp$mar
    par()$cex.axis <- par.inp$cex.axis
    par()$mgp <- par.inp$mgp
  }
  
  xlim <- c(min(x.axi.tic.01), max(x.axi.tic.01))
  ylim <- c(min(y.axi.tic.01), max(y.axi.tic.01))
  
  plot.new()
  
  plot.window(xlim = xlim, ylim = ylim, log = "")
  
  title(main = main, sub = sub, xlab = xlab, ylab = ylab)
  
  rect(min(x.axi.tic.01) - x.mar, min(y.axi.tic.01) - y.mar,
       max(x.axi.tic.01) + x.mar, max(y.axi.tic.01) + y.mar,
       col = rgb(224, 224, 224, maxColorValue = 255), border = NA) # Color
  
  for(ii in 1:length(x.axi.tic.01)) {
    abline(v = x.axi.tic.01[ii], col = "white", lty = 2)
  }
  
  for(ii in 1:length(y.axi.tic.01)) {
    abline(h = y.axi.tic.01[ii], col = "white", lty = 2)
  }
  
  # x-axis
  # axis.Date(side = 1, at = x.axi.tic.01, labels = FALSE, tck = -0.01)
  # axis.Date(side = 1, at = x.axi.tic.02, labels = TRUE, tck = -0.02)
  
  axis(side = 1, at = x.axi.tic.01, labels = FALSE, tck = -0.01)
  axis(side = 1, at = x.axi.tic.02, labels = TRUE, tck = -0.02)
  
  # y-axis
  axis(side = 2, at = y.axi.tic.01, labels = FALSE, tck = -0.01)
  axis(side = 2, at = y.axi.tic.02, labels = TRUE, tck = -0.02)

  
  
  
  
  # # generate histogram of estimator
  # h1 <- hist(x = tmp.sim$b1h.z, freq = FALSE, plot = FALSE)
  # h2 <- hist(x = tmp.sim$b1h.z.ord, freq = FALSE, plot = FALSE)
  # 
  # # plot h1
  # nB <- length(h1$breaks)
  # rect(h1$breaks[-nB], 0, h1$breaks[-1L], h1$density, col = scales::alpha("darkgreen", 0.25))
  # 
  # # plot h2
  # nB <- length(h2$breaks)
  # rect(h2$breaks[-nB], 0, h2$breaks[-1L], h2$density, col = scales::alpha("red", 0.25))
  # 
  # # pdf for normal distribution
  # curve(dnorm(x, mean = 0, sd = 1), -6, 6,
  #       xlim = c(-3,3), 
  #       ylim=c(0,0.6),
  #       lty = 2,
  #       lwd = 2, 
  #       xlab = "", 
  #       ylab = "",
  #       add = TRUE,
  #       col = "black")
  # 
  # # legend
  # legend("topright",
  #        legend = c("Standard Normal PDF"),
  #        lty = c(2, 2),
  #        lwd = c(1, 1),
  #        col = c("darkgreen"),
  #        inset = 0.05)
  
  
  
  
    
}
