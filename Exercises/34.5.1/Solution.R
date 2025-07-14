# Calculate the distribution of the k2,0 and k2,1 degrees of the net-
# work at http://www.networkatlas.eu/exercises/34/1/data.txt.
# Assume every clique of the network to be a simplex.

library(here)

# Reading the edge list from a local file
edges <- read.table("data.txt")

# Getting all unique nodes present in the network
nodes <- unique(c(edges$V1, edges$V2))

#Solution

# Building adjacency list for each node
adj <- lapply(nodes, function(n) unique(c(edges$V2[edges$V1==n], edges$V1[edges$V2==n])))
names(adj) <- nodes

# Calculating k2,0 (degree) for each node
k2_0 <- sapply(nodes, function(n) length(adj[[as.character(n)]]))

# Calculating k2,1 (number of triangles for each edge)
k2_1 <- apply(edges, 1, function(e) {
  a <- adj[[as.character(e[1])]]
  b <- adj[[as.character(e[2])]]
  length(intersect(a, b))
})

# Printing the distribution of node degrees
cat("k2,0 (node degree) distribution:\n")
print(table(k2_0))

# Printing the distribution of edge degrees (number of triangles per edge)
cat("k2,1 (edge degree) distribution:\n")
print(table(k2_1))