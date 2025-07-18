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

# Write here the solution