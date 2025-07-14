# Perform the null model test you did for exercise 1 also for global
# reach centrality and arborescence. Which method is farther from
# the average expected hierarchy value?

library(here)
library(igraph)

# Loading the network ----
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building tha graph
g <- graph_from_data_frame(edges, directed = TRUE)
N <- vcount(g)
original_edge_count <- gsize(g)

# Write here the solution