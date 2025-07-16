# Use the maximum edge weight pointing to a community as a
# guiding principle to merge nodes into communities using the
# bottom-up approach. (An easy way is to just condense the graph
# by merging the two nodes with the maximum edge weight, for
# every edge in the network)

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Initializing membership: each node is its own community
membership <- seq_along(V(g))
names(membership) <- V(g)$name

# Copying the graph for iterative merging
g_merge <- g

# Tracking modularity after each merge
mod_vals <- c()

# Write here the solution