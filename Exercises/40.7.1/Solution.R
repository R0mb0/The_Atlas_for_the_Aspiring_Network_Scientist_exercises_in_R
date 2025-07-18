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

# Solution 

# Flattening the multilayer network without weights
flat_edges_unweighted <- unique(data.frame(
  from = pmin(edges$from, edges$to),
  to = pmax(edges$from, edges$to)
))
g_unweighted <- graph_from_data_frame(flat_edges_unweighted, directed=FALSE)

# Flattening the multilayer network with edge weights (counting layers)
edge_pairs <- data.frame(
  from = pmin(edges$from, edges$to),
  to = pmax(edges$from, edges$to)
)
edge_weights <- aggregate(layer ~ from + to, data = cbind(edge_pairs, layer=edges$layer), FUN=length)
g_weighted <- graph_from_data_frame(edge_weights[,c("from", "to")], directed=FALSE)
E(g_weighted)$weight <- edge_weights$layer

# Running label propagation on unweighted flattened graph
for(i in 1:n_runs) {
  lp_unweighted <- cluster_label_prop(g_unweighted)
  memb_unweighted <- membership(lp_unweighted)
  common <- intersect(names(memb_unweighted), names(gt_comm))
  memb_unweighted_clean <- memb_unweighted[common]
  gt_comm_clean <- gt_comm[common]
  valid_idx <- !(is.na(memb_unweighted_clean) | is.na(gt_comm_clean))
  memb_unweighted_clean <- memb_unweighted_clean[valid_idx]
  gt_comm_clean <- gt_comm_clean[valid_idx]
  order_idx <- order(names(memb_unweighted_clean))
  memb_unweighted_clean <- memb_unweighted_clean[order_idx]
  gt_comm_clean <- gt_comm_clean[order_idx]
  if(length(memb_unweighted_clean) > 0 && length(gt_comm_clean) > 0 &&
     length(unique(memb_unweighted_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
    nmi_unweighted[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_unweighted_clean))
  } else {
    nmi_unweighted[i] <- NA
  }
}

# Running label propagation on weighted flattened graph
for(i in 1:n_runs) {
  lp_weighted <- cluster_label_prop(g_weighted, weights=E(g_weighted)$weight)
  memb_weighted <- membership(lp_weighted)
  common <- intersect(names(memb_weighted), names(gt_comm))
  memb_weighted_clean <- memb_weighted[common]
  gt_comm_clean <- gt_comm[common]
  valid_idx <- !(is.na(memb_weighted_clean) | is.na(gt_comm_clean))
  memb_weighted_clean <- memb_weighted_clean[valid_idx]
  gt_comm_clean <- gt_comm_clean[valid_idx]
  order_idx <- order(names(memb_weighted_clean))
  memb_weighted_clean <- memb_weighted_clean[order_idx]
  gt_comm_clean <- gt_comm_clean[order_idx]
  if(length(memb_weighted_clean) > 0 && length(gt_comm_clean) > 0 &&
     length(unique(memb_weighted_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
    nmi_weighted[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_weighted_clean))
  } else {
    nmi_weighted[i] <- NA
  }
}

# Calculating the average NMI for each flattening scheme
avg_nmi_unweighted <- mean(nmi_unweighted, na.rm=TRUE)
avg_nmi_weighted <- mean(nmi_weighted, na.rm=TRUE)

cat(sprintf("Average NMI for unweighted flattening: %.4f\n", avg_nmi_unweighted))
cat(sprintf("Average NMI for weighted flattening: %.4f\n", avg_nmi_weighted))