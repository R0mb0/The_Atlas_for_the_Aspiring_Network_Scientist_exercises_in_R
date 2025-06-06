# Which is the most authoritative node in the network used for
# the previous question? Which one is the best hub? Use the HITS
# algorithm to motivate your answer (if using networkx, use the
# scipy version of the algorithm).

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Write here the solution