# Plot the number of nodes in the largest connected component
# as you remove 2, 000 random nodes, one at a time, from the net-
# work at http://www.networkatlas.eu/exercises/22/1/data.txt.
# (Repeat 10 times and plot the average result)

library(here)
library(igraph)

# Loading and remapping the network, assigning unique character names to vertices
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_names <- as.character(nodes)
node_map <- setNames(node_names, nodes)
edges_named <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g_full <- graph_from_edgelist(as.matrix(edges_named), directed=FALSE)
V(g_full)$name <- as.character(V(g_full)$name) # Ensuring names are character

# Write here the solution 