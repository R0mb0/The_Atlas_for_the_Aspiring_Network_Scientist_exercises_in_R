# You’re given the undirected signed network at http://www.
# networkatlas.eu/exercises/24/1/data.txt. Count the number of
# triangles of the four possible types.

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to", "sign")
edges[] <- lapply(edges, as.character)
edges$sign <- as.numeric(edges$sign)

# Building an undirected network, keeping edge signs as attribute
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution