# Generate the indegree and outdegree Laplacians of the directed
# graph at http://www.networkatlas.eu/exercises/8/4/data.
# txt. Calculate their eigenvalues as well as the eigenvalue of the
# undirected version of the graph.

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")

# Solution

################################################################################
# Optional building a Plot

g <- graph_from_data_frame(edges, directed=TRUE)
################################################################################

# Adjacency matrix
A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))

# Node order (for consistent matrix construction)
nodes <- V(g)$name
n <- length(nodes)

# Out-degree Laplacian: L_out = D_out - A
d_out <- rowSums(A)
L_out <- diag(d_out) - A

# In-degree Laplacian: L_in = D_in - A^T = diag(colSums(A)) - t(A)
d_in <- colSums(A)
L_in <- diag(d_in) - t(A)

# Eigenvalues (real part, sorted decreasing)
eig_out <- eigen(L_out, only.values=FALSE)
eigvals_out <- sort(Re(eig_out$values), decreasing=TRUE)

eig_in <- eigen(L_in, only.values=FALSE)
eigvals_in <- sort(Re(eig_in$values), decreasing=TRUE)

# Undirected version
g_undir <- as.undirected(g, mode="collapse")
A_undir <- as.matrix(as_adjacency_matrix(g_undir, sparse=FALSE))
d_undir <- rowSums(A_undir)
L_undir <- diag(d_undir) - A_undir

eig_undir <- eigen(L_undir, only.values=FALSE)
eigvals_undir <- sort(Re(eig_undir$values), decreasing=TRUE)

# Printing the results
cat("Eigenvalues of OUT-degree Laplacian (L_out):\n")
print(eigvals_out)

cat("\nEigenvalues of IN-degree Laplacian (L_in):\n")
print(eigvals_in)

cat("\nEigenvalues of undirected Laplacian:\n")
print(eigvals_undir)