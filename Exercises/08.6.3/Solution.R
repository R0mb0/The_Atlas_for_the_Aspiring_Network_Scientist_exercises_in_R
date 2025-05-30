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

# Solution

# Identifying the bipartite sets
nodes1 <- unique(dat$from)
nodes2 <- unique(dat$to)
if (length(nodes1) == 248) {
  axis_nodes <- nodes1
  axis_label <- "from"
  other_label <- "to"
} else if (length(nodes2) == 248) {
  axis_nodes <- nodes2
  axis_label <- "to"
  other_label <- "from"
} else {
  stop("Neither axis has 248 unique nodes.")
}

# Building weighted incidence matrix (rows: axis_nodes)
all_nodes_A <- sort(unique(dat[[axis_label]]))
all_nodes_B <- sort(unique(dat[[other_label]]))
incidence <- matrix(0, nrow=length(all_nodes_A), ncol=length(all_nodes_B),
                    dimnames=list(all_nodes_A, all_nodes_B))
for (i in 1:nrow(dat)) {
  a <- as.character(dat[i, axis_label])
  b <- as.character(dat[i, other_label])
  w <- as.numeric(dat[i, "weight"])
  incidence[a, b] <- w
}

# Weighted projection along axis_nodes
projection <- incidence %*% t(incidence)
diag(projection) <- 0 # remove self-loops

# Stochastic adjacency matrix (row-normalized)
row_sums <- rowSums(projection)
row_sums[row_sums == 0] <- 1
stochastic <- projection / row_sums

# Eigenvalues & eigenvectors
eig <- eigen(stochastic)
values <- Re(eig$values)
right_vecs <- Re(eig$vectors)
# For left eigenvectors -> t(stochastic) (since left eigvecs of A are right eigvecs of t(A))
eig_left <- eigen(t(stochastic))
left_vecs <- Re(eig_left$vectors)

# Sorting eigenvalues and vectors in descending order
idx <- order(values, decreasing=TRUE)
values_sorted <- values[idx]
right_vecs_sorted <- right_vecs[, idx, drop=FALSE]
left_vecs_sorted <- left_vecs[, idx, drop=FALSE]

# Printing the result
cat("Eigenvalues (sorted, real part):\n")
print(values_sorted)

cat("\nFirst 5 right eigenvectors (columns, real part):\n")
print(round(right_vecs_sorted[, 1:5, drop=FALSE], 4))

cat("\nFirst 5 left eigenvectors (columns, real part):\n")
print(round(left_vecs_sorted[, 1:5, drop=FALSE], 4))