# Estimate the reliabilities of node 4 from the previous network with
# each of the other nodes in the network. (Note, you can ignore the
# fourth column for this exercise)

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

nodes <- sort(unique(c(edges$node1, edges$node2)))
n_edges <- nrow(edges)
n_worlds <- 2^n_edges
target_node <- "4"
other_nodes <- setdiff(nodes, target_node)

# Write here the solution
