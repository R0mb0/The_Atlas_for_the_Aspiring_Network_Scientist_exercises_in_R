# Label the nodes of the graph in Figure 13.12(a) in the order of
# exploration of a BFS. Start from the node in the bottom right
# corner.

library(igraph)

# Building the undirected graph
edges <- matrix(c(
  1,2,
  1,3,
  2,3,
  2,4,
  2,5,
  3,5,
  3,4,
  4,5,
  5,6,
  5,7,
  6,7,
  6,8,
  6,9,
  7,8,
  7,9,
  8,9
), byrow=TRUE, ncol=2)
g <- graph_from_edgelist(edges, directed=FALSE)

# Write here the solution 