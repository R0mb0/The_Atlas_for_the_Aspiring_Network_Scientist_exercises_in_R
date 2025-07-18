# Build a 2D node embedding for the network at http://www.
# networkatlas.eu/exercises/42/1/data.txt. You should build
# it by taking the first two singular values of the D −1/2 AD −1/2
# matrix.

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Solution 

# Getting the adjacency matrix
A <- as.matrix(get.adjacency(g))

# Getting the degree vector
deg <- rowSums(A)

# Building the D^{-1/2} matrix
D_inv_sqrt <- diag(1 / sqrt(deg))

# Building the normalized adjacency matrix
norm_adj <- D_inv_sqrt %*% A %*% D_inv_sqrt

# Performing singular value decomposition
svd_result <- svd(norm_adj)

# Taking the first two singular vectors for embedding
embedding <- svd_result$u[, 1:2]

# Printing the embedding coordinates
print(embedding)