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

# Solution 

# Initializing the attention head outputs list
head_outputs <- list()

# Repeating the attention operation for each head
for (col in 3:5) {
  A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
  alpha <- network_data[, col]
  for (i in seq_along(src)) {
    A[src[i], dst[i]] <- alpha[i]
    A[dst[i], src[i]] <- alpha[i]
  }
  I <- diag(num_nodes)
  A_hat <- I + A
  D_hat <- diag(rowSums(A_hat))
  D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
  attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
  set.seed(42 + col)
  W <- matrix(runif(ncol(features) * 4), ncol = 4)
  head_output <- attention_mat %*% features %*% W
  head_outputs[[length(head_outputs) + 1]] <- head_output
}

# Averaging all the attention heads to get the embeddings
embeddings <- Reduce("+", head_outputs) / length(head_outputs)

# Calculating the mean and standard deviation for each dimension
embedding_means <- apply(embeddings, 2, mean)
embedding_sds <- apply(embeddings, 2, sd)

# Generating ten random embeddings with the same mean and sd
set.seed(123)
random_embeddings <- matrix(
  rnorm(10 * length(embedding_means), mean = rep(embedding_means, each = 10), sd = rep(embedding_sds, each = 10)),
  nrow = 10, byrow = FALSE
)

# Printing the random embeddings
print(random_embeddings)