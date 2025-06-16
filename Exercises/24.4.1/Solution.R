# You’re given the undirected signed network at http://www.
# networkatlas.eu/exercises/24/1/data.txt. Count the number of
# triangles of the four possible types.

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to", "sign")
edges[] <- lapply(edges, as.character)
edges$sign <- as.numeric(edges$sign)

# Building an undirected network, keeping edge signs as attribute
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Enumerating all triangles
triangles_raw <- combn(V(g)$name, 3)
triangle_types <- c('+++', '++-', '+--', '---')
triangle_counts <- setNames(rep(0, 4), triangle_types)

# For each triangle, checking the signs
for(i in 1:ncol(triangles_raw)) {
  v <- triangles_raw[,i]
  # Get all three edge signs using .from() and .to()
  s1 <- E(g)[.from(v[1]) & .to(v[2])]$sign
  s2 <- E(g)[.from(v[1]) & .to(v[3])]$sign
  s3 <- E(g)[.from(v[2]) & .to(v[3])]$sign
  # Only count if all three edges exist
  if(length(s1) == 1 && length(s2) == 1 && length(s3) == 1) {
    signs <- c(s1, s2, s3)
    npos <- sum(signs == 1)
    nneg <- sum(signs == -1)
    if(npos == 3) triangle_counts['+++'] <- triangle_counts['+++'] + 1
    if(npos == 2 && nneg == 1) triangle_counts['++-'] <- triangle_counts['++-'] + 1
    if(npos == 1 && nneg == 2) triangle_counts['+--'] <- triangle_counts['+--'] + 1
    if(nneg == 3) triangle_counts['---'] <- triangle_counts['---'] + 1
  }
}

# Printing the results 
cat("Triangle type counts:\n")
for(type in triangle_types) {
  cat(type, ":", triangle_counts[type], "\n")
}