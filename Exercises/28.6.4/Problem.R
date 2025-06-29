# Calculate the length of the shortest path between node 2 and node
# 4 in the previous network using fuzzy logic, assuming that the
# third column reports the probability of the edge to have weight 1
# and the fourth column reports the probability of the edge to have
# weight 2.

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_1", "p_2")
edges$p_1 <- as.numeric(edges$p_1)
edges$p_2 <- as.numeric(edges$p_2)

n_edges <- nrow(edges)
nodes <- sort(unique(c(edges$node1, edges$node2)))

# Write here the solution