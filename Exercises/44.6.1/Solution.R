# Implement the MPGNN described in Section 44.1. You need to
# define an “aggregate” function which takes a list of nodes and
# their embeddings and returns the element-wise mean of those
# embeddings. You need to define an “update” function which takes
# two vectors, sums them, and return their softmax. Finally, you
# need a message-passing function which loops over all nodes of the
# network, applies aggregate to its neighbors, and applies update
# with the result of the aggregation and the node’s embedding. Run
# a single layer of it on the network at http://www.networkatlas.
# eu/exercises/44/1/network.txt, with node features at http:
# //www.networkatlas.eu/exercises/44/1/features.txt. Do you
# get the same results as Figure 44.1?

library(here)
library(Matrix)

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
  # Calculating the mean of neighbor embeddings
  colMeans(embeddings[neighbors, , drop = FALSE])
}

# Defining the update function (sum and softmax)
update <- function(node_emb, agg_emb) {
  sum_vec <- node_emb + agg_emb
  # Applying the softmax function
  exp_vec <- exp(sum_vec)
  exp_vec / sum(exp_vec)
}

# Defining the message-passing function (single layer)
message_passing <- function(features, adj_list) {
  new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
  for (i in seq_len(nrow(features))) {
    # Aggregating neighbor embeddings
    agg <- aggregate(adj_list[[i]], features)
    # Updating the node embedding
    new_embeddings[i, ] <- update(features[i, ], agg)
  }
  new_embeddings
}

# Running a single layer of message passing
embeddings_after_mp <- message_passing(features, adj_list)

# Printing the results
print(embeddings_after_mp)