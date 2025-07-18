# Consider the bi-adjacency matrix as a data table and perform
# bi-clustering on it, using any bi-clustering algorithm provided in
# the scikit-learn library. Do you get a higher NMI than in the
# previous two cases?

#__The data for this exercise is bad. How can you understand this? ________

library(here)
library(igraph)
library(biclust)

# Loading the edge list
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Solution 

# Inferring bipartite sets using the first 60 rows
N <- 60
set1 <- unique(edges$from[1:N])
set2 <- unique(edges$to[1:N])
set1 <- setdiff(set1, set2)
set2 <- setdiff(set2, set1)

# Building the bi-adjacency matrix
adj_mat <- matrix(0, nrow=length(set1), ncol=length(set2))
rownames(adj_mat) <- set1
colnames(adj_mat) <- set2
for(i in seq_len(nrow(edges))) {
  f <- edges$from[i]
  t <- edges$to[i]
  if(f %in% set1 && t %in% set2) {
    adj_mat[f, t] <- 1
  }
  if(f %in% set2 && t %in% set1) {
    adj_mat[t, f] <- 1
  }
}

# Loading the ground truth communities
gt <- read.table(here("nodes.txt"), header=TRUE)
gt_comm <- as.character(gt$truecomm)
names(gt_comm) <- as.character(gt$node)

# Performing biclustering on the bi-adjacency matrix
bic_res <- biclust(adj_mat, method=BCPlaid())

# Assigning bicluster labels to rows (set1 nodes)
row_bicluster <- rep(NA, nrow(adj_mat))
names(row_bicluster) <- rownames(adj_mat)
for(i in seq_along(row_bicluster)) {
  found <- FALSE
  for(b in 1:bic_res@Number) {
    val <- bic_res@RowxNumber[i, b]
    if(!is.na(val) && val) {
      row_bicluster[i] <- b
      found <- TRUE
      break
    }
  }
}

# Filtering only nodes in ground truth and bicluster result (set1 side)
common <- intersect(names(row_bicluster), names(gt_comm))
row_bicluster_clean <- row_bicluster[common]
gt_comm_clean <- gt_comm[common]
valid_idx <- !(is.na(row_bicluster_clean) | is.na(gt_comm_clean))
row_bicluster_clean <- row_bicluster_clean[valid_idx]
gt_comm_clean <- gt_comm_clean[valid_idx]
order_idx <- order(names(row_bicluster_clean))
row_bicluster_clean <- row_bicluster_clean[order_idx]
gt_comm_clean <- gt_comm_clean[order_idx]

# Sourcing the NMI function
source(here("OverlappingNMI.R"))

partition_to_list <- function(membership) {
  split(names(membership), membership)
}

# Calculating NMI for biclustering
if(length(row_bicluster_clean) > 0 && length(gt_comm_clean) > 0 &&
   length(unique(row_bicluster_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
  nmi_biclust <- NMI(partition_to_list(gt_comm_clean), partition_to_list(row_bicluster_clean))
  cat(sprintf("NMI for biclustering on the bi-adjacency matrix: %.4f\n", nmi_biclust))
} else {
  cat("Cannot compute NMI for biclustering: check partitions\n")
}