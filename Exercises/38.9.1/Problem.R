# Use the k-clique algorithm to find overlapping communities in the
# network at http://www.networkatlas.eu/exercises/38/1/data.
# txt. Test how many nodes are part of no community for k equal to
# 3, 4, and 5.


library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Removing weights for clique percolation
g_unweighted <- delete_edge_attr(g, "weight")

# Write here the solution