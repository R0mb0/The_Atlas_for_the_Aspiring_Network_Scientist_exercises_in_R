# Generate the indegree and outdegree Laplacians of the directed
# graph at http://www.networkatlas.eu/exercises/8/4/data.
# txt. Calculate their eigenvalues as well as the eigenvalue of the
# undirected version of the graph.

library(here)
#library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")

# Write here the solution