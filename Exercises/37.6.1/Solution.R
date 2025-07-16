# Use the edge betweenness algorithm to find hierarchical communities
# in the network at http://www.networkatlas.eu/exercises/
# 37/1/data.txt. Since the algorithm has high time complexity,
# perform only the first 10 splits. What is the split with the highest
# modularity?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Finding hierarchical communities using edge betweenness
com_eb <- cluster_edge_betweenness(g, weights=E(g)$weight, directed=FALSE)

# Extracting the modularity after each split (for the first 10 splits)
mod_vals <- modularity(com_eb)[1:10]

# Finding the split with the highest modularity in the first 10 splits
max_modularity <- max(mod_vals)
best_split <- which.max(mod_vals)

# Printing the results
cat("Evaluating modularity for the first 10 splits using edge betweenness\n")
cat(sprintf("The split with the highest modularity is split %d with modularity %.4f\n", best_split, max_modularity))