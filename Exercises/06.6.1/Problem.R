# Calculate |V | and | E| for the graph in Figure 6.1(c).

library(here)
library(igraph)

# Defining the graph

# Let's label the nodes as 1, 2, 3, 4, 5
# Creating edges
edges <- c(1,2, 1,3, 1,4, 2,3, 3,4, 3,5)

# Creating the graph
g <- graph(edges=edges, n=5, directed=FALSE)

# Write here the solution