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

# Write here the solution