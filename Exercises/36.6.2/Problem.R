# Find the communities of the network at http://www.networkatlas.
# eu/exercises/36/2/data.txt using label propagation and calcu-
# late the modularity. Then manually create a new partition by
# moving nodes 25, 26, 27, 31 into their own partition. Recalculate
# modularity for this new partition. Did this move increase modular-
# ity?

library(here)
library(igraph)

# Loading the edge list and create the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution