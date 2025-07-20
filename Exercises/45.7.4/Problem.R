# Implement a basic continuous message-passing. Each node averages
# its own embedding with the average of its neighbors times a
# factor k. Try k = 0.5, k = 1, and k = 1.33 with the network from the
# previous exercises.

library(here)

# Loading the network data
network_data <- read.table(here("network.txt"), header = FALSE)
# Loading the features data
features <- as.matrix(read.table(here("features.txt"), header = FALSE)

# Getting the source and destination nodes
src <- network_data[, 1] + 1
dst <- network_data[, 2] + 1
num_nodes <- max(c(src, dst))

# Initializing the adjacency matrix with zeros
A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
for (i in seq_along(src)) {
  A[src[i], dst[i]] <- 1
  A[dst[i], src[i]] <- 1
}

# Write here the solution 