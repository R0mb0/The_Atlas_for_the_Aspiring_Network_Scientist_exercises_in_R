# Compare the NMI score from the previous exercise to the one
# you would get from a classical community discovery like label
# propagation. Note: both methods are randomized, so you could
# perform them multiple times and see the distributions of their
# NMIs.

library(here)
library(data.table)
library(igraph)
library(wordVectors)
library(Rtsne)
library(ggplot2)

# Loading the edge list and building the graph
edges <- fread(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

# This is a idea of solution 

# Getting the node names
nodes <- V(g)$name

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

# Saving the walks
walks_char <- sapply(walks, paste, collapse = " ")
walks_file <- here("walks.txt")
writeLines(walks_char, walks_file)

# Training Word2Vec model with d = 32
embedding_file <- here("walks.bin")
train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)

# Loading the embeddings
embeddings <- read.vectors(embedding_file)
nodes_in_embedding <- rownames(embeddings)
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

# Performing k-means clustering
set.seed(42)
kmeans_result <- kmeans(embedding_2d[, c("V1", "V2")], centers = 4)
embedding_2d$cluster <- kmeans_result$cluster

# Preparing the clustering cover and ground truth cover for NMI
clustering_cover <- lapply(1:4, function(k) embedding_2d$node[embedding_2d$cluster == k])
ground_truth_cover <- lapply(sort(unique(embedding_2d$category)), function(k) embedding_2d$node[embedding_2d$category == k])

# Sourcing the NMI library
source(here("NMI.R"))

# Calculating NMI between k-means clusters and ground truth
nmi_kmeans <- NMI(clustering_cover, ground_truth_cover)
cat("NMI (k-means):", nmi_kmeans, "\n")

# Performing label propagation for community detection
set.seed(42)
lp <- label_propagation_community(g)
lp_membership <- membership(lp)
lp_cover <- lapply(sort(unique(lp_membership)), function(c) names(lp_membership)[lp_membership == c])

# Calculating NMI between label propagation and ground truth
nmi_labelprop <- NMI(lp_cover, ground_truth_cover)
cat("NMI (label propagation):", nmi_labelprop, "\n")

# Visualizing the clusters from both methods
embedding_2d$lp_cluster <- lp_membership[embedding_2d$node]
ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(cluster))) +
  geom_point(size = 2) +
  labs(title = "t-SNE Embeddings Clustered (kMeans, k=4)", x = "t-SNE 1", y = "t-SNE 2", color = "kMeans Cluster") +
  theme_minimal()

ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(lp_cluster))) +
  geom_point(size = 2) +
  labs(title = "t-SNE Embeddings Clustered (Label Propagation)", x = "t-SNE 1", y = "t-SNE 2", color = "Label Propagation Cluster") +
  theme_minimal()