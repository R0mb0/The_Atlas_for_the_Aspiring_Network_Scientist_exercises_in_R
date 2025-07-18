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

# Write here the solution 