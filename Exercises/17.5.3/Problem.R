# Implement the link selection model to grow the graph in http:
# //www.networkatlas.eu/exercises/17/3/data.txt to 2, 000 nodes
# (for each incoming node, copy 2 edges already present in the net-
# work). Compare the number of edges and the degree distribution
# exponent with a preferential attachment network with 2, 000 nodes
# and average degree of 2.

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE)
# Finding all unique node labels and create a mapping to 1:N
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)

# Remapping the edge list
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))

# Building the graph
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution