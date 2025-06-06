# Calculate the betweenness centrality of the nodes in Figure
# 13.12(a). Use to your advantage the fact that there is a bottle-
# neck node which makes the calculation of the shortest paths easier.
# Don’t forget to discount paths with alternative routes.

library(here)
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

# Solution 

# Calculating betweenness centrality
bc <- betweenness(g, normalized=FALSE)

# Printing betweenness centrality for each node
cat("Betweenness centrality for each node:\n")
for (i in 1:vcount(g)) {
  cat(sprintf("Node %d: %.2f\n", i, bc[i]))
}