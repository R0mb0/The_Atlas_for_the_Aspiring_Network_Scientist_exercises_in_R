# Based on the paths you calculated for your answer in the previous
# chapter, calculate the harmonic centrality of the nodes in Figure
# 13.12(a).

library(here)
library(igraph)

# Building the graph
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

# Compute all-pairs shortest paths
dists <- distances(g)

# Harmonic centrality: sum of 1/distance (excluding self, and ignoring infinite)
harmonic_centrality <- sapply(1:vcount(g), function(i) {
  di <- dists[i, ]
  # Exclude self, and handle Inf (disconnected, not needed here as graph is connected)
  sum(1/di[di != 0])
})

cat("Harmonic centrality for each node:\n")
for (i in 1:length(harmonic_centrality)) {
  cat(sprintf("Node %d: %.4f\n", i, harmonic_centrality[i]))
}