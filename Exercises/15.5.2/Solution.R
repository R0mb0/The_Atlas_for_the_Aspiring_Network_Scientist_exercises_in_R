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

# Solution 

# Computing degree and neighbor community fractions
V(g)$degree <- degree(g)

V(g)$own_comm_frac <- sapply(V(g), function(v) {
  neighbor_comms <- V(g)$community[neighbors(g, v)]
  own_comm <- V(g)$community[v]
  if (length(neighbor_comms) == 0) return(NA)
  sum(neighbor_comms == own_comm) / length(neighbor_comms)
})

# Classifying nodes
high_degree_threshold <- quantile(V(g)$degree, 0.75)
low_degree_threshold  <- quantile(V(g)$degree, 0.25)

V(g)$comm_role <- NA
V(g)$comm_role[V(g)$own_comm_frac == 1 & V(g)$degree >= high_degree_threshold] <- "core"
V(g)$comm_role[V(g)$own_comm_frac == 1 & V(g)$degree <= low_degree_threshold]  <- "peripheral"
V(g)$comm_role[is.na(V(g)$comm_role)] <- "other"

# Printign the results
results <- data.frame(
  node = V(g)$name,
  community = V(g)$community,
  degree = V(g)$degree,
  own_comm_frac = V(g)$own_comm_frac,
  comm_role = V(g)$comm_role
)
print(results[order(-results$degree), ])