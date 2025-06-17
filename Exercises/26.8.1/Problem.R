# Perform a network projection of the bipartite network at http:
# //www.networkatlas.eu/exercises/26/1/data.txt using simple
# weights. The unipartite projection should only contain nodes of
# type 1 (|V1 | = 248). How dense is the projection?

library(here)
library(igraph)

# Reading the bipartite edge list
edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(edges) <- c("V1", "V2")

# Write here the solution