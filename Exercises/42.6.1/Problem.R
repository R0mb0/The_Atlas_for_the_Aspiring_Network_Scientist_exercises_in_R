# Build a 2D node embedding for the network at http://www.
# networkatlas.eu/exercises/42/1/data.txt. You should build
# it by taking the first two singular values of the D −1/2 AD −1/2
# matrix.

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Write here the solution