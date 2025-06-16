# What are the ten most likely edges to appear in the network at
# http://www.networkatlas.eu/exercises/23/1/data.txt accord-
# ing to the preferential attachment index?

library(here)
library(igraph)

# Reading the edge list and building the graph 
edges <- read.table("data.txt", header=FALSE)
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Write here the solution