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

# Write here the solution