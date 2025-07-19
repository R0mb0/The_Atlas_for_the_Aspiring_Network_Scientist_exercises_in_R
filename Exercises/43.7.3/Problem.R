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

# Write here the solution 