# Generate the two-order line graph of the network at http://www.
# networkatlas.eu/exercises/34/3/data.txt, using the average
# edge betweenness of the edges as the edge weight.

library(here)
library(igraph)

# Loading the edge list from file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building the original graph from the edge list
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution