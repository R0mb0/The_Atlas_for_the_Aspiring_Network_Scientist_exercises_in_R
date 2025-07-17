#Implement the ego network algorithm: for each node, extract its
#ego minus ego network and apply the label propagation algorithm,
#then merge communities with a node Jaccard coefficient higher
#than 0.1 (ignoring singletons: communities of a single node). Does
#this method return a better NMI than k-clique percolation for
#k = 3?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Removing weights for community detection
g_unweighted <- delete_edge_attr(g, "weight")

# Loading the ground truth communities from comms.txt
comms_lines <- readLines(here("comms.txt"))
gt_communities <- lapply(comms_lines, function(line) strsplit(line, " ")[[1]])
gt_communities <- lapply(gt_communities, as.character)

# Sourcing the OverlappingNMI.R script
source(here("OverlappingNMI.R"))

# Write here the solution 