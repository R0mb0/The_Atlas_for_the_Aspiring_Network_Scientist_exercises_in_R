# How many edges would you keep if you were to return the dou-
# bly stochastic backbone including all nodes in the network in a
# single (weakly) connected component with the minimum number
# of edges?

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Solution 

# Getting the adjacency matrix (rows/cols: all nodes, values: weights)
A <- as.matrix(as_adjacency_matrix(g, attr="weight", sparse=FALSE))
A[is.na(A)] <- 0

# Doubling stochastic normalization (Sinkhorn-Knopp algorithm)
normalize_rows <- function(mat) {
  rs <- rowSums(mat)
  rs[rs == 0] <- 1
  mat/rs
}
normalize_cols <- function(mat) {
  cs <- colSums(mat)
  cs[cs == 0] <- 1
  t(t(mat)/cs)
}
max_iter <- 1000
tol <- 1e-8
for(i in 1:max_iter) {
  A <- normalize_rows(A)
  A <- normalize_cols(A)
  if(max(abs(rowSums(A) - 1)) < tol && max(abs(colSums(A) - 1)) < tol) {
    cat(sprintf("Doubly stochastic normalization converged after %d iterations.\n", i))
    break
  }
  if(i == max_iter) cat("Doubly stochastic normalization did NOT fully converge in 1000 iterations.\n")
}

# Building undirected weighted graph from the final matrix (ignore direction, sum weights)
A_sym <- (A + t(A)) / 2
diag(A_sym) <- 0

g_und <- graph_from_adjacency_matrix(A_sym, mode="undirected", weighted=TRUE, diag=FALSE)

# Computing minimum spanning tree (MST) to get the backbone with minimal edges
E(g_und)$neg_weight <- -E(g_und)$weight
mst <- mst(g_und, weights=E(g_und)$neg_weight)

# Number of nodes and edges in the backbone
n_nodes <- vcount(mst)
n_edges <- ecount(mst)
cat(sprintf("Number of nodes: %d\n", n_nodes))
cat(sprintf("Number of edges in backbone: %d\n", n_edges))

# Checking connectivity
if(is.connected(mst, mode="weak")) {
  cat("The backbone is (weakly) connected and includes all nodes.\n")
} else {
  cat("The backbone is NOT connected!\n")
}

# Printing the edge list of the backbone
cat("Edge list of the backbone (minimum, undirected):\n")
print(get.data.frame(mst))

################################################################################
# Optional 
# Plotting the backbone
plot(mst, main="Doubly Stochastic Backbone (Minimum Edges)", edge.width=2)
################################################################################