# Is the AUC you get from the previous question better or worse
# than the one you’d get from a classical link prediction like Jaccard,
# Resource Allocation, Preferential Attachment, or Adamic-Adar?

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