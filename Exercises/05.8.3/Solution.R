# Calculate the eigenvalues and the right and left eigenvectors of
# the matrix from http://www.networkatlas.eu/exercises/5/3/
# data.txt. Make sure to sort the eigenvalues in descending order
# (and sort the eigenvectors accordingly). Only take the real part of
# eigenvalues and eigenvectors, ignoring the imaginary part.

library(here)

mat <- as.matrix(read.table("data.txt"))

# Solution

# Calculating eigenvalues and right eigenvectors (Right eigenvectors are in eig$vectors)
eig_right <- eigen(mat)

# Calculating left eigenvectors: eigenvectors of the transposed matrix (Left eigenvectors are in eig_left$vectors)
eig_left <- eigen(t(mat))

# Taking only the real parts
eigvals <- Re(eig_right$values)
eigvecs_right <- Re(eig_right$vectors)
eigvecs_left  <- Re(eig_left$vectors)

# Getting sorting order
ord <- order(eigvals, decreasing = TRUE)
eigvals_sorted <- eigvals[ord]
eigvecs_right_sorted <- eigvecs_right[, ord]
eigvecs_left_sorted  <- eigvecs_left[, ord]

# printing the results 
cat("Eigenvalues (sorted):\n")
print(eigvals_sorted)

cat("\nRight eigenvectors (columns):\n")
print(eigvecs_right_sorted)

cat("\nLeft eigenvectors (columns):\n")
print(eigvecs_left_sorted)