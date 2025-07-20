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

# Solution 

# Getting the number of nodes
num_nodes <- max(c(src, dst))

# Initializing the attention head outputs list
head_outputs <- list()

# Looping through the third, fourth, and fifth columns for attention weights
for (col in 3:5) {
  # Initializing the adjacency matrix with zeros
  A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
  
  # Filling the adjacency matrix with the attention weights for this head
  alpha <- network_data[, col]
  for (i in seq_along(src)) {
    A[src[i], dst[i]] <- alpha[i]
    A[dst[i], src[i]] <- alpha[i]
  }
  
  # Building the attention matrix for this head
  I <- diag(num_nodes)
  A_hat <- I + A
  
  # Calculating the degree matrix
  D_hat <- diag(rowSums(A_hat))
  
  # Calculating the normalization factor
  D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
  
  # Creating the normalized attention matrix
  attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
  
  # Generating a random weight matrix W for each head
  set.seed(42 + col)
  W <- matrix(runif(ncol(features) * 4), ncol = 4)
  
  # Applying the attention operation for this head
  head_output <- attention_mat %*% features %*% W
  
  # Storing the output for this head
  head_outputs[[length(head_outputs) + 1]] <- head_output
}

# Averaging the outputs of all heads
final_output <- Reduce("+", head_outputs) / length(head_outputs)

# Printing the result
print(final_output)