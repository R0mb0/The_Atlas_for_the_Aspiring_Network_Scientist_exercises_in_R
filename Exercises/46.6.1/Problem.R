# Perform label percolation community discovery on the network at
# http://www.networkatlas.eu/exercises/46/1/data.txt. Use the
# detected communities to summarize the graph via aggregation.

library(igraph)
library(here)

# Reading the edge list from the data.txt file in the script folder
edges <- read.table(here("data.txt"), header = FALSE)

# Building the graph from the edge list
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Write here the solution 