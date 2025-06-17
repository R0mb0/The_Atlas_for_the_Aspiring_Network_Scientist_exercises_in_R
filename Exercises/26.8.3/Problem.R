# Perform a network projection of the previously used bipartite
# network using hyperbolic weights. Draw a scatter plot comparing
# hyperbolic and simple weights.

library(here)
library(igraph)
library(Matrix)

# Reading the bipartite edge list
edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(edges) <- c("V1", "V2")

# Write here the solution