# Implement a simple attention mechanism by replacing the
# ˆD−1/2(I + A) ˆD−1/2 term from the function you developed in the
# exercises of the previous chapter. The new α term comes from the
# edge weights in the third column of the network at http://www.
# networkatlas.eu/exercises/45/1/network.txt. The features are
# at http://www.networkatlas.eu/exercises/45/1/features.txt.
# Then run it on that network. (For the purposes of this and the
# following exercises, you can use a completely random W)

library(here)

# Reading the network data
network_data <- read.table(here("network.txt"), header = FALSE)
# Reading the features data
features <- as.matrix(read.table(here("features.txt"), header = FALSE))

# Write here the solution 

# Extracting edge information
src <- network_data[, 1] + 1
dst <- network_data[, 2] + 1
alpha <- network_data[, 3]

# Determining the number of nodes
num_nodes <- max(c(src, dst))

# Initializing the adjacency matrix with zeros
A <- matrix(0, nrow = num_nodes, ncol = num_nodes)

# Filling the adjacency matrix with attention weights
for (i in seq_along(src)) {
  A[src[i], dst[i]] <- alpha[i]
  A[dst[i], src[i]] <- alpha[i]
}

# Building the attention matrix (α) as the weighted adjacency
I <- diag(num_nodes)
# Summing identity and attention adjacency
A_hat <- I + A

# Calculating the degree matrix from new adjacency
D_hat <- diag(rowSums(A_hat))

# Calculating the normalization factor
D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))

# Forming the normalized attention matrix
attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt

# Generating a random weight matrix W
set.seed(42)
W <- matrix(runif(ncol(features) * 4), ncol = 4)

# Applying the attention mechanism to features
output <- attention_mat %*% features %*% W

# Printing the output
print(output)