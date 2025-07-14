# Find the communities in the network at http://www.networkatlas.
# eu/exercises/35/1/data.txt using the label propagation strategy.
# Which nodes are in the same community as node 1?

library(here)
library(igraph)

# Loading the edge list and build the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution 