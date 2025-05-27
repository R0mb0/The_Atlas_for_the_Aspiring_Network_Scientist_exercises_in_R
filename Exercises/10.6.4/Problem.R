# How many weakly and strongly connected component does the
# network used in the previous question have? Compare their sizes,
# in number of nodes, with the entire network. Which nodes are in
# these two components?

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)

# Write here the solution