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

# Solution 

# Counting motif3 appearances in the network
motif3_count <- count_subgraph_isomorphisms(motif3, g)

# Counting motif4 appearances in the network
motif4_count <- count_subgraph_isomorphisms(motif4, g)

# Calculating the special clustering coefficient
# This is the fraction of motif3 that are closed as motif4
if (motif3_count > 0) {
  special_clustering_coeff <- motif4_count / motif3_count
} else {
  special_clustering_coeff <- NA
}

# Printing the value of the special clustering coefficient
cat("The value of the special clustering coefficient is", special_clustering_coeff, "\n")