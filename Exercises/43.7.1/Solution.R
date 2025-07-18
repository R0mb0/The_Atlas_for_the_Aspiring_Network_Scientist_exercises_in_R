# Perform 10, 000 random walks of length 6 in the network at
# http://www.networkatlas.eu/exercises/43/1/data.txt. Build
# embeddings with d = 32 using Word2Vec (I suggest using the
# gensim implementation). Reduce them to two dimensions using
# sklearn.manifold.TSNE. Visualize the network by using the 2D
# embeddings as spatial coordinates. Use http://www.networkatlas.
# eu/exercises/43/1/nodes.txt to determine the node colors.

library(here)
library(data.table)
library(igraph)
library(wordVectors)
library(Rtsne)
library(ggplot2)

# Loading the edge list
edges <- fread(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")

# Building the undirected graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Getting the node names
nodes <- V(g)$name

# This should be the solution 

# Performing random walks
set.seed(42)
walk_length <- 6
n_walks <- 10000
walks <- vector("list", n_walks)

for (i in seq_len(n_walks)) {
  start_node <- sample(nodes, 1)
  walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
  walks[[i]] <- as.character(walk)
}

# Saving walks to a text file for wordVectors
walks_char <- sapply(walks, paste, collapse = " ")
walks_file <- here("walks.txt")
writeLines(walks_char, walks_file)

# Training Word2Vec model with d = 32
embedding_file <- here("walks.bin")
train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)

# Loading embeddings
embeddings <- read.vectors(embedding_file)

# Getting the matrix of embeddings for all nodes in the graph
nodes_in_embedding <- intersect(nodes, rownames(embeddings))
X <- embeddings[nodes_in_embedding, ]

# Reducing to two dimensions using t-SNE
set.seed(42)
tsne_result <- Rtsne(as.matrix(X), dims = 2)
embedding_2d <- as.data.frame(tsne_result$Y)
embedding_2d$node <- nodes_in_embedding

# Loading node categories
nodes_info <- fread(here("nodes.txt"), header = FALSE)
colnames(nodes_info) <- c("node", "category")
nodes_info$node <- as.character(nodes_info$node)
embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)

# Visualizing the network using 2D embeddings as coordinates and coloring by node category
ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(category))) +
  geom_point(size = 2) +
  labs(title = "Network Visualization using Word2Vec Embeddings (t-SNE Reduced)",
       x = "t-SNE 1", y = "t-SNE 2", color = "Node Category") +
  theme_minimal()