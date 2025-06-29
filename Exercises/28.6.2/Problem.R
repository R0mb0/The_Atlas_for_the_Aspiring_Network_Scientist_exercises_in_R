# Calculate the probabilistic degree distribution of the network used
# in exercise 1. (Note, you can ignore the fourth column for this
# exercise)

library(here)

# Reading the data 
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

nodes <- sort(unique(c(edges$node1, edges$node2)))
n_nodes <- length(nodes)
n_edges <- nrow(edges)
n_worlds <- 2^n_edges

# Write here the solution 