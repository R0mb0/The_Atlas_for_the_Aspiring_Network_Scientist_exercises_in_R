# Mr. A considers Ms. B a friend, but she doesn’t like him back. She
# has a reciprocal friendship with both C and D, but only C con-
# siders D a friend. D has also sent friend requests to E, F, G, and
# H but, so far, only G replied. G also has a reciprocal relationship
# with A. Draw the corresponding directed graph.

library(here)
library(igraph)

# Solution

# Creating edges
edges <- c(
  "A", "B",
  "A", "G",
  "B", "C",
  "B", "D",
  "C", "B",
  "C", "D",
  "D", "B",
  "D", "E",
  "D", "F",
  "D", "G",
  "D", "H",
  "G", "D",
  "G", "A"
)

# Creating the directed graph
g <- make_graph(edges = edges, directed = TRUE)

# Drawing the graph's plot
plot(
  g,
  vertex.size = 35,
  vertex.color = "red",
  vertex.label.cex = 1.2,
  edge.arrow.size = 0.7,
  main = "Friendship Directed Graph"
)