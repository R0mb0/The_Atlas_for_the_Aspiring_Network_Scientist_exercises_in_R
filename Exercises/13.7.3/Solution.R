# Calculate all shortest paths for the graph in Figure 13.12(a).

library(here)
library(igraph)

# Create the undirected graph
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

# Number of nodes
n <- vcount(g)

# Printing all shortest paths between every pair of nodes
cat("All shortest paths between every pair of nodes:\n\n")
for (from in 1:n) {
  for (to in 1:n) {
    if (from < to) { # Only print each pair once
      spaths <- all_shortest_paths(g, from=from, to=to)$res
      cat(sprintf("Shortest path(s) from %d to %d:\n", from, to))
      for (p in spaths) {
        cat("  ", paste(p, collapse = " -> "), "\n")
      }
      cat("\n")
    }
  }
}