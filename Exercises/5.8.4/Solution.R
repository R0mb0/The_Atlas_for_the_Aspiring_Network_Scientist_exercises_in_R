# Perform the eigendecompositions of the matrices from exercise 2,
# showing that you can reconstruct the originals from their eigenval-
# ues and eigenvectors.

# Matrices:
#
#  A=(1 0)
#     0 2
#
#  B=(3 0)
#     0 -1

library(here) 

# Defining the matrices
A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)

# Solution

# Eigendecomposition for A
eig_A <- eigen(A)
V_A <- eig_A$vectors        # Eigenvectors matrix
D_A <- diag(eig_A$values)   # Diagonal matrix of eigenvalues

# Reconstructing A
A_reconstructed <- V_A %*% D_A %*% solve(V_A)

# Eigendecomposition for B
eig_B <- eigen(B)
V_B <- eig_B$vectors
D_B <- diag(eig_B$values)

# Reconstructing B
B_reconstructed <- V_B %*% D_B %*% solve(V_B)

# Printing results
cat("Original A:\n") print(A)
cat("Reconstructed A:\n"); print(A_reconstructed)

cat("\nOriginal B:\n"); print(B)
cat("Reconstructed B:\n"); print(B_reconstructed)