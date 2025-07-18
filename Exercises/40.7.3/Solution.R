# Calculate the redundancy of each community you found for the
# previous exercises.

library(here)
library(igraph)

# Loading the multilayer edge list
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "layer")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Loading the ground truth partition
nodes <- read.table(here("nodes.txt"))
gt_comm <- as.character(nodes$V2)
names(gt_comm) <- as.character(nodes$V1)

# Solution 

# Building the weighted flattened network
edge_pairs <- data.frame(
  from = pmin(edges$from, edges$to),
  to = pmax(edges$from, edges$to)
)
edge_weights <- aggregate(layer ~ from + to, data = cbind(edge_pairs, layer=edges$layer), FUN=length)
g_weighted <- graph_from_data_frame(edge_weights[,c("from", "to")], directed=FALSE)
E(g_weighted)$weight <- edge_weights$layer

# Running label propagation to get communities
lp_weighted <- cluster_label_prop(g_weighted, weights=E(g_weighted)$weight)
memb <- membership(lp_weighted)

# Calculating redundancy for each community
communities <- unique(memb)
redundancy <- numeric(length(communities))

for (i in seq_along(communities)) {
  comm <- communities[i]
  comm_nodes <- names(memb)[memb == comm]
  subgraph <- induced_subgraph(g_weighted, comm_nodes)
  # Getting the edge weights for the subgraph
  weights_vec <- E(subgraph)$weight
  # Calculating redundancy: average number of layers per edge in the community
  if (length(weights_vec) > 0) {
    redundancy[i] <- mean(weights_vec)
  } else {
    redundancy[i] <- NA
  }
}

# Printing redundancy for each community
for (i in seq_along(communities)) {
  cat(sprintf("Redundancy for community %s: %.2f\n", communities[i], redundancy[i]))
}