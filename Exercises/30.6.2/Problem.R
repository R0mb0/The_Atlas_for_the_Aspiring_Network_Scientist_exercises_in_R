# What is the assortativity of the leaning attribute?

library(here)
library(igraph)

# Loading edge list 
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Loading node attributes 
nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
colnames(nodes_df) <- c("id", "leaning")

# Write here the solution 