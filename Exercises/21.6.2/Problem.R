# Modify the SI model developed in the previous exercise so that
# it works with a cascade trigger. Set β = 0.1 and compare the I
# infection curves for the three triggers on the network used in the
# previous exercise (average over 10 runs, each run of 50 steps).

library(here)
library(igraph)

# Read and remap the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# write here the solution 
