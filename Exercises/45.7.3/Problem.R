# Implement a simple graph variational autoencoder. Learn the
# embeddings with the transformer you just implemented on the
# network from the previous exercise. Then calculate each node
# embedding’s mean and standard deviation. Then generate ten random
# embeddings with the same average and standard deviations.

library(here)

# Loading the network data
network_data <- read.table(here("network.txt"), header = FALSE)
# Loading the features data
features <- as.matrix(read.table(here("features.txt"), header = FALSE)
                      
# Getting the source and destination nodes
src <- network_data[, 1] + 1
dst <- network_data[, 2] + 1
num_nodes <- max(c(src, dst))

# Write here the solution 