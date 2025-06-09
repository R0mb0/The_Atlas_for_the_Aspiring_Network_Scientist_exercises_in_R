# Calculate the structural equivalence of all pairs of nodes from the
# network used in the previous question. Which two nodes are the
# most similar? (Note: there could be ties)
# Calculate the structural equivalence of all pairs of nodes from the
# network used in the previous question. Which two nodes are the
# most similar? (Note: there could be ties)

library(here)
library(igraph)

# Reading data and build the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Computing Jaccard similarity for all pairs (excluding self-similarities)
jac <- similarity(g, mode="all", method="jaccard")
diag(jac) <- NA

# Finding the maximum similarity (excluding self-pairs)
max_sim <- max(jac, na.rm=TRUE)

# Getting all pairs with this maximum similarity
max_pairs <- which(jac == max_sim, arr.ind=TRUE)
node_names <- V(g)$name

# Printing all most similar pairs
cat("Most structurally equivalent pairs (Jaccard similarity =", max_sim, "):\n")
for (i in 1:nrow(max_pairs)) {
  cat(node_names[max_pairs[i,1]], "<->", node_names[max_pairs[i,2]], "\n")
}