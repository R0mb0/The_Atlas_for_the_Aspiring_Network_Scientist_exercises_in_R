# Perform 10, 000 random walks of length 6 in the network at
# http://www.networkatlas.eu/exercises/43/1/data.txt. Build
# embeddings with d = 32 using Word2Vec (I suggest using the
# gensim implementation). Reduce them to two dimensions using
# sklearn.manifold.TSNE. Visualize the network by using the 2D
# embeddings as spatial coordinates. Use http://www.networkatlas.
# eu/exercises/43/1/nodes.txt to determine the node colors.

library(igraph)
library(here)
library(Rtsne)
library(word2vec)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
network_data <- as.matrix(network_data)
network_data_char <- apply(network_data, 2, as.character)
g <- graph_from_edgelist(network_data_char, directed = FALSE)

# Loading the node colors
node_colors_data <- read.table(here("nodes.txt"), header = FALSE)
node_colors <- node_colors_data[,2]
names(node_colors) <- as.character(node_colors_data[,1])

# Idea of solution 

# Generating random walks
set.seed(42)
num_walks <- 10000
walk_length <- 6
nodes <- V(g)$name
walks <- vector("list", num_walks)

for (i in 1:num_walks) {
  current <- sample(nodes, 1)
  walk <- as.character(current)
  for (j in 2:walk_length) {
    neighbors_list <- neighbors(g, current)
    neighbors_char <- as.character(neighbors_list$name)
    if (length(neighbors_char) == 0) break
    current <- sample(neighbors_char, 1)
    walk <- c(walk, current)
  }
  walks[[i]] <- walk
}

# Writing walks to a temporary text file for word2vec
walks_file <- here("walks.txt")
writeLines(sapply(walks, paste, collapse = " "), walks_file)

# Training Word2Vec embeddings (d = 32)
emb <- word2vec::word2vec(walks_file, type = "skip-gram", dim = 32, window = 5, min_count = 1, iter = 10)

# Extracting the node embedding matrix from the Word2Vec model using as.data.frame
emb_df <- word2vec::as.data.frame(emb)
emb_matrix <- as.matrix(emb_df)
rownames(emb_matrix) <- emb_df$word

# Filtering only the nodes present in your graph
emb_matrix <- emb_matrix[nodes, -1, drop = FALSE] # drop the 'word' column

# Reducing to 2D using t-SNE
set.seed(42)
tsne_result <- Rtsne(emb_matrix, dims = 2)
embedding_2d <- tsne_result$Y

# Visualizing the network using the 2D embeddings as coordinates
plot(
  embedding_2d[,1],
  embedding_2d[,2],
  col = as.factor(node_colors[nodes]),
  pch = 19,
  xlab = "TSNE dim 1",
  ylab = "TSNE dim 2",
  main = "2D Node Embeddings Visualization"
)