# What’s the most central node in the network used for the previous
# exercise according to PageRank? How does PageRank compares
# with the in-degree? (for instance, you could calculate the Spear-
# man and/or Pearson correlation between the two)

library(here)
library(igraph)

# Building the graph (reusing your code)
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Write here the solution 