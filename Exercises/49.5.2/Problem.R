# Import the community information from http://www.networkatlas.
# eu/exercises/49/2/nodes.txt and use it to set the node color.
# (The solution will be provided as a Cytoscape session file)

library(here)
library(igraph)

# Reading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Reading the community information
node_community <- read.table(here("nodes.txt"), header = FALSE)
communities <- node_community$V2
names(communities) <- node_community$V1

# Assigning community info to nodes
V(g)$community <- communities[as.character(V(g)$name)]

# Write here the solution 