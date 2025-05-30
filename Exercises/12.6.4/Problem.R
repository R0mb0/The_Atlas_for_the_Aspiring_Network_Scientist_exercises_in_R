# What is the size in number of nodes of the largest maximal clique
# of the network used in the previous question? Which nodes are
# part of it?

library(here)
#library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution 