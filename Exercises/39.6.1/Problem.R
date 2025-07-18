# The network at http://www.networkatlas.eu/exercises/39/
# 1/data.txt is bipartite. Project it into unipartite and find five
# communities with the Girvan-Newman edge betweenness algorithm
# (repeat for both node types, so you find a total of ten
# communities). What is the NMI with the partition proposed at
# http://www.networkatlas.eu/exercises/39/1/nodes.txt?


#__The data for this exercise is bad. How can you understand this? ________

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Write here the solution