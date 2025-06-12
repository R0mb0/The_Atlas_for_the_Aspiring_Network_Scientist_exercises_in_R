# Repeat the experiment in the previous question, but now generate
# 50 Watts-Strogatz small world models, with the same number of
# nodes as the original network and setting k = 16 and p = 0.1.

library(here)
library(igraph)

# Reading the data and building the graph 
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution 