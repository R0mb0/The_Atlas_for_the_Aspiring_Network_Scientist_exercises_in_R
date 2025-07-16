# Use the edge betweenness algorithm to find hierarchical communities
# in the network at http://www.networkatlas.eu/exercises/
# 37/1/data.txt. Since the algorithm has high time complexity,
# perform only the first 10 splits. What is the split with the highest
# modularity?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution