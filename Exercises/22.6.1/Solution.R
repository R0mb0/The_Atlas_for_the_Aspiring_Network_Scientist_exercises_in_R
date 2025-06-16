# Plot the number of nodes in the largest connected component
# as you remove 2, 000 random nodes, one at a time, from the net-
# work at http://www.networkatlas.eu/exercises/22/1/data.txt.
# (Repeat 10 times and plot the average result)

library(here)
library(igraph)

# Loading and remapping the network, assigning unique character names to vertices
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_names <- as.character(nodes)
node_map <- setNames(node_names, nodes)
edges_named <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g_full <- graph_from_edgelist(as.matrix(edges_named), directed=FALSE)
V(g_full)$name <- as.character(V(g_full)$name) # Ensuring names are character

# Solution 

steps <- 2000
runs <- 10
set.seed(42)
largest_cc_mat <- matrix(NA, nrow=steps+1, ncol=runs)

for (r in 1:runs) {
  g <- g_full
  remaining_names <- V(g)$name
  largest_cc <- numeric(steps+1)
  largest_cc[1] <- max(components(g)$csize)
  remove_order <- sample(remaining_names, steps)
  for (i in 1:steps) {
    if (remove_order[i] %in% V(g)$name) {
      g <- delete_vertices(g, remove_order[i])
    }
    if (vcount(g) > 0) {
      largest_cc[i+1] <- max(components(g)$csize)
    } else {
      largest_cc[(i+1):(steps+1)] <- 0
      break
    }
  }
  largest_cc_mat[,r] <- largest_cc
}

# Averaging over runs
mean_largest_cc <- rowMeans(largest_cc_mat)

# Plotting
plot(0:steps, mean_largest_cc, type="l", lwd=2,
     xlab="Number of nodes removed",
     ylab="Size of largest connected component (average over 10 runs)",
     main="Random Node Removal: Largest Connected Component")