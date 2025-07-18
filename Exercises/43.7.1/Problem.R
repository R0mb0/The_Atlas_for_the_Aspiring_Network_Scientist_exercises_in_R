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

# Write here the solution 