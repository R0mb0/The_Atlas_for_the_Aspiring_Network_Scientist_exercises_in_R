# Calculate the eigenvalues and the right and left eigenvectors of the
# stochastic adjacency of the network at http://www.networkatlas.
# eu/exercises/8/2/data.txt, using the same procedure applied
# in the previous exercise. Make sure to sort the eigenvalues in
# descending order (and sort the eigenvectors accordingly). Only
# take the real part of eigenvalues and eigenvectors, ignoring the
# imaginary part.

library(here)

# Reading the data
dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(dat) <- c("from", "to", "weight")

# Write here the solution 