# Perform label percolation community discovery on the network at
# http://www.networkatlas.eu/exercises/46/1/data.txt. Use the
# detected communities to summarize the graph via aggregation.

library(igraph)
library(here)

# Reading the edge list from the data.txt file in the script folder
edges <- read.table(here("data.txt"), header = FALSE)

# Building the graph from the edge list
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Solution 

# Performing label propagation community detection
communities <- cluster_label_prop(g)

# Getting the membership vector
membership <- membership(communities)

# Aggregating the graph by summarizing nodes within the same community
# Creating a new graph where each node is a community and edges represent links between communities
# Getting the community membership for each node
V(g)$community <- membership

# Contracting the graph based on community membership
contracted <- contract.vertices(g, membership)

# Simplifying the contracted graph by merging multiple edges between communities
agg_graph <- simplify(contracted, remove.loops = TRUE)

# Printing the community membership for each original node
print(membership)

# Printing the summary of the aggregated graph
print(agg_graph)