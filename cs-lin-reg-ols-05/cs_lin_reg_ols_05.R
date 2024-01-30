
# remove all objects
rm(list=ls())

# set directory of figures
fig.dir <- "./cs-lin-reg-ols-05/figures/"

# set plot margins
set_plt_mar <- function() {
  par(mar = c(5.1, 4.1, 1, 2.1))
  # bottom, left, top, right
  # 5.1, 4.1, 4.1, 2.1
}

# set seed 
set.seed(12345)

# inputs (variable)
nn.vec <- c(5, 10, 25, 50, 100)
b1.vec <- c(-2, -1, 0, 1, 2)
b2.vec <- c(-2, -1, 0, 1, 2)
rho.vec <- c(-0.9, -0.5, 0, 0.5, 0.9)

# inputs (fixed)
b0 <- 0
x1.sd <- 1
x2.sd <- 1
u.sd <- 1

# grid for names
tmp.grd <- expand.grid(seq(1,length(nn.vec)), seq(1,length(b1.vec)), seq(1,length(b2.vec)), seq(1,length(rho.vec)), stringsAsFactors = FALSE)

for (ind in 1:nrow(tmp.grd)) {
  
  ii <- tmp.grd[ind, 1]
  jj <- tmp.grd[ind, 2]
  kk <- tmp.grd[ind, 3]
  ll <- tmp.grd[ind, 4]
  
  nn <- nn.vec[ii]
  b1 <- b1.vec[jj]
  b2 <- b2.vec[kk]
  rho.21 <- rho.vec[ll]
  
  # Construct E[XX']
  sig <- c(x1.sd, x2.sd)
  rho <- rho.21
  C <- diag(2)
  C[2,1] <- rho[1]
  C[1,2] <- rho[1]
  Q <- diag(sig) %*% C %*% diag(sig)
  # Construct VC matrix bh
  Sig.bh <- solve(Q) %*% solve(Q) * u.sd^2 / nn
  
  # Start a new plot
  plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, "_", kk, "_", ll, ".svg", sep = "")
  svg(plt.nam)
  
  set_plt_mar()
  
  plot.new()
  plot.window(xlim = c(-10, 10), ylim = c(-10, 10), log = "")
  axis(1)
  axis(2)
  grid()
  car::ellipse(center = c(b1, b2),
               shape = Sig.bh,
               radius = sqrt(2 * qf(0.95, 2, nn)),
               center.pch = 0, col = "red", fill = TRUE, fill.alpha = 0.5, lwd = 0)
  abline(v = b1, col = "red", lty = 2)
  abline(h = b2, col = "red", lty = 2)

  dev.off()
  
}
