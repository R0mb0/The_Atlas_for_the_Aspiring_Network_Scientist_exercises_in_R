# Assume that http://www.networkatlas.eu/exercises/36/4/
# nodes.txt contains the “true” community partition of the nodes
# from the network at http://www.networkatlas.eu/exercises/
# 36/1/data.txt. Determine which algorithm between the asynchronous
# and the semi-synchronous label propagation achieves
# higher Normalized Mutual Information with such gold standard.

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Loading the gold standard communities from nodes.txt
true_membership_df <- read.table(here("nodes.txt"))
colnames(true_membership_df) <- c("node", "community")
true_membership <- setNames(true_membership_df$community, as.character(true_membership_df$node))

# Write here the solution 