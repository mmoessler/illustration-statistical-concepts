
tri_mv_nor <- function(mu, sig, rho, nn) {
  
  C <- diag(3)
  C[2,1] <- rho[1]
  C[3,1] <- rho[2]
  C[3,2] <- rho[3]
  C[1,2] <- rho[1]
  C[1,3] <- rho[2]
  C[2,3] <- rho[3]
  
  V <- diag(sig) %*% C %*% diag(sig)
  
  y <- MASS::mvrnorm(n = nn, mu = mu, Sigma = V)
  
  y
  
}

# function to simulate b0_hat and b1_hat based on normal distribution ----
bet_hat_sim_fun_01 <- function(rr, nn,
                            b0, b1, b2,
                            x1.sd, x2.sd, z.sd, u.sd,
                            rho.21, rho.z1,
                            g0, g1){
  
  # # inputs for checks
  # rr <- 1000
  # nn <- 100
  # b0 <- 1
  # b1 <- 1
  # b2 <- 0
  # x1.sd <- 1
  # x2.sd <- 1
  # z.sd <- 1
  # u.sd <- 1
  # rho.21 <- 0.9
  # rho.z1 <- 0
  # g0 <- 0
  # g1 <- 0
  
  
  
  
  
  # initialize vectors for simulation results
  b0h <- numeric(rr)
  b1h <- numeric(rr)
  
  var.b0 <- numeric(rr)
  var.b1 <- numeric(rr)
  var.b1.ord <- numeric(rr)
  
  b0h.z <- numeric(rr)
  b1h.z <- numeric(rr)
  b1h.z.ord <- numeric(rr)
  
  for (ii in 1:rr) {
    
    # simulate bivariate normal data
    x <- tri_mv_nor(mu = cbind(0, 0, 0),
                    sig = c(x1.sd, x2.sd, z.sd),
                    rho = c(rho.21, rho.z1, 0),
                    nn = nn)
    
    # construct rhs series
    x1 <- x[,1,drop=FALSE]
    x2 <- x[,2,drop=FALSE]
    z <-  x[,3,drop=FALSE]
    u  <- sqrt( exp(g0 + g1 * x1) ) * rnorm(nn, 0, u.sd)
    
    # construct lhs series
    y <- b0 + b1 * x1 + b2 * x2 + u 

    # fit linear model
    fit.01 <- lm(y ~ x1 + x2 + 1) # correct/unobserved fit
    fit.02 <- lm(y ~ x1 + 1)      # biased/observed fit

    # get some residuals
    res.01 <- y - fit.01$fitted.values + b2 * x2 # correlated correct/unobserved residuals
    
    # regression of residuals on x1
    fit.03 <- lm(res.01 ~ x1)
    
    # get some estimates
    b0h[ii] <- fit.02$coefficients[1] # biased coefficients
    b1h[ii] <- fit.02$coefficients[2]
    
    # compute the variance of beta_hat_0
    # note, only correct for simple regression, i.e., for b2=0!
    hi <- 1 - mean(x1) / mean(x1^2) * x1
    var.b0[ii] <- var(hi * u) / (nn * mean(hi^2)^2)
    # compute the variance of hat_beta_1
    # var.b1[ii] <- var( ( x1 - mean(x1) ) * u ) / ( nn * var(x1)^2 ) # robust
    var.b1[ii] <- var( ( x1 - mean(x1) ) * (u + b2 * x2) ) / ( nn * var(x1)^2 ) # robust
    # var.b1.ord[ii] <- var( u ) / ( nn * var(x1) ) # ordinary
    var.b1.ord[ii] <- var( (u + b2 * x2) ) / ( nn * var(x1) ) # ordinary
    
    # compute t-statistics
    b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii]) # robust
    b1h.z.ord[ii] <- (b1h[ii] - b1) / sqrt(var.b1.ord[ii]) # ordinary
    
    b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
    
    # 1st stage
    fit.04 <- lm(x1 ~ z - 1)
    # 2nd stage
    fit.05 <- lm(y ~ fit.03$fitted.values - 1)
    
    # or, see, s&w, equ. 12.04
    szy <- crossprod(z, y) / nn
    szx <- crossprod(z, x1) / nn
    szy / szx
    fit.04$coefficients
    
  }
  
  # bootstrap analysis of bias
  b1h.boot.mea <- 1/rr * sum(b1h)
  b1h.z.boot.mea <- 1/rr * sum(b1h.z)
  b1h.z.boot.sd <- 1/(rr - 1) * sum((b1h.z - b1h.z.boot.mea)^2)
  
  b0h.boot.mea <- 1/rr * sum(b0h)
  b0h.z.boot.mea <- 1/rr * sum(b0h.z)
  b0h.z.boot.sd <- 1/(rr - 1) * sum((b0h.z - b0h.z.boot.mea)^2)
  
  ret.lis <- list(b0h = b0h, b1h = b1h,
                  y = y, x1 = x1, x2 = x2, z = z, u = u,
                  var.b0 = var.b0, var.b1 = var.b1, var.b1.ord = var.b1.ord,
                  b0h.z = b0h.z, b1h.z = b1h.z, b1h.z.ord = b1h.z.ord,
                  b1h.z.boot.mea = b1h.z.boot.mea, b1h.z.boot.sd = b1h.z.boot.sd, b1h.boot.mea = b1h.boot.mea,
                  b0h.z.boot.mea = b0h.z.boot.mea, b0h.z.boot.sd = b0h.z.boot.sd, b0h.boot.mea = b0h.boot.mea,
                  fit.01 = fit.01, fit.02 = fit.02, fit.03 = fit.03, fit.04 = fit.04, fit.05 = fit.05,
                  res.01 = res.01)
  
  return(ret.lis)
  
}

# # inputs for checks
# rr <- 1000
# nn <- 100
# b0 <- 1
# b1 <- 1
# b2 <- 0
# x1.sd <- 1
# x2.sd <- 1
# z.sd <- 1
# u.sd <- 1
# rho.21 <- 0.9
# rho.z1 <- 0
# g0 <- 0
# g1 <- 0
# 
# tmp.sim <- bet_hat_sim_fun(rr, nn, b0, b1, b2, x1.sd, x2.sd, z.sd, u.sd, rho.21, rho.z1, g0, g1)

