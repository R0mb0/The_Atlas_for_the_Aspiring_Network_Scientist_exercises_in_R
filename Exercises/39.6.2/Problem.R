# Now perform asynchronous label propagation directly on the
# bipartite structure. Calculate the NMI with the ground truth. Since
# asynchronous label propagation is randomized, take the average of
# ten runs. Do you get a higher NMI?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Inferring bipartite sets using the first 60 rows
N <- 60
set1 <- unique(edges$from[1:N])
set2 <- unique(edges$to[1:N])
set1 <- setdiff(set1, set2)
set2 <- setdiff(set2, set1)

# Filtering edges so that only between set1 and set2 remain
edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))

# Building the bipartite graph
g <- graph_from_data_frame(edges_bipartite, directed=FALSE)

# Loading the ground truth communities
gt <- read.table(here("nodes.txt"), header=TRUE)
gt_comm <- as.character(gt$truecomm)
names(gt_comm) <- as.character(gt$node)

partition_to_list <- function(membership) {
  split(names(membership), membership)
}

# Sourcing the NMI function
source(here("OverlappingNMI.R"))

# Write here the solution 