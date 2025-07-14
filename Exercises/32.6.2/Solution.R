# The network at http://www.networkatlas.eu/exercises/32/
# 2/data.txt has multiple cores/communities. Use the Divisive
# algorithm from cpalgorithm to find the multiple cores in the
# network.

library(here)
library(igraph)

# Loading edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Solution 

# Finding communities using the divisive edge betweenness algorithm
ceb <- cluster_edge_betweenness(g)

# Printing the number of communities
cat("Number of cores/communities found:", length(ceb), "\n")

# Printing the membership for each node
for (i in seq_along(ceb)) {
  cat(sprintf("Core/Community %d: %s\n", i, paste(ceb[[i]], collapse = ", ")))
}