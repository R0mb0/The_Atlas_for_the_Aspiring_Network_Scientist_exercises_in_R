# Implement a MPGNN as a series of matrix operations, imple-
# 
# menting H l = σ D̂ −1/2 ( I + A) D̂ −1/2 H l −1 , with σ being
# softmax. Apply it to the network at http://www.networkatlas.
# eu/exercises/44/3/network.txt, with node features at http:
# //www.networkatlas.eu/exercises/44/3/features.txt. Compare
# its running time with the MPGNN you implemented in the first ex-
# ercise, running each for 20 layers and making several runs noting
# down the average running time.

library(here)
library(Matrix)
library(microbenchmark)

# Loading the node features
features <- as.matrix(read.table(here("features.txt")))

# Loading the edge list
edges <- as.matrix(read.table(here("network.txt")))

# Solution 

# Getting the number of nodes and features
num_nodes <- nrow(features)
num_features <- ncol(features)

# Creating the adjacency matrix
adj_matrix <- matrix(0, nrow = num_nodes, ncol = num_nodes)
for (i in seq_len(nrow(edges))) {
  src <- edges[i, 1] + 1
  tgt <- edges[i, 2] + 1
  adj_matrix[src, tgt] <- 1
  adj_matrix[tgt, src] <- 1
}

# Adding the identity matrix to adjacency
adj_matrix_hat <- adj_matrix + diag(num_nodes)

# Calculating the degree matrix
degree_vec <- rowSums(adj_matrix_hat)
D_hat_inv_sqrt <- diag(1 / sqrt(degree_vec))

# Defining the softmax function
softmax <- function(x) {
  exp_x <- exp(x)
  exp_x / rowSums(exp_x)
}

# Defining one layer of the MPGNN using matrix operations
mpgnn_layer <- function(H_prev, adj_matrix_hat, D_hat_inv_sqrt) {
  aggregate_matrix <- D_hat_inv_sqrt %*% adj_matrix_hat %*% D_hat_inv_sqrt
  H_new <- aggregate_matrix %*% H_prev
  softmax(H_new)
}

# Running the MPGNN for 20 layers and recording time
H_list <- list()
H_list[[1]] <- features

times_matrix <- microbenchmark(
  {
    H <- features
    for (layer in 2:21) {
      H <- mpgnn_layer(H, adj_matrix_hat, D_hat_inv_sqrt)
      if (layer %in% c(2, 6, 11, 21)) {
        H_list[[layer]] <- H
      }
    }
  },
  times = 10
)

print(times_matrix)

# Loading the adjacency list for the first MPGNN
adj_list <- vector("list", num_nodes)
for (i in seq_len(nrow(edges))) {
  src <- edges[i, 1] + 1
  tgt <- edges[i, 2] + 1
  adj_list[[src]] <- c(adj_list[[src]], tgt)
  adj_list[[tgt]] <- c(adj_list[[tgt]], src)
}

# Defining the aggregate function (element-wise mean)
aggregate <- function(neighbors, embeddings) {
  if (length(neighbors) == 0) {
    return(rep(0, ncol(embeddings)))
  }
  colMeans(embeddings[neighbors, , drop = FALSE])
}

# Defining the update function (sum and softmax)
update <- function(node_emb, agg_emb) {
  sum_vec <- node_emb + agg_emb
  exp_vec <- exp(sum_vec)
  exp_vec / sum(exp_vec)
}

# Defining the message-passing function (single layer)
message_passing <- function(features, adj_list) {
  new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
  for (i in seq_len(nrow(features))) {
    agg <- aggregate(adj_list[[i]], features)
    new_embeddings[i, ] <- update(features[i, ], agg)
  }
  new_embeddings
}

# Running the first MPGNN for 20 layers and recording time
times_loop <- microbenchmark(
  {
    emb <- features
    for (layer in 1:20) {
      emb <- message_passing(emb, adj_list)
    }
  },
  times = 10
)

print(times_loop)

# Printing average running times for both methods
cat("Matrix operations average time (ms):", mean(times_matrix$time) / 1e6, "\n")
cat("Loop/message-passing average time (ms):", mean(times_loop$time) / 1e6, "\n")