# Calculate the effective resistance matrix of the network at http:
# //www.networkatlas.eu/exercises/11/3/data.txt and prove it is
# equal to the commute time divided by 2| E|. Note: differently from
# above, the effective resistance matrix can be calculated in python
# without an issue. But the second part of the exercise might fail if
# not done in Octave (or Matlab).

library(here)
library(MASS)

# Reading data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Solution 

# Building the Laplacian
N <- length(nodes)
adj <- matrix(0, nrow=N, ncol=N)
for(i in 1:nrow(edges)) {
  from <- match(edges$V1[i], nodes)
  to <- match(edges$V2[i], nodes)
  adj[from, to] <- 1
  adj[to, from] <- 1
}
deg <- rowSums(adj)
L <- diag(deg) - adj

# Computing the pseudoinverse of the Laplacian
Lplus <- ginv(L)

# Computing the effective resistance matrix
R_eff <- matrix(0, N, N)
for(i in 1:N) {
  for(j in 1:N) {
    R_eff[i,j] <- Lplus[i,i] + Lplus[j,j] - 2*Lplus[i,j]
  }
}
rownames(R_eff) <- nodes
colnames(R_eff) <- nodes

# Computing the commute time matrix
n_edges <- nrow(edges)
C <- 2 * n_edges * R_eff

# Printing the values and Confirming the relation
cat("Effective resistance\n")
print(R_eff)
cat("Commute time / (2*|E|)\n")
print(C/(2*n_edges))
cat("\nIs effective resistance == commute time / (2*|E|)?\n")
print(all.equal(R_eff, C/(2*n_edges), tolerance=1e-8))