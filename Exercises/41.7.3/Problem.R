# Suppose you define a new type of clustering coefficient that is
# closing http://www.networkatlas.eu/exercises/41/1/motif3.
# txt with http://www.networkatlas.eu/exercises/41/1/motif4.
# txt. What would be the value of this special clustering coefficient
# in the network?

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Building motif3 graph
motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)

# Building motif4 graph
motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)

# Write here the solution 