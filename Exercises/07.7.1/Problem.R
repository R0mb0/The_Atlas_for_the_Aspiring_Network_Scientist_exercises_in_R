# The network in http://www.networkatlas.eu/exercises/7/1/
# data.txt is bipartite. Identify the nodes in either type and find the
# nodes, in either type, with the most neighbors.

library(here)
library(igraph)

# Reading data 
edges <- read.table("data.txt", header=FALSE)

# Write here the solution 