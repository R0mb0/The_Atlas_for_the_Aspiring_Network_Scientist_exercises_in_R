# Calculate the degree of the nodes for both node types in the
# bipartite adjacency matrix from Figure 9.5(a). Find the isolated
# node(s).

#library(igraph)

# Bipartite adjacency matrix
A <- matrix(c(
  0,0,1,0,0,0,0,1,
  0,0,0,0,1,1,0,0,
  0,1,1,0,1,0,0,0,
  0,0,0,1,0,0,1,0,
  1,0,0,0,0,0,0,1,
  0,0,0,1,1,0,0,0,
  0,0,1,1,0,0,1,0,
  0,0,0,0,0,0,1,0
), nrow=8, byrow=TRUE)

# Write here the solution