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

# Solution 

# Running asynchronous label propagation 10 times and calculating NMI each time
n_runs <- 10
nmi_values <- numeric(n_runs)
for(i in 1:n_runs) {
  # Running label propagation on the bipartite graph
  lp <- cluster_label_prop(g)
  # Creating membership vector from clustering result
  memb <- membership(lp)
  # Finding nodes present in both ground truth and clustering result
  common <- intersect(names(memb), names(gt_comm))
  memb_clean <- memb[common]
  gt_comm_clean <- gt_comm[common]
  # Removing NA values and ensuring the same order
  valid_idx <- !(is.na(memb_clean) | is.na(gt_comm_clean))
  memb_clean <- memb_clean[valid_idx]
  gt_comm_clean <- gt_comm_clean[valid_idx]
  order_idx <- order(names(memb_clean))
  memb_clean <- memb_clean[order_idx]
  gt_comm_clean <- gt_comm_clean[order_idx]
  # Calculating NMI for this run
  if(length(memb_clean) > 0 && length(gt_comm_clean) > 0 &&
     length(unique(memb_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
    nmi_values[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_clean))
  } else {
    nmi_values[i] <- NA
  }
}

# Calculating the average NMI over all valid runs
avg_nmi <- mean(nmi_values, na.rm=TRUE)

cat(sprintf("Average NMI over %d runs of label propagation on the bipartite graph: %.4f\n", n_runs, avg_nmi))