#Now perform asynchronous label propagation directly on the
#bipartite structure. Calculate the NMI with the ground truth. Since
#asynchronous label propagation is randomized, take the average of
#ten runs. Do you get a higher NMI?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Write here the solution 