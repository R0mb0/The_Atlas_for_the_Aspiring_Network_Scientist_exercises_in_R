# Implement the MPGNN described in Section 44.1. You need to
# define an “aggregate” function which takes a list of nodes and
# their embeddings and returns the element-wise mean of those
# embeddings. You need to define an “update” function which takes
# two vectors, sums them, and return their softmax. Finally, you
# need a message-passing function which loops over all nodes of the
# network, applies aggregate to its neighbors, and applies update
# with the result of the aggregation and the node’s embedding. Run
# a single layer of it on the network at http://www.networkatlas.
# eu/exercises/44/1/network.txt, with node features at http:
# //www.networkatlas.eu/exercises/44/1/features.txt. Do you
# get the same results as Figure 44.1?

library(here)
library(Matrix)

# Loading the node features
features <- as.matrix(read.table(here("features.txt")))

# Loading the edge list and building the graph
edges <- as.matrix(read.table(here("network.txt")))
num_nodes <- nrow(features)

# Write here the solution 