# Using the algorithm you made for exercise 3, answer these questions:
# What is the latest step for which you have the average
# internal community edge density equal to 1? What is the modularity
# at that step? What is the highest modularity you can obtain?
# What is the average internal community edge density at that step?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution