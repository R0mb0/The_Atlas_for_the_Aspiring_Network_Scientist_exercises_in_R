# Plot the CCDF edge weight distribution of the network at http:
# //www.networkatlas.eu/exercises/27/1/data.txt. Calculate its
# average and standard deviation. NOTE: this is a directed graph!

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Extract edge weights
w <- E(g)$weight

# Write ehre the solution