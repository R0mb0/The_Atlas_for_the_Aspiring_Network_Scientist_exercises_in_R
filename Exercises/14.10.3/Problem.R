# Calculate the reach centrality for the network in http://www.
# networkatlas.eu/exercises/14/3/data.txt. Keep in mind that
# the network is directed and should be loaded as such. What’s the
# most central node? How does its reach centrality compare with the
# average reach centrality of all nodes in the network?

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Write here the solution 
