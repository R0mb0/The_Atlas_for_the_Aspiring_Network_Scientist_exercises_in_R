# What’s the diameter of the graph in Figure 13.12(a)? What’s its
# average path length?

library(here)
library(igraph)

# Building the undirected graph
edges <- matrix(c(
  1,2,
  1,3,
  2,3,
  2,4,
  2,5,
  3,5,
  3,4,
  4,5,
  5,6,
  5,7,
  6,7,
  6,8,
  6,9,
  7,8,
  7,9,
  8,9
), byrow=TRUE, ncol=2)
g <- graph_from_edgelist(edges, directed=FALSE)

# Solution 

# Calculating the diameter (longest shortest path)
graph_diameter <- diameter(g)
cat("Diameter of the graph:", graph_diameter, "\n")

# Calculating the average shortest path length
avg_path_length <- average.path.length(g)
cat("Average path length of the graph:", avg_path_length, "\n")