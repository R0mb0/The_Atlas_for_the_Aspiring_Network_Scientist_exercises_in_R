# http://www.networkatlas.eu/exercises/32/3/data.txt contains
# a nested bipartite network. Draw its adjacency matrix, sorting
# rows and columns by their degree.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building bipartite graph
# Assuming 'from' are type A (start with 'a'), 'to' are type B (start with 'b')
g <- graph_from_data_frame(edges, directed = FALSE)

# Identifying type A and type B nodes
typeA <- unique(edges$from)
typeB <- unique(edges$to)

# Solution

# Creating adjacency matrix (rows: typeA, cols: typeB)
adj_mat <- matrix(0, nrow = length(typeA), ncol = length(typeB),
                  dimnames = list(typeA, typeB))
for(i in seq_len(nrow(edges))) {
  adj_mat[edges$from[i], edges$to[i]] <- 1
}

# Sorting rows and columns by degree
row_deg <- rowSums(adj_mat)
col_deg <- colSums(adj_mat)
adj_mat_sorted <- adj_mat[order(row_deg, decreasing=TRUE),
                          order(col_deg, decreasing=TRUE)]

# Plotting the adjacency matrix
image(adj_mat_sorted, axes=FALSE, col=c("white", "black"),
      main="Sorted Bipartite Adjacency Matrix")
# Adding axis labels
axis(1, at = seq(0, 1, length.out = nrow(adj_mat_sorted)),
     labels = rownames(adj_mat_sorted), las = 2, cex.axis = 0.5)
axis(2, at = seq(0, 1, length.out = ncol(adj_mat_sorted)),
     labels = colnames(adj_mat_sorted), las = 2, cex.axis = 0.5)
