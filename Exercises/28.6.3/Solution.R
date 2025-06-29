# Estimate the reliabilities of node 4 from the previous network with
# each of the other nodes in the network. (Note, you can ignore the
# fourth column for this exercise)

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

nodes <- sort(unique(c(edges$node1, edges$node2)))
n_edges <- nrow(edges)
n_worlds <- 2^n_edges
target_node <- "4"
other_nodes <- setdiff(nodes, target_node)

# Solution 

# Generating all possible worlds
worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
colnames(worlds) <- paste0("edge", 1:n_edges)

# Initializing reliabilities
reliabilities <- setNames(rep(0, length(other_nodes)), other_nodes)

for(i in 1:nrow(worlds)) {
  world <- as.numeric(worlds[i,])
  probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
  prob_world <- prod(probs)
  
  # Building igraph for this world
  present <- which(world == 1)
  if (length(present) == 0) next
  g_world <- graph_from_data_frame(
    edges[present, 1:2, drop=FALSE], directed=FALSE, vertices=nodes
  )
  
  # For each other node, check if connected to node 4
  for (node in other_nodes) {
    if (are.connected(g_world, as.character(target_node), as.character(node)) ||
        (target_node %in% V(g_world)$name && node %in% V(g_world)$name &&
         (length(shortest_paths(g_world, from=as.character(target_node), to=as.character(node))$vpath[[1]]) > 0
         ))) {
      reliabilities[node] <- reliabilities[node] + prob_world
    }
  }
}

# Printing results
cat(sprintf("Reliabilities of node %s with other nodes:\n", target_node))
for (node in other_nodes) {
  cat(sprintf("  Node %s: %.4f\n", node, reliabilities[node]))
}
