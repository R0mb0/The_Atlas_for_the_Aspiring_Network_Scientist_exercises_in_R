# Suppose that the network at http://www.networkatlas.eu/
# exercises/35/3/data.txt is a second observation of the previ-
# ous network. Perform the label propagation community detection
# on it and use the Jaccard coefficient to determine how different the
# communities containing nodes 1, 21, and 181 are.

library(here)
library(igraph)

# Helper function to get community members for a node
get_community <- function(g, node) {
  com <- cluster_label_prop(g)
  membership <- membership(com)
  community_id <- membership[node]
  community_nodes <- names(membership)[membership == community_id]
  return(community_nodes)
}

# Loading both networks
edges1 <- read.table("data1.txt")
colnames(edges1) <- c("from", "to")
# Building the graph 
g1 <- graph_from_data_frame(edges1, directed=FALSE)

edges2 <- read.table("data2.txt")
colnames(edges2) <- c("from", "to")
# Build the graph 
g2 <- graph_from_data_frame(edges2, directed=FALSE)

# Nodes to check
nodes <- c("1", "21", "181")

# Write here the solution 