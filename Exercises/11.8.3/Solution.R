# Calculate the hitting time matrix of the network at http://www.
# networkatlas.eu/exercises/11/3/data.txt. Note: for various
# reasons, a naive implementation in python using numpy and scipy
# might lead to the wrong result. I would advise to try and do this
# in Octave (or Matlab).

library(here)

# Reading the data
edges <- read.table("data.txt", header = FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Solution

# Building adjacency matrix

N <- length(nodes)
adj <- matrix(0, nrow = N, ncol = N)
for(i in 1:nrow(edges)) {
  from <- match(edges$V1[i], nodes)
  to   <- match(edges$V2[i], nodes)
  adj[from, to] <- 1
  adj[to, from] <- 1  # undirected
}

# Row-stochastic transition matrix
row_sums <- rowSums(adj)
P <- adj / row_sums

# Hitting time matrix function
hitting_time_matrix <- function(P) {
  N <- nrow(P)
  H <- matrix(0, nrow=N, ncol=N)
  for (target in 1:N) {
    A <- diag(N)
    b <- rep(1, N)
    A[target,] <- 0
    A[target, target] <- 1
    b[target] <- 0
    for (i in setdiff(1:N, target)) {
      A[i,] <- -P[i,]
      A[i,i] <- 1
    }
    h <- solve(A, b)
    H[,target] <- h
  }
  rownames(H) <- nodes
  colnames(H) <- nodes
  H
}

# 4. Computing and printing hitting times
H <- hitting_time_matrix(P)
print(round(H,2))
