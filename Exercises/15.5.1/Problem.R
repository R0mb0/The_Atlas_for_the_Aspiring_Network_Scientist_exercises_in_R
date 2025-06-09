# For the network at http://www.networkatlas.eu/exercises/15/
# 1/data.txt, I precomputed communities (http://www.networkatlas.
# eu/exercises/15/1/comms.txt). Use betweenness centrality to
# distinguish between brokers (high centrality nodes equally con-
# necting to different communities) and gatekeepers (high centrality
# nodes connecting with different communities but preferring their
# own).

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)
V(g)$community <- comms$community[match(V(g)$name, comms$node)]

# Write here the solution