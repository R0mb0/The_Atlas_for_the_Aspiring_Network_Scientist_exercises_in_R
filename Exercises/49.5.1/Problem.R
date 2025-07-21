# Import the network at http://www.networkatlas.eu/exercises/
# 49/1/data.txt, calculate the nodes’ degrees and use them to set
# the node size. Make sure you scale it logarithmically. This can be
# performed entirely via Cytoscape. (The solution will be provided
# as a Cytoscape session file)

library(here)
library(igraph)

# Reading the edge list from the local file
edges <- read.table(here("data.txt"), header = FALSE)

# Building the network graph from the edge list
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Solution 