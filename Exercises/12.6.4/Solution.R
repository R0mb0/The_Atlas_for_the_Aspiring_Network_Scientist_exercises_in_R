# What is the size in number of nodes of the largest maximal clique
# of the network used in the previous question? Which nodes are
# part of it?

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Solution

# Building igraph object with explicit node names
g <- graph_from_data_frame(edges, directed=FALSE, vertices=data.frame(name=nodes))

# Finding all maximal cliques
cliques <- maximal.cliques(g)

# Finding the largest clique(s)
max_size <- max(sapply(cliques, length))
largest_cliques <- cliques[sapply(cliques, length) == max_size]

# Printing the results
cat("Size of the largest maximal clique:", max_size, "\n")
cat("Nodes in the largest maximal clique(s):\n")
for (i in seq_along(largest_cliques)) {
  clique_nodes <- V(g)$name[as.integer(largest_cliques[[i]])]
  cat("Clique", i, ":", sort(clique_nodes), "\n")
}