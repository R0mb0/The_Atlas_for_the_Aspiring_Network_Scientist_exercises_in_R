# Can you calculate the doubly stochastic adjacency matrix of
# the network used in the previous exercise? Does the calculation
# eventually converge? (Limit the normalization attempts to 1,000. If
# by 1,000 normalizations you don’t have a doubly stochastic matrix,
# the calculation didn’t converge)

library(here)
library(igraph)

# Reading the edge list from file
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Solution 

# Getting the adjacency matrix (rows/cols: all nodes, values: weights)
A <- as.matrix(as_adjacency_matrix(g, attr="weight", sparse=FALSE))

# Preparing the matrix for normalization (only positive values, fill zeros for missing edges)
A[is.na(A)] <- 0

# Function to normalize rows or columns to sum to 1
normalize_rows <- function(mat) {
  rs <- rowSums(mat)
  rs[rs == 0] <- 1 # avoid division by zero
  mat/rs
}
normalize_cols <- function(mat) {
  cs <- colSums(mat)
  cs[cs == 0] <- 1 # avoid division by zero
  t(t(mat)/cs)
}

# Iterative normalization: alternate row and column normalization
max_iter <- 1000
tol <- 1e-8
converged <- FALSE
for(i in 1:max_iter) {
  old_A <- A
  A <- normalize_rows(A)
  A <- normalize_cols(A)
  # Check convergence: all row and col sums close to 1
  row_diff <- max(abs(rowSums(A) - 1))
  col_diff <- max(abs(colSums(A) - 1))
  if(row_diff < tol && col_diff < tol) {
    converged <- TRUE
    cat(sprintf("Converged after %d iterations.\n", i))
    break
  }
}
if(!converged) {
  cat("Did NOT converge after 1000 iterations.\n")
}

################################################################################

# Optional
# Showing summary of the final matrix
cat("summary of the final matrix \n")
cat("\n Max row sum deviation from 1:", max(abs(rowSums(A) - 1)), "\n")
cat("Max col sum deviation from 1:", max(abs(colSums(A) - 1)), "\n")

# Printing the entire matrix (rounded for readability)
cat("Entire doubly stochastic matrix (rounded to 4 decimals):\n")
print(round(A, 4))

# Plotting the entire matrix
par(bg="white")
image(
  t(A[nrow(A):1, ]),                        # flip vertically for intuitive axes
  main = "Doubly Stochastic Matrix",
  xlab = "Columns",
  ylab = "Rows",
  col = gray.colors(100, start=1, end=0),   # white to black
  axes = FALSE
)
box()
axis(1, at=seq(0,1,length.out=ncol(A)), labels=colnames(A), las=2, cex.axis=0.5)
axis(2, at=seq(0,1,length.out=nrow(A)), labels=rev(rownames(A)), las=2, cex.axis=0.5)
################################################################################