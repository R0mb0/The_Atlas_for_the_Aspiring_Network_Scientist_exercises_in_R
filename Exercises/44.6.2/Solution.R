# Run the MPGNN you designed in the previous exercise. Make
# a scatter plot of the node embeddings using the two dimensions
# as x and y coordinates at the first, fifth, tenth, and twentieth layer.
# What do you observe?

library(here)
library(Matrix)
library(ggplot2)

# Loading the node features
features <- as.matrix(read.table(here("features.txt")))

# Loading the edge list and building the graph
edges <- as.matrix(read.table(here("network.txt")))
num_nodes <- nrow(features)

# Solution 

# Creating adjacency list
adj_list <- vector("list", num_nodes)
for (i in seq_len(nrow(edges))) {
  src <- edges[i, 1] + 1
  tgt <- edges[i, 2] + 1
  adj_list[[src]] <- c(adj_list[[src]], tgt)
  adj_list[[tgt]] <- c(adj_list[[tgt]], src)
}

# Defining the aggregate function (element-wise mean)
aggregate <- function(neighbors, embeddings) {
  if (length(neighbors) == 0) {
    return(rep(0, ncol(embeddings)))
  }
  colMeans(embeddings[neighbors, , drop = FALSE])
}

# Defining the update function (sum and softmax)
update <- function(node_emb, agg_emb) {
  sum_vec <- node_emb + agg_emb
  exp_vec <- exp(sum_vec)
  exp_vec / sum(exp_vec)
}

# Defining the message-passing function (single layer)
message_passing <- function(features, adj_list) {
  new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
  for (i in seq_len(nrow(features))) {
    agg <- aggregate(adj_list[[i]], features)
    new_embeddings[i, ] <- update(features[i, ], agg)
  }
  new_embeddings
}

# Storing embeddings at specified layers
embeddings_layers <- list()
embeddings <- features

# Running the first layer and saving it
embeddings <- message_passing(embeddings, adj_list)
embeddings_layers[[1]] <- embeddings

# Running up to 20 layers and saving at 5, 10, and 20
for (layer in 2:20) {
  embeddings <- message_passing(embeddings, adj_list)
  if (layer %in% c(5, 10, 20)) {
    embeddings_layers[[as.character(layer)]] <- embeddings
  }
}

# Plotting function for a layer
plot_layer <- function(emb, layer_num) {
  df <- data.frame(x = emb[,1], y = emb[,2], node = factor(1:nrow(emb)))
  ggplot(df, aes(x = x, y = y, label = node)) +
    geom_point(size = 3, color = "blue") +
    geom_text(vjust = -1) +
    ggtitle(paste("Scatter plot of node embeddings at layer", layer_num)) +
    theme_minimal()
}

# Plotting each required layer
print(plot_layer(features, 0)) # Initial features
print(plot_layer(embeddings_layers[[1]], 1))
print(plot_layer(embeddings_layers[["5"]], 5))
print(plot_layer(embeddings_layers[["10"]], 10))
print(plot_layer(embeddings_layers[["20"]], 20))

# Observe that embeddings of nodes in the same connected group become more similar as layers increase