# Use the Word2Vec embeddings reduced to 2D with tSNE you
# found in the previous exercise to find 4 clusters in the data using
# any clustering algorithm (if kMeans, set k = 4, otherwise you can
# use DBSCAN and find the eps parameter giving you 4 clusters).
# What is the NMI (use the sklearn function to calculate it) of
# the clusters with the ground truth you can find at http://www.
# networkatlas.eu/exercises/43/1/nodes.txt?

library(here)
library(data.table)
library(ggplot2)
library(stats)
library(Rtsne)
library(wordVectors)
library(cluster)

# Loading the 2D embeddings from the previous exercise
embedding_file <- here("walks.bin")
embeddings <- read.vectors(embedding_file)

# Getting the matrix of embeddings for all nodes
nodes_in_embedding <- rownames(embeddings)
X <- embeddings[nodes_in_embedding, ]
set.seed(42)
tsne_result <- Rtsne(as.matrix(X), dims = 2)
embedding_2d <- as.data.frame(tsne_result$Y)
embedding_2d$node <- nodes_in_embedding

# Loading node categories
nodes_info <- fread(here("nodes.txt"), header = FALSE)
colnames(nodes_info) <- c("node", "category")
nodes_info$node <- as.character(nodes_info$node)
embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)

# This should be the solution 

# Finding 4 clusters using kmeans
set.seed(42)
kmeans_result <- kmeans(embedding_2d[, c("V1", "V2")], centers = 4)
embedding_2d$cluster <- kmeans_result$cluster

# Saving clustering assignments and ground truth for Python NMI calculation
fwrite(embedding_2d[, .(node, cluster, category)], here("clustering_result.csv"))

# Calculating NMI with sklearn in Python
# You can run the following Python snippet in the same folder:
# import pandas as pd
# from sklearn.metrics import normalized_mutual_info_score
# df = pd.read_csv("clustering_result.csv")
# nmi = normalized_mutual_info_score(df['category'], df['cluster'])
# print("NMI:", nmi)

# Visualizing the clusters
ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(cluster))) +
  geom_point(size = 2) +
  labs(title = "t-SNE Embeddings Clustered (kMeans, k=4)", x = "t-SNE 1", y = "t-SNE 2", color = "Cluster") +
  theme_minimal()