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

# Solution 

# Getting the embeddings from the previous transformer step
# Repeating the attention operation for each head
head_outputs <- list()
for (col in 3:5) {
  A_att <- matrix(0, nrow = num_nodes, ncol = num_nodes)
  alpha <- network_data[, col]
  for (i in seq_along(src)) {
    A_att[src[i], dst[i]] <- alpha[i]
    A_att[dst[i], src[i]] <- alpha[i]
  }
  I <- diag(num_nodes)
  A_hat <- I + A_att
  D_hat <- diag(rowSums(A_hat))
  D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
  attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
  set.seed(42 + col)
  W <- matrix(runif(ncol(features) * 4), ncol = 4)
  head_output <- attention_mat %*% features %*% W
  head_outputs[[length(head_outputs) + 1]] <- head_output
}
embeddings <- Reduce("+", head_outputs) / length(head_outputs)

# Defining the message passing function
message_passing <- function(embeddings, adjacency, k) {
  new_embeddings <- embeddings
  for (node in 1:nrow(embeddings)) {
    neighbors <- which(adjacency[node, ] > 0)
    if (length(neighbors) > 0) {
      neighbor_avg <- colMeans(embeddings[neighbors, , drop = FALSE])
      new_embeddings[node, ] <- (embeddings[node, ] + k * neighbor_avg) / (1 + k)
    }
    # if no neighbors, just keep its own embedding
  }
  return(new_embeddings)
}

# Trying k = 0.5, k = 1, and k = 1.33
result_k_0.5 <- message_passing(embeddings, A, k = 0.5)
result_k_1   <- message_passing(embeddings, A, k = 1)
result_k_1.33 <- message_passing(embeddings, A, k = 1.33)

# Printing the results for each k
print(result_k_0.5)
print(result_k_1)
print(result_k_1.33)