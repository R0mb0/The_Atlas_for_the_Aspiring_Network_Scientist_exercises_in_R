# Run the MPGNN you designed in the previous exercise. Make
# a scatter plot of the node embeddings using the two dimensions
# as x and y coordinates at the first, fifth, tenth, and twentieth layer.
# What do you observe?

library(here)
library(Matrix)
library(ggplot2)

# Loading the node features
features <- as.matrix(read.table(here("features.txt")))

# Loading the edge list and building the graph
edges <- as.matrix(read.table(here("network.txt")))
num_nodes <- nrow(features)

# Write here the solution 