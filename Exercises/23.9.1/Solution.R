# What are the ten most likely edges to appear in the network at
# http://www.networkatlas.eu/exercises/23/1/data.txt accord-
# ing to the preferential attachment index?

library(here)
library(igraph)

# Reading the edge list and building the graph 
edges <- read.table("data.txt", header=FALSE)
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Solution 

# Getting all node pairs NOT currently connected (potential edges)
all_nodes <- V(g)$name
missing_edges <- t(combn(all_nodes, 2))
missing_edges <- missing_edges[!apply(missing_edges, 1, function(pair) {
  are.connected(g, pair[1], pair[2])
}), , drop=FALSE]

# Computing preferential attachment for each missing edge
deg <- degree(g)
pa_scores <- apply(missing_edges, 1, function(pair) {
  deg[pair[1]] * deg[pair[2]]
})

# Finding the top 10 by score
top_idx <- order(pa_scores, decreasing=TRUE)[1:10]
top_edges <- missing_edges[top_idx, , drop=FALSE]
top_scores <- pa_scores[top_idx]

# Printing the results
cat("Top 10 most likely edges (by preferential attachment):\n")
for(i in 1:nrow(top_edges)) {
  cat(sprintf("%s -- %s (score = %d)\n", top_edges[i,1], top_edges[i,2], top_scores[i]))
}