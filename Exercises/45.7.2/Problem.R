# Implement a simple transformer by repeating the attention operation
# from the previous exercise with the alternative weights in
# the third, fourth, and fifth column of http://www.networkatlas.
# eu/exercises/45/1/network.txt. Combine them with a final layer
# averaging all the attention heads.

library(here)

# Loading the network data
network_data <- read.table(here("network.txt"), header = FALSE)
# Loading the features data
features <- as.matrix(read.table(here("features.txt"), header = FALSE))

# Getting the source and destination nodes
src <- network_data[, 1] + 1
dst <- network_data[, 2] + 1

# Write here the solution 