# Modify the SI model developed in the exercises of the previous
# chapter so that it works with a threshold trigger. Set κ = 2 and run
# the threshold trigger on the network at http://www.networkatlas.
# eu/exercises/21/1/data.txt. Show the curves of the size of
# the I state for it (average over 10 runs, each run of 50 steps) and
# compare it with a simple (no reinforcement) SI model with β =
# 0.2.

library(here)
library(igraph)

# Reading the data and remapping the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# Write here the solution 