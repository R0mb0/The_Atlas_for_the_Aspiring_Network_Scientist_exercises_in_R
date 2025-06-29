# Consider the network at http://www.networkatlas.eu/exercises/
# 28/1/data.txt. This is an undirected probabilistic network with
# four columns: the two connected nodes, the probability of the edge
# existing and the probability of the edge non existing. Generate all
# of its possible worlds, together with their probability of existing.
# (Note, you can ignore the fourth column for this exercise)

#library(here)
library(igraph)

#Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

n_edges <- nrow(edges)
n_worlds <- 2^n_edges

# Write here the solution