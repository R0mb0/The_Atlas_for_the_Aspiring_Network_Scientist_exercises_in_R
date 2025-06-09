# Generate an Erdős-Rényi graph with the same number of nodes
# and edges as the network used for question 1. Calculate and
# compare the networks’ clustering coefficients. Compare this with
# the connection probability p of the random graph (which you
# should derive from the number of edges and number of nodes
# using the formula I show in this chapter).

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Number of nodes and edges
n_nodes <- vcount(g)
n_edges <- ecount(g)

# Write here the solution