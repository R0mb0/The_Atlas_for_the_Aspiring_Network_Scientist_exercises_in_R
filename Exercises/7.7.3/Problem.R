# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)
#library(igraph)

# Reading your data
df <- read.table("data.txt", header=TRUE)

# Hyperedges as list: each row is a hyperedge, nonzero entries only
hyperedges <- apply(df, 1, function(row) as.numeric(row[row != 0]))

# Write here the solution 