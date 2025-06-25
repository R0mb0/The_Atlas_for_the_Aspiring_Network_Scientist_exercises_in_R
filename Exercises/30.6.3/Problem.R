# What is the relative popularity of attribute values “right-leaning”
# and “left-leaning”? Based on what you discovered in the first
# exercise, would you say that there is a majority illusion in the
# network?

library(here)
library(igraph)

# Loading edge list
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Loading node attributes
nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
colnames(nodes_df) <- c("id", "leaning")

# Write here the solution 