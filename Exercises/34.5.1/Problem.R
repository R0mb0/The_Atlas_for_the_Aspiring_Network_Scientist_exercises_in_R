# Calculate the distribution of the k2,0 and k2,1 degrees of the net-
# work at http://www.networkatlas.eu/exercises/34/1/data.txt.
# Assume every clique of the network to be a simplex.

library(here)

# Reading the edge list from a local file
edges <- read.table("data.txt")

# Getting all unique nodes present in the network
nodes <- unique(c(edges$V1, edges$V2))

# Write here the solution 