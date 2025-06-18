# Can you calculate the doubly stochastic adjacency matrix of
# the network used in the previous exercise? Does the calculation
# eventually converge? (Limit the normalization attempts to 1,000. If
# by 1,000 normalizations you don’t have a doubly stochastic matrix,
# the calculation didn’t converge)

library(here)
library(igraph)

# Reading the edge list from file
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Write here the solution 