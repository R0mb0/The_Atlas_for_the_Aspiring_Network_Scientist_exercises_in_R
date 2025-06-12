# Implement an SI model on the network at http://www.networkatlas.
# eu/exercises/20/1/data.txt. Run it 10 times with different β values:
# 0.05, 0.1, and 0.2. For each run (in this and all following
# questions) pick a random node and place it in the Infected state.
# What’s the average time step in which each of those β infects 80%
# of the network?

library(here)
library(igraph)

# Reading the data and build the graph 
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# Write here the solution 