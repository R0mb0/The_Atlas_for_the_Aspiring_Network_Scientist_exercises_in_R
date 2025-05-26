# Find all cycles in the network in http://www.networkatlas.eu/
# exercises/10/2/data.txt. Note: the network is directed.

library(here)
library(RBGL)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
nodes <- unique(c(edges$V1, edges$V2))

# Write here the solution