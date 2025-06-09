# Use kron function from numpy to implement a Kronecker graph
# generator. Plot the CCDF degree distribution of a Kronecker graph
# with the following seed matrix multiplied 4 times (setting the main
# diagonal to zero once you’re done):

#     1 1 1 0
# A = 1 1 1 0
#     1 1 1 1 
#     0 0 1 1 

library(here)
library(igraph)

# Defining the seed matrix
A <- matrix(c(
  1, 1, 1, 0,
  1, 1, 1, 0,
  1, 1, 1, 1,
  0, 0, 1, 1
), nrow=4, byrow=TRUE)

# Write here the solution