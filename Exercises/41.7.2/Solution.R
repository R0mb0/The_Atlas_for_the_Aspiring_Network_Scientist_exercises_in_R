# How many times do the motifs from the previous question ap-
# pear in the network? http://www.networkatlas.eu/exercises/
# 41/1/motif2.txt is included in http://www.networkatlas.eu/
# exercises/41/1/motif3.txt: is the latter less frequent the former
# as we would require in an anti-monotonic counting function?

library(igraph)
library(here)

# Loading the network data from the file
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Building motif2 graph
motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)

# Building motif3 graph
motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)

# Solution 

# Counting how many times motif2 appears in the network
motif2_count <- count_subgraph_isomorphisms(motif2, g)

# Counting how many times motif3 appears in the network
motif3_count <- count_subgraph_isomorphisms(motif3, g)

# Printing the results
cat("motif2 appears", motif2_count, "times\n")
cat("motif3 appears", motif3_count, "times\n")

# Checking if motif3 is less frequent than motif2 as required by anti-monotonic counting
if (motif3_count < motif2_count) {
  cat("motif3 is less frequent than motif2, as required by an anti-monotonic counting function\n")
} else {
  cat("motif3 is NOT less frequent than motif2\n")
}