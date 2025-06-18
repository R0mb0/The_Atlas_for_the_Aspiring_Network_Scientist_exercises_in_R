# What is the minimum statistically significant edge weight – the
# one two standard deviations away from the average – of the previ-
# ous network? How many edges would you keep if you were to set
# that as the threshold?

library(here)
library(igraph)

# Reading the edge list from file
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Extracting edge weights
w <- E(g)$weight

# Write here the solution 