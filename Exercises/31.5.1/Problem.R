# Draw the degree assortativity plots of the network at http://
# www.networkatlas.eu/exercises/31/1/data.txt using the first
# (edge-centric) and the second (node-centric) strategies explained
# in Section 31.1. For best results, use logarithmic axes and color the
# points proportionally to the logarithmic count of the observations
# with the same values.

library(here)
library(igraph)
library(ggplot2)
library(viridis)

# Loading edge list
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Computing node degrees
deg <- degree(g)

# Write here the solution