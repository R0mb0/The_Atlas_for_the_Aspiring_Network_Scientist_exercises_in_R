# Calculate the distance using the same vectors as the previous ques-
# tions, this time on the http://www.networkatlas.eu/exercises/
# 47/3/data.txt network, with both the average linkage shortest
# path and the Laplacian approaches. Are these vectors closer or
# farther in this network than in the previous one?

library(igraph)
library(here)

# Loading the new edge list and building the graph
edges_new <- read.table(here("data.txt"), header = FALSE)
g_new <- graph_from_data_frame(edges_new, directed = FALSE)

# Loading vector1 and vector2
vec1 <- read.table(here("vector1.txt"), header = FALSE)
vec2 <- read.table(here("vector2.txt"), header = FALSE)

# Renaming columns for clarity
colnames(vec1) <- c("id", "value")
colnames(vec2) <- c("id", "value")

# Write here the solution 