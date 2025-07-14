# Prove whether the network from the previous questions is affected
# or not by the friendship paradox.

library(here)
library(igraph)

# Loading edge list from local file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building graph
g <- graph_from_data_frame(edges, directed=FALSE)

deg <- degree(g)
V(g)$deg <- deg

# Write here the solution