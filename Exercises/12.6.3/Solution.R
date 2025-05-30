# Calculate the global, average and local clustering coefficient for
# the network in http://www.networkatlas.eu/exercises/12/3/
# data.txt.

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Solution 

# Building the Adjacency Matrix
N <- length(nodes)
adj <- matrix(0, nrow=N, ncol=N)
for (i in 1:nrow(edges)) {
  a <- match(edges$V1[i], nodes)
  b <- match(edges$V2[i], nodes)
  adj[a, b] <- 1
  adj[b, a] <- 1
}

# Computing Local Clustering Coefficients
local_clustering <- function(adj) {
  N <- nrow(adj)
  c_vec <- numeric(N)
  for (i in 1:N) {
    neighbors <- which(adj[i, ] == 1)
    k <- length(neighbors)
    if (k < 2) {
      c_vec[i] <- 0
    } else {
      subgraph <- adj[neighbors, neighbors]
      edges_between_neighbors <- sum(subgraph) / 2
      c_vec[i] <- (2 * edges_between_neighbors) / (k * (k - 1))
    }
  }
  names(c_vec) <- nodes
  return(c_vec)
}
C_local <- local_clustering(adj)

# Averaging Clustering Coefficient
C_average <- mean(C_local)

# Calculating the Global Clustering Coefficient
g <- graph_from_adjacency_matrix(adj, mode="undirected")
C_global <- transitivity(g, type="global")

# Printing the results 
cat("Global clustering coefficient:", C_global, "\n")
cat("Average clustering coefficient:", C_average, "\n")
cat("First few local clustering coefficients:\n")
print(head(C_local))