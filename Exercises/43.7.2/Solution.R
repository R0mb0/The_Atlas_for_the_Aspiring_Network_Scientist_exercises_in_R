# Use the Word2Vec embeddings reduced to 2D with tSNE you
# found in the previous exercise to find 4 clusters in the data using
# any clustering algorithm (if kMeans, set k = 4, otherwise you can
# use DBSCAN and find the eps parameter giving you 4 clusters).
# What is the NMI (use the sklearn function to calculate it) of
# the clusters with the ground truth you can find at http://www.
# networkatlas.eu/exercises/43/1/nodes.txt?

library(igraph)
library(here)
library(Rtsne)
library(word2vec)
library(stats) # for kmeans

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
network_data <- as.matrix(network_data)
network_data_char <- apply(network_data, 2, as.character)
g <- graph_from_edgelist(network_data_char, directed = FALSE)

# Loading the node colors (ground truth labels)
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
emb_df <- word2vec::as.data.frame(emb)
emb_matrix <- as.matrix(emb_df)
rownames(emb_matrix) <- emb_df$word
emb_matrix <- emb_matrix[nodes, -1, drop = FALSE] # drop the 'word' column

# Reducing to 2D using t-SNE
set.seed(42)
tsne_result <- Rtsne(emb_matrix, dims = 2)
embedding_2d <- tsne_result$Y

# Running k-means clustering to find 4 clusters
set.seed(42)
kmeans_result <- kmeans(embedding_2d, centers = 4)
clusters <- kmeans_result$cluster

# Saving clusters and ground truth to a file for external NMI calculation in Python
write.table(data.frame(node=nodes, cluster=clusters, label=node_colors[nodes]), here("clusters_nmi.txt"), row.names=FALSE, col.names=TRUE, sep="\t")

# Printing instruction for calculating NMI in Python using sklearn
cat("To calculate NMI, you can use this simple Python script with sklearn:\n")
cat("
import pandas as pd
from sklearn.metrics import normalized_mutual_info_score

df = pd.read_csv('clusters_nmi.txt', sep='\\t')
nmi = normalized_mutual_info_score(df['cluster'], df['label'])
print('NMI:', nmi)
")