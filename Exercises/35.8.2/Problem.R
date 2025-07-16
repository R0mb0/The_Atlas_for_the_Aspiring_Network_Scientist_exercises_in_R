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

# Write here the solution