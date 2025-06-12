# Perform 1, 000 edge swaps, creating a null version of the network
# in http://www.networkatlas.eu/exercises/19/1/data.txt. Make
# sure you don’t create parallel edges. Calculate the Kolmogorov-
# Smirnov distance between the two degree distributions. Can you
# tell the difference?

library(here)
library(igraph)

# Reading data and create the graph
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution 