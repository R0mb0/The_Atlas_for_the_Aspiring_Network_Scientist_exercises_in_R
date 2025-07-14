# The arborescence algorithm is simple: condense the graph to
# remove the strongly connected components and then remove
# random incoming edges from all nodes remaining with in-degree
# larger than one, until all nodes have in-degree of one or zero.
# Implement the algorithm and calculate the arborescence score.

library(here)
library(igraph)

# Loading directed edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = TRUE)
original_edge_count <- gsize(g)

# Write here the solution