# Calculate the eigenvalues and the right and left eigenvectors of
# the matrix from http://www.networkatlas.eu/exercises/5/3/
# data.txt. Make sure to sort the eigenvalues in descending order
# (and sort the eigenvectors accordingly). Only take the real part of
# eigenvalues and eigenvectors, ignoring the imaginary part.

library(here)

mat <- as.matrix(read.table("data.txt"))

# Write here the solution