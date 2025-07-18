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

# Write here the solution