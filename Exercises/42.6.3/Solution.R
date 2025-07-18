# Compare the embeddings you obtained from the previous two
# exercises with the ones you get by taking the first two eigenvectors
# of D −1/2 LD −1/2 . Which one has the lowest loss according to
# 1
# 2
# ∑ ( Zu − Zv ) Auv ?

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Solution

# Getting the adjacency matrix
A <- as.matrix(get.adjacency(g))

# Getting the degree vector
deg <- rowSums(A)

# Building the D^{-1/2} matrix
D_inv_sqrt <- diag(1 / sqrt(deg))

# Building the normalized adjacency matrix
norm_adj <- D_inv_sqrt %*% A %*% D_inv_sqrt

# Performing singular value decomposition for SVD embedding
svd_result <- svd(norm_adj)
embedding_svd <- svd_result$u[, 1:2]

# Building the (I - A) matrix and getting (I - A)^T (I - A)
I <- diag(nrow(A))
I_minus_A <- I - A
mat <- t(I_minus_A) %*% I_minus_A
eig_result <- eigen(mat)
embedding_eigen <- eig_result$vectors[, 2:3]

# Building the Laplacian matrix
D <- diag(deg)
L <- D - A

# Building the normalized Laplacian
norm_lap <- D_inv_sqrt %*% L %*% D_inv_sqrt

# Getting the first two eigenvectors for Laplacian embedding
lap_eig <- eigen(norm_lap)
embedding_lap <- lap_eig$vectors[, 1:2]

# Defining the loss function from image2
compute_loss_laplacian <- function(Z, A) {
  loss <- 0
  for (u in 1:nrow(A)) {
    for (v in 1:nrow(A)) {
      if (A[u, v] != 0) {
        diff <- Z[u, ] - Z[v, ]
        loss <- loss + sum(diff^2) * A[u, v]
      }
    }
  }
  return(loss / 2)
}

# Calculating the loss for all three embeddings
loss_svd <- compute_loss_laplacian(embedding_svd, A)
loss_eigen <- compute_loss_laplacian(embedding_eigen, A)
loss_lap <- compute_loss_laplacian(embedding_lap, A)

# Printing the losses to compare
cat("Loss for SVD embedding:", loss_svd, "\n")
cat("Loss for eigenvector embedding:", loss_eigen, "\n")
cat("Loss for Laplacian embedding:", loss_lap, "\n")

if (loss_svd < loss_eigen & loss_svd < loss_lap) {
  cat("SVD embedding has the lowest loss\n")
} else if (loss_eigen < loss_svd & loss_eigen < loss_lap) {
  cat("Eigenvector embedding has the lowest loss\n")
} else {
  cat("Laplacian embedding has the lowest loss\n")
}