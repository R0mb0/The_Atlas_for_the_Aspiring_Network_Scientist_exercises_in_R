# Implement the copying model to grow the graph in http://www.
# networkatlas.eu/exercises/17/4/data.txt to 2, 000 nodes (for
# each incoming node, copy one edge from 2 nodes already present
# in the network). Compare the number of edges and the degree
# distribution exponent with networks generated with the strategies
# from the previous two questions.

library(here)
library(igraph)

# Reading and remapping edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution 