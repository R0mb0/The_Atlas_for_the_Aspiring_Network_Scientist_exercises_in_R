# The network in http://www.networkatlas.eu/exercises/7/1/
# data.txt is bipartite. Identify the nodes in either type and find the
# nodes, in either type, with the most neighbors.

library(here)
library(igraph)

# Reading data 
edges <- read.table("data.txt", header=FALSE)

# Solution

# Generating the graph 
g <- graph_from_data_frame(edges, directed=FALSE)

# Identifying bipartite types
# Simple approach: nodes in the first column are one type, second column are the other type.
type1 <- unique(edges$V1)
type2 <- unique(edges$V2)

#Finding degree (number of neighbors)
deg <- degree(g)

# Finding nodes with maximum degree
max_deg <- max(deg)
most_connected_nodes <- names(deg)[deg == max_deg]

# Printing the results
cat("Type 1 nodes:\n")
print(type1)
cat("\nType 2 nodes:\n")
print(type2)
cat("\nNode(s) with most neighbors:\n")
print(most_connected_nodes)
cat("Number of neighbors:", max_deg, "\n")

# Seeing which type the most connected node(s) belong to
for (node in most_connected_nodes) {
  if (node %in% type1) {
    cat(node, "is Type 1\n")
  } else if (node %in% type2) {
    cat(node, "is Type 2\n")
  }
}