# Generate a configuration model with the same degree distribution
# as the network in http://www.networkatlas.eu/exercises/18/1/
# data.txt. Perform the Kolmogorov-Smirnov test between the two
# degree distributions.

library(here)
library(igraph)

# Reading edge list and remapping node IDs
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution