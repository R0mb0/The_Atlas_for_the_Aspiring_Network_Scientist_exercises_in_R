# Divide the network at http://www.networkatlas.eu/exercises/
# 25/1/data.txt into train and test sets using a ten-fold cross vali-
# dation scheme. Draw its confusion matrix after applying a jaccard
# link prediction to it. Use 0.5 as you cutoff score: scores equal to or
# higher than 0.5 are predicted to be an edge, anything lower is pre-
# dicted to be a non-edge. (Hint: make heavy use of scikit-learn
# capabilities of performing KFold divisions and building confusion
# matrices)

library(here)
library(igraph)
library(caret)
library(yardstick)

# Reading the data and building the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
edges[] <- lapply(edges, as.character)
g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

all_nodes <- V(g_full)$name

# Write here the solution 