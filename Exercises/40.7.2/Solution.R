# Using the same network, perform label percolation on each layer
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

# Solution 

layers <- sort(unique(edges$layer))
all_nodes <- unique(c(edges$from, edges$to))
table_list <- list()
community_count <- 0
community_labels <- list()

# Performing label propagation on each layer separately
for(layer in layers) {
  # Filtering edges for the current layer
  layer_edges <- subset(edges, layer == !!layer)
  # Building the graph for the layer
  g_layer <- graph_from_data_frame(layer_edges[,c("from","to")], directed=FALSE)
  # Running label propagation
  lp_layer <- cluster_label_prop(g_layer)
  memb_layer <- membership(lp_layer)
  # Mapping communities to columns in the big table
  layer_comms <- unique(memb_layer)
  # For each community in this layer, create one column
  for(comm in layer_comms) {
    col <- rep(0, length(all_nodes))
    names(col) <- all_nodes
    col[names(memb_layer)[memb_layer == comm]] <- 1
    table_list[[length(table_list)+1]] <- col
    community_labels[[length(community_labels)+1]] <- paste("layer", layer, "comm", comm, sep="_")
    community_count <- community_count + 1
  }
}

# Building the |V| x |C| table
table_mat <- do.call(cbind, table_list)
rownames(table_mat) <- all_nodes
colnames(table_mat) <- unlist(community_labels)

# Performing kMeans clustering on the table
set.seed(42)
kmeans_res <- kmeans(table_mat, centers=4)
kmeans_membership <- kmeans_res$cluster
names(kmeans_membership) <- rownames(table_mat)

# Filtering nodes present in ground truth
common <- intersect(names(kmeans_membership), names(gt_comm))
kmeans_membership_clean <- kmeans_membership[common]
gt_comm_clean <- gt_comm[common]
valid_idx <- !(is.na(kmeans_membership_clean) | is.na(gt_comm_clean))
kmeans_membership_clean <- kmeans_membership_clean[valid_idx]
gt_comm_clean <- gt_comm_clean[valid_idx]
order_idx <- order(names(kmeans_membership_clean))
kmeans_membership_clean <- kmeans_membership_clean[order_idx]
gt_comm_clean <- gt_comm_clean[order_idx]

# Calculating NMI for kMeans clustering
nmi_kmeans <- NMI(partition_to_list(gt_comm_clean), partition_to_list(kmeans_membership_clean))
cat(sprintf("NMI for kMeans clustering on label propagation results: %.4f\n", nmi_kmeans))