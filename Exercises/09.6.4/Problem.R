# Plot the degree distribution of the network at http://www.networkatlas.
# eu/exercises/9/4/data.txt. Start from a plain degree distribu-
# tion, then in log-log scale, finally plot the complement of the
# cumulative distribution.

library(here)
library(igraph)

# Read the edge list
edges <- read.table("data.txt", header=FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Compute degree for each node
deg <- degree(g)

# Write here the solution