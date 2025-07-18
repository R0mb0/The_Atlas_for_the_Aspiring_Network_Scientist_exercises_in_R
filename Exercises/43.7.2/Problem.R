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

# Write here the solution 