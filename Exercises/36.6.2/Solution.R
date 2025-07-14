# Find the communities of the network at http://www.networkatlas.
# eu/exercises/36/2/data.txt using label propagation and calcu-
# late the modularity. Then manually create a new partition by
# moving nodes 25, 26, 27, 31 into their own partition. Recalculate
# modularity for this new partition. Did this move increase modular-
# ity?

library(here)
library(igraph)

# Loading the edge list and create the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution

# Running label propagation
com <- cluster_label_prop(g)
mod_orig <- modularity(com)

cat(sprintf("Modularity of label propagation partition: %.4f\n", mod_orig))

# Getting the membership vector
membership <- membership(com)

# 4. Moving nodes 25, 26, 27, 31 into their own community
# Finding the next available community number (max + 1)
new_comm <- max(membership) + 1
membership[c("25", "26", "27", "31")] <- new_comm

# Calculating modularity for the new partition
mod_new <- modularity(g, membership)

cat(sprintf("Modularity after moving nodes 25, 26, 27, 31: %.4f\n", mod_new))

# 6. Compare the modularities
if (mod_new > mod_orig) {
  cat("The move increased the modularity.\n")
} else if (mod_new < mod_orig) {
  cat("The move decreased the modularity.\n")
} else {
  cat("The modularity stayed the same.\n")
}