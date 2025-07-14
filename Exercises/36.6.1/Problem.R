# Detect communities of the network at http://www.networkatlas.
# eu/exercises/36/1/data.txt using the asynchronous and the
# semi-synchronous label propagation algorithms. Which one does
# return the highest modularity?

library(here)
library(igraph)

# Loading the edge list and build the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution