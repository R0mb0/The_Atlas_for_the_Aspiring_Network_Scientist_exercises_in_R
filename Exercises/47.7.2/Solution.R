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

# Solution 

# Normalizing the vectors so that they both sum to one
vec1$value <- vec1$value / sum(vec1$value)
vec2$value <- vec2$value / sum(vec2$value)

# Getting all node ids from the graph
all_nodes <- as.numeric(V(g)$name)

# Creating full vectors with zeros for missing nodes
vec1_full <- setNames(rep(0, length(all_nodes)), all_nodes)
vec2_full <- setNames(rep(0, length(all_nodes)), all_nodes)

# Filling the vectors with values
vec1_full[as.character(vec1$id)] <- vec1$value
vec2_full[as.character(vec2$id)] <- vec2$value

# Getting the node ids with nonzero values in each vector
nodes1 <- as.character(names(vec1_full[vec1_full > 0]))
nodes2 <- as.character(names(vec2_full[vec2_full > 0]))

# Calculating the distance matrix using the correct vertex names
distance_matrix <- distances(g, v = nodes1, to = nodes2)

# Calculating the weights for each node pair
weights <- outer(vec1_full[nodes1], vec2_full[nodes2], FUN = "*")

# Calculating the average linkage distance
average_distance <- sum(distance_matrix * weights)

cat("Average linkage shortest path distance between the vectors is:", average_distance, "\n")