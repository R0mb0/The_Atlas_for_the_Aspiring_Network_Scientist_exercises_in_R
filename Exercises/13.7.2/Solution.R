# Label the nodes of the graph in Figure 13.12(a) in the order of
# exploration of a DFS. Start from the node in the bottom right
# corner.

library(here)
library(igraph)

# Edge list for the undirected graph (no doubled links!)
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

# Build the undirected graph
g <- graph_from_edgelist(edges, directed=FALSE)

# Solution

# DFS from node 9 (bottom right)
dfs_result <- dfs(g, root=9, order=TRUE)
dfs_order <- dfs_result$order
labels <- rep(NA, vcount(g))
labels[dfs_order] <- seq_along(dfs_order)

# Layout to match the "grid" visually
layout_coords <- matrix(c(
  0.2, 1.0,   # node 1 (top left)
  0.8, 1.0,   # node 2 (top right)
  0.5, 0.8,   # node 3 (upper center)
  0.9, 0.5,   # node 4 (middle right)
  0.5, 0.6,   # node 5 (center)
  0.5, 0.4,   # node 6 (lower center)
  0.2, 0.3,   # node 7 (middle left)
  0.5, 0.2,   # node 8 (bottom center)
  0.8, 0.2    # node 9 (bottom right, START)
), byrow=TRUE, ncol=2)

# Ploting the graph
plot(
  g, 
  layout=layout_coords, 
  vertex.color="red", 
  vertex.size=30, 
  vertex.label=labels, 
  vertex.label.color="white", 
  edge.width=4, 
  edge.color="darkgrey", 
  main="DFS Exploration Order (Start: Node 9)"
)
legend("bottomleft", legend="Node labels = DFS order", bty="n")