# Find the communities in the network at http://www.networkatlas.
# eu/exercises/35/1/data.txt using the label propagation strategy.
# Which nodes are in the same community as node 1?

library(here)
library(igraph)

# Loading the edge list and build the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Running label propagation community detection
com <- cluster_label_prop(g)

# Finding the membership vector (community assignments)
membership <- membership(com)

# Getting the community of node 1
node1_community <- membership["1"]

# List all nodes in the same community as node 1
nodes_same_community <- names(membership)[membership == node1_community]

# Printing the results
cat("Nodes in the same community as node 1:\n")
print(nodes_same_community)