# Compare the embeddings you obtained from the previous exercise
# with the ones you get by taking the second and third eigenvectors
# of ( I − A) T ( I − A). Which one has the lowest loss according to
# 
# 2
# ∑ Zu − ∑ Zv Auv ?

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

# Performing singular value decomposition
svd_result <- svd(norm_adj)

# Taking the first two singular vectors for embedding
embedding_svd <- svd_result$u[, 1:2]

# Building the (I - A) matrix
I <- diag(nrow(A))
I_minus_A <- I - A

# Computing (I - A)^T (I - A)
mat <- t(I_minus_A) %*% I_minus_A

# Computing eigen decomposition
eig_result <- eigen(mat)

# Taking the second and third eigenvectors for embedding
embedding_eigen <- eig_result$vectors[, 2:3]

# Defining a function to compute the loss from the formula in image1
compute_loss <- function(Z, A) {
  loss <- 0
  for (u in 1:nrow(A)) {
    Zu <- Z[u, ]
    Av <- A[u, ]
    Zv_Auv <- colSums(t(Z) * Av)
    diff <- Zu - Zv_Auv
    loss <- loss + sum(diff^2)
  }
  return(loss)
}

# Calculating the loss for both embeddings
loss_svd <- compute_loss(embedding_svd, A)
loss_eigen <- compute_loss(embedding_eigen, A)

# Printing the losses to compare
cat("Loss for SVD embedding:", loss_svd, "\n")
cat("Loss for eigenvector embedding:", loss_eigen, "\n")

if (loss_svd < loss_eigen) {
  cat("SVD embedding has the lowest loss\n")
} else {
  cat("Eigenvector embedding has the lowest loss\n")
}