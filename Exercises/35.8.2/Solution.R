# Find the local communities in the same network using the same
# lgorithm, by only looking at the 2-step neighborhood of nodes 1,
# 21, and 181.

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building the graph 
g <- graph_from_data_frame(edges, directed=FALSE)

# List of reference nodes
ref_nodes <- c("1", "21", "181")

# Solution 

for(ref in ref_nodes) {
  # Finding 2-step neighborhood
  neighbors_2step <- ego(g, order=2, nodes=ref, mode="all")[[1]]
  # Induce subgraph
  subg <- induced_subgraph(g, neighbors_2step)
  # Running label propagation
  com <- cluster_label_prop(subg)
  membership <- membership(com)
  ref_community <- membership[ref]
  nodes_same_community <- names(membership)[membership == ref_community]
  cat(sprintf("\nNodes in the same local community (2-step neighborhood) as node %s:\n", ref))
  print(nodes_same_community)
}