# Calculate the length of the shortest path between node 2 and node
# 4 in the previous network using fuzzy logic, assuming that the
# third column reports the probability of the edge to have weight 1
# and the fourth column reports the probability of the edge to have
# weight 2.

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_1", "p_2")
edges$p_1 <- as.numeric(edges$p_1)
edges$p_2 <- as.numeric(edges$p_2)

n_edges <- nrow(edges)
nodes <- sort(unique(c(edges$node1, edges$node2)))

# Solution 

# Generating all possible edge weight combinations (worlds)
worlds <- expand.grid(replicate(n_edges, c(1,2), simplify=FALSE))
colnames(worlds) <- paste0("edge", 1:n_edges)

# Function to get probability of a world
world_prob <- function(weights, p1s, p2s) {
  prod(ifelse(weights == 1, p1s, p2s))
}

# For each world, calculate shortest path from 2 to 4
dist_probs <- list()
for (i in 1:nrow(worlds)) {
  weights <- as.numeric(worlds[i,])
  # World probability
  prob <- world_prob(weights, edges$p_1, edges$p_2)
  # Constructing weighted graph for this world
  g_world <- graph_from_data_frame(
    edges[, 1:2], directed=FALSE, vertices=nodes
  )
  E(g_world)$weight <- weights
  # Computing shortest path length from 2 to 4
  path_len <- suppressWarnings(shortest.paths(g_world, v="2", to="4", mode="all", weights=E(g_world)$weight))
  # If no path, path_len will be Inf
  if (is.infinite(path_len)) {
    path_len <- NA
  }
  # Adding probability to this path length
  key <- as.character(path_len)
  if (is.null(dist_probs[[key]])) dist_probs[[key]] <- 0
  dist_probs[[key]] <- dist_probs[[key]] + prob
}

# Printing the fuzzy shortest path distribution
cat("Fuzzy shortest path length distribution (from node 2 to 4):\n")
for (k in sort(names(dist_probs))) {
  if (is.na(as.numeric(k))) {
    cat(sprintf("  No path: P = %.4f\n", dist_probs[[k]]))
  } else {
    cat(sprintf("  Length = %s: P = %.4f\n", k, dist_probs[[k]]))
  }
}