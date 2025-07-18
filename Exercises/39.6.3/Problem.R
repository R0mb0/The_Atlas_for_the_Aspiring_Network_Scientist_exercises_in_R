# Consider the bi-adjacency matrix as a data table and perform
# bi-clustering on it, using any bi-clustering algorithm provided in
# the scikit-learn library. Do you get a higher NMI than in the
# previous two cases?

#__The data for this exercise is bad. How can you understand this? ________

library(here)
library(igraph)
library(biclust)

# Loading the edge list
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Write here the solution