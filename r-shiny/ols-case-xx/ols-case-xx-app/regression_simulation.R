
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

# function to simulate b0_hat and b1_hat ----
bet_hat_sim_fun <- function(rr, nn,
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
  # rho.21 <- 0
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
    y1 <- b0 + b1 * x1 + b2 * x2 + u # observed relationship
    y2 <- b0 + b1 * x1 + u # true relationship
    
    # fit linear model
    fit.01 <- lm(y1 ~ x1 + 1)
    fit.02 <- lm(y2 ~ x1 + 1)
    
    # get residuals
    res.01 <- fit.01$residuals
    res.02 <- fit.02$residuals
    res.03 <- y1 - fit.02$fitted.values # population residuals ... observed y minus fitted true y -> omitted variables... (observed vs. true fitted)
    
    # get estimates
    b0h[ii] <- fit.01$coefficients[1]
    b1h[ii] <- fit.01$coefficients[2]
    
    # compute the variance of beta_hat_0
    hi <- 1 - mean(x1) / mean(x1^2) * x1
    var.b0[ii] <- var(hi * u) / (nn * mean(hi^2)^2)
    # compute the variance of hat_beta_1
    var.b1[ii] <- var( ( x1 - mean(x1) ) * u ) / ( nn * var(x1)^2 )
    var.b1.ord[ii] <- var( u ) / ( nn * var(x1) )
    
    # compute t-statistics
    b1h.z[ii] <- (b1h[ii] - b1) / sqrt(var.b1[ii])
    b1h.z.ord[ii] <- (b1h[ii] - b1) / sqrt(var.b1.ord[ii])
    
    b0h.z[ii] <- (b0h[ii] - b0) / sqrt(var.b0[ii])
    
    # 1st stage
    fit.03 <- lm(x1 ~ z + 1)
    fit.03 <- lm(x1 ~ z - 1)
    # 2nd stage
    fit.04 <- lm(y1 ~ fit.03$fitted.values + 1)
    fit.04 <- lm(y1 ~ fit.03$fitted.values - 1)
    
    # or, see, s&w, equ. 12.04
    szy <- crossprod(z, y1) / nn
    szx <- crossprod(z, x1) / nn
    szy / szx
    fit.04$coefficients
    # works
    
    
    
    # # or, for fit.02
    # X <- cbind(x1, 1)
    # Y <- y2
    # N <- nrow(X)
    # MXX <- crossprod(X)/N
    # MXXinv <- solve(MXX)
    # MYY <- crossprod(Y)/N
    # MYX <- crossprod(Y, X)/N
    # MXY <- crossprod(X, Y)/N
    # 
    # t(MYX %*% MXXinv)
    # fit.02$coefficients
    # 
    # RY <- Y - t(MYX %*% MXXinv %*% t(X))
    # FY <- t(MYX %*% MXXinv %*% t(X))
    # SYX <- MYY - MYX %*% MXXinv %*% MXY # concentrate out the variation explained by X
    # SYX
    # res <- as.matrix(fit.02$residuals) 
    # crossprod(res)/N
    # # works
    # xxx <- MYX %*% MXXinv %*% MXY # variation explained by X
    # xxx
    # t(fit.02$fitted.values) %*% t(t(fit.02$fitted.values)) / N
    # # works
    
    
    
  }
  
  # bootstrap analysis of bias
  b1h.z.boot.mea <- 1/rr * sum(b1h.z)
  b1h.z.boot.sd <- 1/(rr - 1) * sum((b1h.z - b1h.z.boot.mea)^2)
  
  b0h.z.boot.mea <- 1/rr * sum(b0h.z)
  b0h.z.boot.sd <- 1/(rr - 1) * sum((b0h.z - b0h.z.boot.mea)^2)
  
  return(list(b0h = b0h, b1h = b1h,
              y1 = y1, y2 = y2, x1 = x1, x2 = x2, z = z, u = u,
              var.b0 = var.b0, var.b1 = var.b1, var.b1.ord = var.b1.ord,
              b0h.z = b0h.z, b1h.z = b1h.z, b1h.z.ord = b1h.z.ord,
              b1h.z.boot.mea = b1h.z.boot.mea, b1h.z.boot.sd = b1h.z.boot.sd,
              b0h.z.boot.mea = b0h.z.boot.mea, b0h.z.boot.sd = b0h.z.boot.sd,
              fit.01 = fit.01, fit.02 = fit.02,
              res.01 = res.01, res.02 = res.02, res.03 = res.03))
  
}