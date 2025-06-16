# Plot the number of nodes in the largest connected component
# as you remove 2, 000 nodes, one at a time, in descending degree
# order, from the networks used for the previous exercises. Does the
# result confirm your answer to the previous question about which
# network is of which type?

library(here)
library(igraph)

# Reading the edge list and building the graph
edge_list <- read.table("data.txt", header=FALSE)
colnames(edge_list) <- c("from", "to")
edge_list[] <- lapply(edge_list, as.character)
g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)

# Solution 

num_remove <- 2000
lcc_sizes <- numeric(num_remove)

g_temp <- g
for (i in 1:num_remove) {
  if (vcount(g_temp) == 0) {
    lcc_sizes[i:num_remove] <- 0
    break
  }
  degs <- degree(g_temp)
  # Picking the node(s) with the highest degree (randomly if tie)
  max_deg <- max(degs)
  candidates <- names(degs)[degs == max_deg]
  to_remove <- sample(candidates, 1)
  g_temp <- delete_vertices(g_temp, to_remove)
  cl <- components(g_temp)
  lcc_sizes[i] <- if (vcount(g_temp) > 0) max(cl$csize) else 0
}

# Plotting the results 
plot(1:num_remove, lcc_sizes, type = "l",
     xlab = "Number of nodes removed (highest degree first)",
     ylab = "Size of largest connected component",
     main = paste("Targeted Attack: Largest Component vs. Nodes Removed\n", filename))