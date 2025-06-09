# Calculate the structural equivalence of all pairs of nodes from the
# network used in the previous question. Which two nodes are the
# most similar? (Note: there could be ties)
# Calculate the structural equivalence of all pairs of nodes from the
# network used in the previous question. Which two nodes are the
# most similar? (Note: there could be ties)

library(here)
library(igraph)

# Reading data and build the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution