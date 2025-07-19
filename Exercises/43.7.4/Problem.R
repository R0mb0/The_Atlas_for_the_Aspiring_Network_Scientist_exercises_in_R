# Use the Word2Vec embeddings reduced to 2D with tSNE you
# found in the previous exercise as a link prediction score (if Zu and
# Zv are node embeddings, then the score for edge u, v is ZuT Zv ).
# Draw the ROC curve of your predictions, assuming that the true
# new edges are the ones you can find in http://www.networkatlas.
# eu/exercises/43/4/newedges.txt.

library(here)
library(data.table)
library(igraph)
library(wordVectors)
library(Rtsne)
library(ggplot2)
library(pROC)

# Loading the edge list and building the graph
edges <- fread(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

# Getting the node names
nodes <- V(g)$name

# Write here the solution 