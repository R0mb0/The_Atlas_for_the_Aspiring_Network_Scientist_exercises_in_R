# The network at http://www.networkatlas.eu/exercises/32/
# 2/data.txt has multiple cores/communities. Use the Divisive
# algorithm from cpalgorithm to find the multiple cores in the
# network.

library(here)
library(igraph)

# Loading edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Write here the solution 