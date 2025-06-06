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

# Solution

# BFS from node 9 (bottom right)
bfs_result <- bfs(g, root=9, order=TRUE)
bfs_order <- bfs_result$order
labels <- rep(NA, vcount(g))
labels[bfs_order] <- seq_along(bfs_order)

# Layout for nice visual match to figure
layout_coords <- matrix(c(
  0.2, 1.0,   # node 1
  0.8, 1.0,   # node 2
  0.5, 0.8,   # node 3
  0.9, 0.5,   # node 4
  0.5, 0.6,   # node 5
  0.5, 0.4,   # node 6
  0.2, 0.3,   # node 7
  0.5, 0.2,   # node 8
  0.8, 0.2    # node 9 (start)
), byrow=TRUE, ncol=2)

# Plot the graph
plot(
  g, 
  layout=layout_coords, 
  vertex.color="red", 
  vertex.size=30, 
  vertex.label=labels, 
  vertex.label.color="white", 
  edge.width=4, 
  edge.color="darkgrey", 
  main="BFS Exploration Order (Start: Node 9)"
)
legend("bottomleft", legend="Node labels = BFS order", bty="n")