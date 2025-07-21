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

# Solution 

# Normalizing the vectors so that they both sum to one
vec1$value <- vec1$value / sum(vec1$value)
vec2$value <- vec2$value / sum(vec2$value)

# Getting all node ids from the new graph
all_nodes_new <- as.numeric(V(g_new)$name)

# Creating full vectors with zeros for missing nodes
vec1_full_new <- setNames(rep(0, length(all_nodes_new)), all_nodes_new)
vec2_full_new <- setNames(rep(0, length(all_nodes_new)), all_nodes_new)

# Filling the vectors with values
vec1_full_new[as.character(vec1$id)] <- vec1$value
vec2_full_new[as.character(vec2$id)] <- vec2$value

# Getting the node ids with nonzero values in each vector
nodes1_new <- as.character(names(vec1_full_new[vec1_full_new > 0]))
nodes2_new <- as.character(names(vec2_full_new[vec2_full_new > 0]))

# Calculating the average linkage shortest path distance
distance_matrix_new <- distances(g_new, v = nodes1_new, to = nodes2_new)
weights_new <- outer(vec1_full_new[nodes1_new], vec2_full_new[nodes2_new], FUN = "*")
average_distance_new <- sum(distance_matrix_new * weights_new)

# Printing the average linkage result
cat("Average linkage shortest path distance in the new network is:", average_distance_new, "\n")

# Calculating the Laplacian distance
laplacian_new <- laplacian_matrix(g_new, sparse = FALSE)
diff_vec_new <- vec1_full_new - vec2_full_new
laplacian_distance_new <- sqrt(as.numeric(t(diff_vec_new) %*% laplacian_new %*% diff_vec_new))

cat("Laplacian distance in the new network is:", laplacian_distance_new, "\n")