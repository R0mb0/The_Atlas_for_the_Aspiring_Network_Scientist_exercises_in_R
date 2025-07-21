# Calculate the distance using the same data as the previous ques-
# tion, this time with the average linkage shortest path approach.
# Normalize the vectors so that they both sum to one.

library(igraph)
library(here)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_data_frame(edges, directed = FALSE)

# Loading vector1 and vector2
vec1 <- read.table(here("vector1.txt"), header = FALSE)
vec2 <- read.table(here("vector2.txt"), header = FALSE)

# Renaming columns for clarity
colnames(vec1) <- c("id", "value")
colnames(vec2) <- c("id", "value")

# Write here the solution