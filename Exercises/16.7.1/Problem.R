# Consider the network in http://www.networkatlas.eu/exercises/
# 16/1/data.txt. Generate an Erdős-Rényi graph with the same
# number of nodes and edges. Plot both networks’ degree CCDFs,
# in log-log scale. Discuss the salient differences between these
# istributions.

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution