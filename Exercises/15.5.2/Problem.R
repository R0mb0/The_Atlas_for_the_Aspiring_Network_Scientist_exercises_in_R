# Use the network from the previous question to distinguish be-
# tween core community nodes (high degree nodes with all their
# connections going to members of their own community) and
# peripheral community nodes (low degree nodes with all their
# connections going to members of their own community).

library(here)
library(igraph)

# Reading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)
V(g)$community <- comms$community[match(V(g)$name, comms$node)]

# Write here the solution 