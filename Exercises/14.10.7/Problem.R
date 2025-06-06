# Calculate the k-core decomposition of the network in http://www.
# networkatlas.eu/exercises/14/7/data.txt. What’s the highest
# core number in the network? How many nodes are part of the
# maximum core?

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=FALSE)

# Write here the solution 