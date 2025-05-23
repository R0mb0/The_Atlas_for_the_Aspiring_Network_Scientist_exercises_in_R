# Generate the signed and unsigned Laplacians of the signed graph
# at http://www.networkatlas.eu/exercises/8/5/data.txt – the
# third column contains the sign. Calculate their eigenvalues as well
# as the eigenvalue of the version of the graph ignoring edge signs.

library(here)
library(igraph)

# Reading the data
dat <- read.table("data.txt", header=FALSE)
colnames(dat) <- c("from", "to", "sign")

# Solution

# Building signed adjacency matrix
nodes <- sort(unique(c(dat$from, dat$to)))
n <- length(nodes)
A_signed <- matrix(0, nrow=n, ncol=n, dimnames=list(nodes, nodes))

for(i in 1:nrow(dat)){
  a <- as.character(dat$from[i])
  b <- as.character(dat$to[i])
  s <- as.numeric(dat$sign[i])
  A_signed[a, b] <- s
  A_signed[b, a] <- s # undirected
}

# Degree matrix for signed graph: sum of absolute values of row/col
D_signed <- diag(rowSums(abs(A_signed)))

# Signed Laplacian: L_signed = D_signed - A_signed
L_signed <- D_signed - A_signed

# Eigenvalues of signed Laplacian
eig_signed <- eigen(L_signed)
eigvals_signed <- sort(Re(eig_signed$values), decreasing=TRUE)

# Unsigned adjacency (absolute values)
A_unsigned <- abs(A_signed)
D_unsigned <- diag(rowSums(A_unsigned))
L_unsigned <- D_unsigned - A_unsigned

# Eigenvalues of unsigned Laplacian
eig_unsigned <- eigen(L_unsigned)
eigvals_unsigned <- sort(Re(eig_unsigned$values), decreasing=TRUE)

# Laplacian ignoring signs (as a normal undirected graph)
# Optional working using a plot 
g_undir <- graph_from_data_frame(dat[,1:2], directed=FALSE)
A_undir <- as.matrix(as_adjacency_matrix(g_undir, sparse=FALSE))
D_undir <- diag(rowSums(A_undir))
L_undir <- D_undir - A_undir
eig_undir <- eigen(L_undir)
eigvals_undir <- sort(Re(eig_undir$values), decreasing=TRUE)

# Printing the results
cat("Eigenvalues of SIGNED Laplacian:\n")
print(eigvals_signed)

cat("\nEigenvalues of UNSIGNED Laplacian (use |sign| for edge weights):\n")
print(eigvals_unsigned)

cat("\nEigenvalues of Laplacian ignoring edge signs (normal graph):\n")
print(eigvals_undir)