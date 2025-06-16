# Run a classical SIR model on the network used in the previous
# exercise, but set the recovery probability µ = 0. At each timestep,
# before the infection phase pick a random node. Pick one random
# neighbor in status S, if it has one, and transition it to the R state.
# Compare the I infection curves with and without immunization,
# with β = 0.1 (average over 10 runs, each run of 50 steps).

library(here)
library(igraph)

# Reading the network
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# Write here the solution