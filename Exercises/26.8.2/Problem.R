# Perform a network projection of the previously used bipartite
# network using cosine and Pearson weights. What is the Pearson
# correlation of these weights compared with the ones from the
# previous question?

library(here)
library(igraph)
library(Matrix)

# Reading the bipartite edge list
edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(edges) <- c("V1", "V2")

# Write here the solution 