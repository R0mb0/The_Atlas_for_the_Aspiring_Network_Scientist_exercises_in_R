# Calculate the distance between the node vectors in http://www.
# networkatlas.eu/exercises/47/1/vector1.txt and http://
# www.networkatlas.eu/exercises/47/1/vector2.txt over the
# network in http://www.networkatlas.eu/exercises/47/1/data.
# txt, using the Laplacian approach. The vector files have two
# columns: the first column is the id of the node, the second column
# is the corresponding value in the vector. Normalize the vectors so
# that they both sum to one.

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