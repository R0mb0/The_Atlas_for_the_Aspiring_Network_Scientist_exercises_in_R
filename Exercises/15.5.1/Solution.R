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

# Solution 

# Betweenness centrality
V(g)$betweenness <- betweenness(g, normalized=TRUE)

# Community mixing
get_neighbor_comms <- function(graph, v) {
  neighbor_comm <- V(graph)$community[neighbors(graph, v)]
  table(neighbor_comm)
}
V(g)$own_comm_frac <- sapply(V(g), function(v) {
  neighbor_comms <- get_neighbor_comms(g, v)
  own_comm <- V(g)$community[v]
  own <- neighbor_comms[as.character(own_comm)]
  total <- sum(neighbor_comms)
  ifelse(is.na(own), 0, own/total)
})

# Identifying brokers and gatekeepers
bet_threshold <- quantile(V(g)$betweenness, 0.9)
V(g)$role <- "other"
V(g)$role[V(g)$betweenness >= bet_threshold & V(g)$own_comm_frac <= 0.5] <- "broker"
V(g)$role[V(g)$betweenness >= bet_threshold & V(g)$own_comm_frac > 0.5] <- "gatekeeper"

# Printing the results 
results <- data.frame(
  node = V(g)$name,
  community = V(g)$community,
  betweenness = V(g)$betweenness,
  own_comm_frac = V(g)$own_comm_frac,
  role = V(g)$role
)
print(results[order(-results$betweenness), ])