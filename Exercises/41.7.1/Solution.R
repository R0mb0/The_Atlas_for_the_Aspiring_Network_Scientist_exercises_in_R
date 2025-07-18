# Test whether the motifs in http://www.networkatlas.eu/exercises/
# 41/1/motif1.txt, http://www.networkatlas.eu/exercises/41/
# 1/motif2.txt, http://www.networkatlas.eu/exercises/41/1/
# motif3.txt, and http://www.networkatlas.eu/exercises/41/1/
# motif4.txt appear in the network at http://www.networkatlas.
# eu/exercises/41/1/data.txt.

library(igraph)
library(here)

# Loading the network data from the file
network_data <- read.table(here("data.txt"), header = FALSE)
# Building the graph from the edge list
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Defining motif1 edge list and building the motif graph
motif1_edges <- matrix(c(1,2, 1,3), ncol=2, byrow=TRUE)
motif1 <- graph_from_edgelist(motif1_edges, directed=FALSE)

# Defining motif2 edge list and building the motif graph
motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)

# Defining motif3 edge list and building the motif graph
motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)

# Defining motif4 edge list and building the motif graph
motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)

# Solution 

# Getting the adjacency matrices for motifs
motif1_mat <- as.matrix(get.adjacency(motif1))
motif2_mat <- as.matrix(get.adjacency(motif2))
motif3_mat <- as.matrix(get.adjacency(motif3))
motif4_mat <- as.matrix(get.adjacency(motif4))

# Defining a function to check for motif appearances
find_motif <- function(graph, motif_graph) {
  # Searching for the motif in the network
  count <- count_subgraph_isomorphisms(motif_graph, graph)
  return(count)
}

# Checking for each motif in the network
cat("motif1 appears", find_motif(g, motif1), "times\n")
cat("motif2 appears", find_motif(g, motif2), "times\n")
cat("motif3 appears", find_motif(g, motif3), "times\n")
cat("motif4 appears", find_motif(g, motif4), "times\n")