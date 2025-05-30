# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)
#library(igraph)

# Reading the hypergraph data (each line is a hyperedge)
lines <- readLines("data.txt")
hyperedges <- lapply(lines, function(x) strsplit(x, "\\s+")[[1]])

# Write here the solution 