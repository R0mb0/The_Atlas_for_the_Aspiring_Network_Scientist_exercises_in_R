# Write the degree sequence of the graph in Figure 9.7. First consid-
# ering all layers at once, then separately for each layer.

library(igraph)

nodes <- as.character(1:9)

# Edge lists for each layer/color (example, adapt if you see differences!)
edges_brown <- matrix(c(1,3, 3,2, 2,4, 3,4, 6,8, 6,9), ncol=2, byrow=TRUE)
edges_green <- matrix(c(1,4, 4,5, 5,8, 4,7, 8,9), ncol=2, byrow=TRUE)
edges_blue  <- matrix(c(2,5, 5,7, 6,9), ncol=2, byrow=TRUE)
edges_orange<- matrix(c(1,2, 2,5, 7,8, 7,6, 6,9), ncol=2, byrow=TRUE)
edges_purple<- matrix(c(2,5, 5,7, 5,6, 6,8), ncol=2, byrow=TRUE)
edges_red   <- matrix(c(1,3, 4,5), ncol=2, byrow=TRUE)

# Solution 

# Combine all layers for total degree sequence
all_edges <- rbind(
  edges_brown,
  edges_green,
  edges_blue,
  edges_orange,
  edges_purple,
  edges_red
)

g_all <- graph_from_edgelist(all_edges, directed=FALSE)
deg_all <- degree(g_all, v=nodes)
cat("Degree sequence considering all layers at once:\n")
print(deg_all)

# Calculate degree for each layer separately
layers <- list(
  brown=edges_brown,
  green=edges_green,
  blue=edges_blue,
  orange=edges_orange,
  purple=edges_purple,
  red=edges_red
)

cat("\nDegree sequences for each layer:\n")
for(layer in names(layers)) {
  # Convert edges to data frame for compatibility
  edge_df <- as.data.frame(layers[[layer]])
  names(edge_df) <- c("from", "to")
  g_layer <- graph_from_data_frame(edge_df, directed=FALSE, vertices=data.frame(name=nodes))
  deg_layer <- degree(g_layer, v=nodes)
  cat(sprintf("%s: %s\n", layer, paste(deg_layer, collapse=" ")))
}
