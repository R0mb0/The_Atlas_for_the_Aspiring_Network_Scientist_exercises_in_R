# Change the splitting criterion of the algorithm, using the inverse
# edge weight rather than edge betweenness. Since this is much
# faster, you can perform the first 20 splits. Do you get higher or
# lower modularity relative to the result from exercise 1?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution

# Computing the inverse of the edge weights
inv_weights <- 1 / edges$weight
E(g)$inv_weight <- inv_weights

# Finding hierarchical communities using the inverse edge weight as distance
# Using cluster_fast_greedy which uses edge weights as similarity, so we set the weights as inverse of distance
com_fg <- cluster_fast_greedy(g, weights=E(g)$inv_weight)

# Extracting the modularity after each split (first 20 splits)
mod_vals <- modularity(com_fg)[1:20]

# Finding the split with the highest modularity in the first 20 splits
max_modularity <- max(mod_vals)
best_split <- which.max(mod_vals)

# Printing the results
cat("Evaluating modularity for the first 20 splits using inverse edge weight (fast greedy)\n")
cat(sprintf("The split with the highest modularity is split %d with modularity %.4f\n", best_split, max_modularity))