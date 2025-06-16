# Perform the same operation as the one from the previous exercise,
# but for the network at http://www.networkatlas.eu/exercises/
# 22/2/data.txt. Can you tell which is the network with a power
# law degree distribution and which is the Gn,p network?

library(here)
library(igraph)

# Reading the edge list and building the graph
edge_list <- read.table("data.txt", header=FALSE)
colnames(edge_list) <- c("from", "to")

edge_list[] <- lapply(edge_list, as.character)

g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)

# Solution 

num_remove <- 2000
num_runs <- 10
lcc_sizes <- matrix(NA, nrow = num_remove, ncol = num_runs)

set.seed(42)
for(run in 1:num_runs) {
  g_temp <- g
  nodes <- V(g_temp)$name
  nodes_to_remove <- sample(nodes, num_remove)
  for(i in 1:num_remove) {
    g_temp <- delete_vertices(g_temp, nodes_to_remove[i])
    cl <- components(g_temp)
    lcc_sizes[i, run] <- if (vcount(g_temp) > 0) max(cl$csize) else 0
  }
}

avg_lcc <- rowMeans(lcc_sizes)

# Plotting the results
plot(1:num_remove, avg_lcc, type = "l",
     xlab = "Number of nodes removed",
     ylab = "Size of largest connected component",
     main = "Network Robustness: Random Node Removal")