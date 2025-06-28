# Calculate the degree assortativity of the network from the previ-
# ous question using the first (edge-centric Pearson correlation) and
# the second (node-centric power fit) strategies explained in Section
# 31.1.

library(here)
library(igraph)

# Load edge list from local file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Build graph
g <- graph_from_data_frame(edges, directed=FALSE)

deg <- degree(g)
V(g)$deg <- deg

# Write here the solution
