# Draw the previous graph as undirected and weighted, with the
# weight being 2 if the connection is reciprocal, 1 otherwise.

library(here)
library(igraph)

# Solution 

# Defining the edges
edges <- c(
  "A", "B",
  "A", "G",
  "B", "C",
  "B", "D",
  "C", "D",
  "D", "E",
  "D", "F",
  "D", "G",
  "D", "H"
)

# Defining the weights
weights <- c(
  1,  # A-B
  2,  # A-G
  2,  # B-C
  2,  # B-D
  1,  # C-D
  1,  # D-E
  1,  # D-F
  2,  # D-G
  1   # D-H
)

# Creating the undirected graph with weights
g <- graph(edges=edges, directed=FALSE)
E(g)$weight <- weights

# Drawing the graph's plot
plot(
  g,
  vertex.size = 35,
  vertex.color = "red",
  vertex.label.cex = 1.2,
  edge.width = E(g)$weight*1.5,
  edge.label = E(g)$weight,
  edge.label.cex = 1.2,
  main = "Friendship Network (undirected, weighted)"
)