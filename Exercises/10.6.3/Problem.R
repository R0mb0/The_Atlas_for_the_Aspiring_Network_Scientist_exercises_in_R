# What is the average reciprocity in the network used in the previous
# question? How many nodes have a reciprocity of zero?

library(here)
library(igraph)

# Reading the data 
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)

# Write here the solution