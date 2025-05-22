# Calculate the adjacency matrix, the stochastic adjacency matrix,
# and the graph Laplacian for the network in http://www.
# networkatlas.eu/exercises/8/1/data.txt.

library(here)
library(igraph)

# Loading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")

# Generating a plot (optional)
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution