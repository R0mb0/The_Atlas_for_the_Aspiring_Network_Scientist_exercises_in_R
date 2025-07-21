# Import edge data from http://www.networkatlas.eu/exercises/
# 50/2/edges.txt and use the attribute for the edge’s width.

library(here)
library(igraph)

# Loading the edge list and edge attribute
edges_data <- read.table(here("edges.txt"), header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Splitting the first column to extract node names
nodes <- strsplit(edges_data$V1, " \\(interacts with\\) ")
edge_list <- t(sapply(nodes, function(x) c(x[1], x[2])))

# Building the graph
g <- graph_from_edgelist(edge_list, directed = FALSE)

# Assigning edge width from the attribute
E(g)$width <- edges_data$V2

# Write here the solution 