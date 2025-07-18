# Take the multilayer network at http://www.networkatlas.eu/
# exercises/40/1/data.txt. The third column tells you in which
# layer the edge appears. Flatten it twice: first with unweighted
# edges and then with the count of the number of layers in which
# the edge appears. Which flattening scheme returns a higher NMI
# with the partition in http://www.networkatlas.eu/exercises/40/
# 1/nodes.txt? Use the asynchronous label percolation algorithm
# (remember to pass the edge weight argument in the second case).

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

n_runs <- 10
nmi_unweighted <- numeric(n_runs)
nmi_weighted <- numeric(n_runs)

# Write here the solution 