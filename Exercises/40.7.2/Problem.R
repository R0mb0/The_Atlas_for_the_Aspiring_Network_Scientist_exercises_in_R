# separately. Build the |V| × |C| table, perform kMeans (setting k = 4)
# on it to merge the communities. Does this return a higher NMI
# when compared with the ground truth?

library(here)
library(igraph)

# Loading the multilayer edge list
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "layer")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Loading the ground truth partition
nodes <- read.table(here("nodes.txt"))
gt_comm <- as.character(nodes$V2)
names(gt_comm) <- as.character(nodes$V1)

partition_to_list <- function(membership) {
  split(names(membership), membership)
}

# Sourcing the NMI function
source(here("OverlappingNMI.R"))

# Write here the solution