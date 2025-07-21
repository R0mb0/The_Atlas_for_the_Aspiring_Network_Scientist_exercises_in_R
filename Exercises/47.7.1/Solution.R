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

# Getting the Laplacian matrix
laplacian <- laplacian_matrix(g, sparse = FALSE)

# Calculating the difference vector
diff_vec <- vec1_full - vec2_full

# Calculating the Laplacian distance
distance <- sqrt(as.numeric(t(diff_vec) %*% laplacian %*% diff_vec))

# Printing the result
cat("Laplacian distance between the vectors is:", distance, "\n")