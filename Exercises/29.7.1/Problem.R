# Perform a random walk sampling of the network at http://www.
# networkatlas.eu/exercises/29/1/data.txt. Sample 2,000 nodes
# (1% of the network) and all their connections (note: the sample
# will end up having more than 2,000 nodes).

library(here)
library(igraph)

# Loading the network from file
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")

# Creating the graph (assuming undirected network)
g <- graph_from_data_frame(edges, directed = FALSE)

# Write here the solution 