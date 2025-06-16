# Modify the simple SI model so that nodes become resistant after
# the second failed infection attempt. Compare the I infection curves
# of the SI model before and after this operation on the network
# used in the previous exercise, with β = 0.3 (average over 10 runs,
# each run of 50 steps).

library(here)
library(igraph)

# Read and remap the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# Write here the solution 