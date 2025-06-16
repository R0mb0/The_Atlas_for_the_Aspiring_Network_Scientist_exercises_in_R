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

# Write here the solution 