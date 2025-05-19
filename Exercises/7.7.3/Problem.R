# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)

# Read the data
lines <- readLines("data.txt")
# Converting data to a list of node numbers
hyperedges <- lapply(lines, function(line) as.numeric(strsplit(line, " ")[[1]]))

# Write here the solution 