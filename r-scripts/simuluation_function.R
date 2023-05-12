
# Way towards

A <- matrix(c(2.25,   0,    0,
              0,   1,  0.5,
              0, 0.5, 0.74), 3, 3, byrow = TRUE)

B <- diag(sqrt(diag(A)))
B

C <- solve(B) %*% A %*% solve(B)
C

# Way backwards

tri_mv_nor <- function(mu, sig, rho) {
  
  sig <- c(sqrt(2.25), sqrt(1), sqrt(0.74))
  rho <- c(0, 0, 0.5812382)
  mu <- rbind(0, 0, 0)
  
  
  
  C <- diag(3)
  C[2,1] <- rho[1]
  C[3,1] <- rho[2]
  C[3,2] <- rho[3]
  C[1,2] <- rho[1]
  C[1,3] <- rho[2]
  C[2,3] <- rho[3]
  
  V <- diag(sig) %*% C %*% diag(sig)
  # V
  
  y <- MASS::mvrnorm(n = 1000, mu = mu, Sigma = V)
  # head(y)
  
  y
  
}