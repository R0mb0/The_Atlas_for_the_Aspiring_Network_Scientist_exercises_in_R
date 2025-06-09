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

# Solution 

# Kronecker multiply 4 times
K <- A
for (i in 1:3) {
  K <- K %x% A
}

# Setting main diagonal to zero
diag(K) <- 0

# Creating the graph
g <- graph_from_adjacency_matrix(K, mode="undirected", diag=FALSE)

################################################################################
# Optional 
# Plotting the CCDF of the degree distribution
deg <- degree(g)
deg_tab <- table(deg)
deg_vals <- as.numeric(names(deg_tab))
deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
ccdf <- rev(cumsum(rev(deg_prob)))
plot(deg_vals, ccdf, log="xy", pch=19, xlab="Degree", ylab="CCDF", main="Kronecker Graph Degree CCDF")
################################################################################