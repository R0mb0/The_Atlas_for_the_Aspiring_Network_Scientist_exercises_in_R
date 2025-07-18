# The network at http://www.networkatlas.eu/exercises/39/
# 1/data.txt is bipartite. Project it into unipartite and find five
# communities with the Girvan-Newman edge betweenness algorithm
# (repeat for both node types, so you find a total of ten
# communities). What is the NMI with the partition proposed at
# http://www.networkatlas.eu/exercises/39/1/nodes.txt?


#__The data for this exercise is bad. How can you understand this? ________

library(here)
library(igraph)

# Loading the edge list and building the graph
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

# Filtering edges so that only between set1 and set2 remain
edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))

# Building the bipartite graph
g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
V(g)$type <- V(g)$name %in% set1

# Projecting the bipartite graph
proj <- bipartite_projection(g)
g1 <- proj$proj1
g2 <- proj$proj2

# Loading the ground truth communities
gt <- read.table(here("nodes.txt"), header=TRUE)
gt_comm <- as.character(gt$truecomm)
names(gt_comm) <- as.character(gt$node)

get_communities <- function(cl, n_communities) {
  memb <- tryCatch(
    cut_at(cl, no=n_communities),
    error = function(e) NULL
  )
  if(is.null(memb) || !is.vector(memb) || is.null(names(memb))) {
    return(list())
  }
  split(names(memb), memb)
}

# Running Girvan-Newman clustering on the projections
cl1 <- cluster_edge_betweenness(g1)
comms1 <- get_communities(cl1, 5)

cl2 <- cluster_edge_betweenness(g2)
comms2 <- get_communities(cl2, 5)

comm_to_mem <- function(comms, all_nodes) {
  mem <- rep(NA, length(all_nodes))
  names(mem) <- all_nodes
  for (i in seq_along(comms)) {
    mem[comms[[i]]] <- i
  }
  mem
}

# Creating membership vectors for both projections
mem1 <- comm_to_mem(comms1, V(g1)$name)
mem2 <- comm_to_mem(comms2, V(g2)$name)

# Selecting nodes present in both ground truth and mem, removing NA, and sorting
common1 <- intersect(names(mem1), names(gt_comm))
mem1_clean <- mem1[common1]
gt_mem1_clean <- gt_comm[common1]
valid_idx1 <- !(is.na(mem1_clean) | is.na(gt_mem1_clean))
mem1_clean <- mem1_clean[valid_idx1]
gt_mem1_clean <- gt_mem1_clean[valid_idx1]
order1 <- order(names(mem1_clean))
mem1_clean <- mem1_clean[order1]
gt_mem1_clean <- gt_mem1_clean[order1]

common2 <- intersect(names(mem2), names(gt_comm))
mem2_clean <- mem2[common2]
gt_mem2_clean <- gt_comm[common2]
valid_idx2 <- !(is.na(mem2_clean) | is.na(gt_mem2_clean))
mem2_clean <- mem2_clean[valid_idx2]
gt_mem2_clean <- gt_mem2_clean[valid_idx2]
order2 <- order(names(mem2_clean))
mem2_clean <- mem2_clean[order2]
gt_mem2_clean <- gt_mem2_clean[order2]

# Printing lengths for debugging
cat("mem1_clean length:", length(mem1_clean), "\n")
cat("gt_mem1_clean length:", length(gt_mem1_clean), "\n")
cat("mem2_clean length:", length(mem2_clean), "\n")
cat("gt_mem2_clean length:", length(gt_mem2_clean), "\n")
cat("Any duplicated names in mem1_clean:", any(duplicated(names(mem1_clean))), "\n")
cat("Any duplicated names in gt_mem1_clean:", any(duplicated(names(gt_mem1_clean))), "\n")
cat("Unique communities in mem1_clean:", length(unique(mem1_clean)), "\n")
cat("Unique communities in gt_mem1_clean:", length(unique(gt_mem1_clean)), "\n")

# Loading the NMI function
source(here("OverlappingNMI.R"))

partition_to_list <- function(membership) {
  split(names(membership), membership)
}

# Calculating NMI for both projections if partitions are valid
if(length(mem1_clean) > 0 && length(gt_mem1_clean) > 0 &&
   length(unique(mem1_clean)) > 1 && length(unique(gt_mem1_clean)) > 1) {
  nmi1 <- NMI(partition_to_list(gt_mem1_clean), partition_to_list(mem1_clean))
  cat(sprintf("NMI for projection on node type 1: %.4f\n", nmi1))
} else {
  cat("Cannot compute NMI for projection on node type 1: check partitions\n")
}

if(length(mem2_clean) > 0 && length(gt_mem2_clean) > 0 &&
   length(unique(mem2_clean)) > 1 && length(unique(gt_mem2_clean)) > 1) {
  nmi2 <- NMI(partition_to_list(gt_mem2_clean), partition_to_list(mem2_clean))
  cat(sprintf("NMI for projection on node type 2: %.4f\n", nmi2))
} else {
  cat("Cannot compute NMI for projection on node type 2: check partitions\n")
}