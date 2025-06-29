# Calculate the probabilistic degree distribution of the network used
# in exercise 1. (Note, you can ignore the fourth column for this
# exercise)

library(here)

# Reading the data 
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

nodes <- sort(unique(c(edges$node1, edges$node2)))
n_nodes <- length(nodes)
n_edges <- nrow(edges)
n_worlds <- 2^n_edges

# Solution 

# Generating all possible worlds (edge presence/absence)
worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
colnames(worlds) <- paste0("edge", 1:n_edges)

# Tracking degree distribution for each node
max_degree <- n_edges  # upper bound for degree in this small network
deg_probs <- matrix(0, nrow=n_nodes, ncol=max_degree+1, dimnames=list(nodes, 0:max_degree))

for(i in 1:nrow(worlds)) {
  world <- as.numeric(worlds[i,])
  # For each edge, use p if present, (1-p) if absent
  probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
  prob_world <- prod(probs)
  
  # Building adjacency for this world
  adj <- matrix(0, nrow=n_nodes, ncol=n_nodes, dimnames=list(nodes, nodes))
  for(j in seq_len(n_edges)) {
    if (world[j] == 1) {
      a <- as.character(edges$node1[j])
      b <- as.character(edges$node2[j])
      adj[a, b] <- 1
      adj[b, a] <- 1
    }
  }
  # Calculating degree for each node in this world
  degs <- rowSums(adj)
  for (k in seq_along(nodes)) {
    deg_val <- degs[k]
    deg_probs[k, deg_val+1] <- deg_probs[k, deg_val+1] + prob_world
  }
}

# Printing the results
cat("Probabilistic degree distribution for each node:\n")
for (i in seq_along(nodes)) {
  node <- nodes[i]
  dist <- deg_probs[i,]
  nonzero <- which(dist > 0)
  cat(sprintf("Node %s:\n", node))
  for (d in nonzero-1) {
    cat(sprintf("  Degree %d: P = %.4f\n", d, dist[d+1]))
  }
}