# Perform the same operation as the one from the previous exercise,
# but for the network at http://www.networkatlas.eu/exercises/
# 22/2/data.txt. Can you tell which is the network with a power
# law degree distribution and which is the Gn,p network?

library(here)
library(igraph)

# Reading the edge list and building the graph
edge_list <- read.table("data.txt", header=FALSE)
colnames(edge_list) <- c("from", "to")

edge_list[] <- lapply(edge_list, as.character)

g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)

# Write here the solution 