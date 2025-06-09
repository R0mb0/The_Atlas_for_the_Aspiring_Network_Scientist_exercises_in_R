# Remove the self-loops and parallel edges from the synthetic
# network you generated in the previous question. Note the % of
# edges you lost. Re-perform the Kolmogorov-Smirnov test with the
# original network’s degree distribution.

library(here)
library(igraph)

# Reading edge list and remapping node IDs
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Creating configuration model with the same degree distribution
deg_seq <- degree(g)
g_conf <- sample_degseq(deg_seq, method="simple")

# Write here the solution