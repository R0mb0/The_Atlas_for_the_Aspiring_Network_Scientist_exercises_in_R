# Which network layout is more suitable to visualize the network at
# http://www.networkatlas.eu/exercises/51/3/data.txt? Choose
# between hierarchical, force directed, and circular. Visualize it using
# all three alternatives and motivate your answer based on the result
# and the characteristics of the network.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution