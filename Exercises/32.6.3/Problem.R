# http://www.networkatlas.eu/exercises/32/3/data.txt contains
# a nested bipartite network. Draw its adjacency matrix, sorting
# rows and columns by their degree.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building bipartite graph
# Assuming 'from' are type A (start with 'a'), 'to' are type B (start with 'b')
g <- graph_from_data_frame(edges, directed = FALSE)

# Identifying type A and type B nodes
typeA <- unique(edges$from)
typeB <- unique(edges$to)

# Write here the solution