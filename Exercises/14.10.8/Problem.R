# What’s the degree of centralization of the network used in the
# previous question? Compare the answer you’d get by using, as
# your centrality measure, the degree, closeness, and betweenness
# centrality.

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=FALSE)

# Write here the solution