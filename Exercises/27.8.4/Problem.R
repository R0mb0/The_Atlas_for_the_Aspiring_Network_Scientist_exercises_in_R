# How many edges would you keep if you were to return the dou-
# bly stochastic backbone including all nodes in the network in a
# single (weakly) connected component with the minimum number
# of edges?

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Write here the solution