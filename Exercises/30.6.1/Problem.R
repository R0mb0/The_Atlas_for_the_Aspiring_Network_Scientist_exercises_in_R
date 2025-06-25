# Load the network at http://www.networkatlas.eu/exercises/
# 30/1/data.txt and its corresponding node attributes at http:
# //www.networkatlas.eu/exercises/30/1/nodes.txt. Iterate over
# all ego networks for all nodes in the network, removing the ego
# node. For each ego network, calculate the share of right-leaning
# nodes. Then, calculate the average of such shares per node.

library(here)
library(igraph)

# Loading edge list 
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Loading node attributes 
nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
colnames(nodes_df) <- c("id", "leaning")

# Write here the solution 