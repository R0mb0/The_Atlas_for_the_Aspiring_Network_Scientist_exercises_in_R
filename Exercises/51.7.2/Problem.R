# Which network layout is more suitable to visualize the network at
# http://www.networkatlas.eu/exercises/51/2/data.txt? Choose
# between hierarchical, force directed, and circular. You might
# want to use the node attributes at http://www.networkatlas.
# eu/exercises/51/2/nodes.txt to enhance your visualization.
# Visualize it using all three alternatives and motivate your answer
# based on the result and the characteristics of the network.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
colnames(edges) <- c("from", "to")

# Loading the node attributes
nodes <- read.table(here("nodes.txt"), sep="\t", header=FALSE)
colnames(nodes) <- c("name", "region")

# Building the graph
g <- graph_from_data_frame(edges, vertices=nodes, directed=FALSE)

# Write here the solution 