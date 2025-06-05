# What is the size in number of nodes of the largest independent
# set of the network used in the previous question? (Approximate
# answers are acceptable) Which nodes are part of it?

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Solution

# Greedy algorithm: iteratively add lowest-degree vertex to the independent set
independent_set <- c()
remaining <- V(g)

while(length(remaining) > 0) {
  degs <- degree(g, v=remaining)
  v <- remaining[which.min(degs)]
  independent_set <- c(independent_set, v)
  neighbors <- neighbors(g, v)
  to_remove <- union(v, neighbors)
  remaining <- setdiff(remaining, to_remove)
}

cat("Approximate size of large independent set found:", length(independent_set), "\n")
cat("Nodes in the independent set:\n")
print(V(g)$name[independent_set])