# Assume that the edge weight is proportional to the probability
# of following that edge. Which 2-step node transitions became
# more likely to happen in the line graph compared to the original
# network? (For simplicity, assume that the probability of going back
# to the same node in 2-steps is zero for the line graph)

library(here)
library(igraph)

# Loading edge list
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Removing self-loops
edges <- edges[edges$from != edges$to, ]

# Removing duplicate edges (undirected: treat 1-2 and 2-1 as same)
edges_sorted <- t(apply(edges, 1, sort))
edges_unique <- unique(edges_sorted)
edges_df <- data.frame(from=edges_unique[,1], to=edges_unique[,2])

# Write here the solution