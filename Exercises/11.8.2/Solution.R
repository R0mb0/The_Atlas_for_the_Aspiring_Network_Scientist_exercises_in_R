# Calculate the non-backtracking matrix of the network used for the
# previous question. (The network is undirected)

library(here)

# Reading the data
edges <- read.table("data.txt", header = FALSE)
colnames(edges) <- c("from", "to")

# This should be the solution...

# Making sure all edges are unique and undirected
edges <- unique(data.frame(from = pmin(edges$from, edges$to), to = pmax(edges$from, edges$to)))

# Creating directed edges (both directions for each undirected edge)
directed_edges <- rbind(
  data.frame(from = edges$from, to = edges$to),
  data.frame(from = edges$to, to = edges$from)
)
n_dir <- nrow(directed_edges)

# Building the non-backtracking matrix
B <- matrix(0, nrow = n_dir, ncol = n_dir)
for (i in 1:n_dir) {
  for (j in 1:n_dir) {
    # edge i: a -> b
    # edge j: c -> d
    if (directed_edges$to[i] == directed_edges$from[j] &&
        directed_edges$from[i] != directed_edges$to[j]) {
      B[i, j] <- 1
    }
  }
}

# Assigning row/col names for clarity
rownames(B) <- paste(directed_edges$from, "->", directed_edges$to)
colnames(B) <- paste(directed_edges$from, "->", directed_edges$to)

# Printing the result
print(B)