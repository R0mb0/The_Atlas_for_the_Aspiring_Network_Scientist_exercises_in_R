# Calculate the stationary distribution of the network at http://
# www.networkatlas.eu/exercises/11/1/data.txt in three ways: by
# raising the stochastic adjacency to a high power, by looking at the
# leading left eigenvector, and by normalizing the degree. Verify that
# they are all equivalent.

library(here)

# Reading the data 
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Solution 

# Building adjacency matrix
N <- length(nodes)
adj <- matrix(0, nrow=N, ncol=N)
for(i in 1:nrow(edges)) {
  from <- match(edges$V1[i], nodes)
  to   <- match(edges$V2[i], nodes)
  adj[from, to] <- 1
}
row_sums <- rowSums(adj)

# Building the stochastic matrix with fix for dangling nodes
P <- adj
for (i in 1:N) {
  if (row_sums[i] == 0) {
    P[i, ] <- 1/N
  } else {
    P[i, ] <- adj[i, ] / row_sums[i]
  }
}

# Stationary by power
Pn <- P
for(i in 1:100) Pn <- Pn %*% P
stat1 <- Pn[1,]; stat1 <- stat1 / sum(stat1)

# Stationary by left eigenvector
eig <- eigen(t(P))
stat2 <- Re(eig$vectors[,which.max(Re(eig$values))])
stat2 <- stat2 / sum(stat2)

# Stationary by degree
deg <- row_sums
# assigning 1 to dangling nodes as well (for consistency)
deg[deg == 0] <- 1
stat3 <- deg / sum(deg)

# 6. Comparing
cat("By matrix power:\n"); print(round(stat1, 5))
cat("By eigenvector:\n"); print(round(stat2, 5))
cat("By degree normalization:\n"); print(round(stat3, 5))
cat("Matrix power vs eigenvector: ", all.equal(stat1, stat2, tolerance=1e-6), "\n")
cat("Matrix power vs degree: ", all.equal(stat1, stat3, tolerance=1e-6), "\n")