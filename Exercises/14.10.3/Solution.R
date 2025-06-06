# Calculate the reach centrality for the network in http://www.
# networkatlas.eu/exercises/14/3/data.txt. Keep in mind that
# the network is directed and should be loaded as such. What’s the
# most central node? How does its reach centrality compare with the
# average reach centrality of all nodes in the network?

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Solution 

# For each node, computing the number of reachable nodes (excluding itself)
reach_centrality <- sapply(V(g), function(v) {
  # Use subcomponent to get all nodes reachable from v (mode = 'out')
  reachable <- subcomponent(g, v, mode = "out")
  # Exclude self
  length(reachable) - 1
})

# Find the most central nodes
max_reach <- max(reach_centrality)
most_central_nodes <- which(reach_centrality == max_reach)

# Average reach centrality
avg_reach <- mean(reach_centrality)

cat("Reach centrality for each node:\n")
for (i in 1:length(reach_centrality)) {
  cat(sprintf("Node %s: %d\n", V(g)[i]$name, reach_centrality[i]))
}
cat("\n")

cat("Most central node(s):", paste(V(g)[most_central_nodes]$name, collapse=", "), "\n")
cat("Their reach centrality:", max_reach, "\n")
cat("Average reach centrality:", avg_reach, "\n")
cat(sprintf("The most central node's reach centrality is %.2f times the average.\n",
            max_reach / avg_reach))