# Consider the multilayer network at at http://www.networkatlas.
# eu/exercises/24/3/data.txt. Calculate the Pearson correlation
# between layers (each layer is a vector with an entry per edge. The
# entry is 1 if the edge is present in the layer, 0 otherwise). What
# does this tell you about multilayer link prediction? Should you
# assume layers are independent and therefore apply a single layer
# link prediction to each layer?

library(here)

# Reading the data
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "layer")

# Solution 

# Getting unique layers and all unique node pairs
layers <- unique(edges$layer)
all_edges <- unique(rbind(
  edges[c("from", "to")],
  edges[c("to", "from")]
))

# Creating a sorted list of all unique undirected edges for vectorization
all_edges_sorted <- t(apply(all_edges, 1, function(row) sort(as.character(row))))
all_edges_df <- unique(data.frame(from=all_edges_sorted[,1], to=all_edges_sorted[,2], stringsAsFactors=FALSE))

# Building a binary presence matrix: rows = all edges, columns = layers
edge_layer_mat <- matrix(0, nrow=nrow(all_edges_df), ncol=length(layers))
colnames(edge_layer_mat) <- as.character(layers)

for (i in seq_along(layers)) {
  layer_edges <- edges[edges$layer == layers[i], c("from", "to")]
  # Make sure to treat undirected edges as equivalent
  layer_edges_sorted <- t(apply(layer_edges, 1, function(row) sort(as.character(row))))
  layer_edges_df <- data.frame(from=layer_edges_sorted[,1], to=layer_edges_sorted[,2], stringsAsFactors=FALSE)
  matches <- apply(all_edges_df, 1, function(edge) {
    any(apply(layer_edges_df, 1, function(le) all(le == edge)))
  })
  edge_layer_mat[,i] <- as.integer(matches)
}

# Computing Pearson correlation for each pair of layers
layer_corr <- cor(edge_layer_mat, method="pearson")

# Printing results
cat("Pearson correlation matrix between layers:\n")
print(round(layer_corr, 3))

# Interpreting
mean_corr <- mean(layer_corr[lower.tri(layer_corr)])
cat(sprintf("\nMean off-diagonal correlation: %.3f\n", mean_corr))
if (mean_corr > 0.7) {
  cat("Conclusion: Layers are highly correlated, so they are not independent. Multilayer link prediction should consider dependencies.\n")
} else if (mean_corr < 0.3) {
  cat("Conclusion: Layers are weakly correlated and can be considered nearly independent. You may use single-layer predictors for each layer.\n")
} else {
  cat("Conclusion: Layers have moderate correlation; use caution and consider dependencies in prediction.\n")
}