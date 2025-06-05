# What is the size in number of nodes of the largest independent
# set of the network used in the previous question? (Approximate
# answers are acceptable) Which nodes are part of it?

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Write here the solution