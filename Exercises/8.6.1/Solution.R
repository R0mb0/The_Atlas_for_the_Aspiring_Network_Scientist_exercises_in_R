# Calculate the adjacency matrix, the stochastic adjacency matrix,
# and the graph Laplacian for the network in http://www.
# networkatlas.eu/exercises/8/1/data.txt.

library(here)
library(igraph)

# Loading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")

# Generating a plot (optional)
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Calculating the Adjacency matrix
A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))

# Calculating the Stochastic adjacency matrix (row-normalized)
row_sums <- rowSums(A)
# Avoid division by zero
row_sums[row_sums == 0] <- 1
A_stochastic <- A / row_sums

# Calculating the Laplacian Graph: L = D - A
D <- diag(row_sums)
L <- D - A

# Printing the results
cat("Adjacency Matrix:\n")
print(A)

cat("\nStochastic Adjacency Matrix:\n")
print(round(A_stochastic, 3))

cat("\nLaplacian Graph (L = D - A):\n")
print(L)