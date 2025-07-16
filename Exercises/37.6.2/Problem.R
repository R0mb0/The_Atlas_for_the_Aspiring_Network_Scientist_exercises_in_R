# Change the splitting criterion of the algorithm, using the inverse
# edge weight rather than edge betweenness. Since this is much
# faster, you can perform the first 20 splits. Do you get higher or
# lower modularity relative to the result from exercise 1?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution 