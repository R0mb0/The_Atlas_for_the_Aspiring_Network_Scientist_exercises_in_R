# Do you get larger KS distances if you perform 2, 000 swaps? Do
# you get smaller KS distances if you perform 500?

library(here)
library(igraph)

# Reading data and Creating the graph
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution