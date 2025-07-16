# Use the k-clique algorithm to find overlapping communities in the
# network at http://www.networkatlas.eu/exercises/38/1/data.
# txt. Test how many nodes are part of no community for k equal to
# 3, 4, and 5.


library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Removing weights for clique percolation
g_unweighted <- delete_edge_attr(g, "weight")

# This should be the solution

# Function to count nodes not in any community for a given k
count_nodes_no_community <- function(graph, k) {
  kc <- k_clique_communities(graph, k)
  # Get unique nodes in communities
  nodes_in_comms <- unique(unlist(kc))
  # Count nodes not in any community
  all_nodes <- V(graph)$name
  length(setdiff(all_nodes, nodes_in_comms))
}

# Testing for k = 3, 4, 5
for (k in 3:5) {
  cat(sprintf("Testing k = %d\n", k))
  n_no_comm <- count_nodes_no_community(g_unweighted, k)
  cat(sprintf("Nodes not in any %d-clique community: %d\n", k, n_no_comm))
}