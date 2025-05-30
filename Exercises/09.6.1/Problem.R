# Write the in- and out-degree sequence for the graph in Figure
# 9.3(a). Are there isolated nodes? Why? Why not?

library(igraph)

# Adjacency list based on the graph (naming nodes: E, C, D, B, A)
edges <- data.frame(
  from = c("E", "E", "C", "D", "B"),
  to   = c("C", "D", "B", "B", "A")
)

# Write here the solution