# Calculate the variances of the vectors used in the previous exer-
# cises on both networks used in the previous exercises.

library(here)

# Loading vector1 and vector2
vec1 <- read.table(here("vector1.txt"), header = FALSE)
vec2 <- read.table(here("vector2.txt"), header = FALSE)

# Renaming columns for clarity
colnames(vec1) <- c("id", "value")
colnames(vec2) <- c("id", "value")

# Normalizing the vectors so that they both sum to one
vec1$value <- vec1$value / sum(vec1$value)
vec2$value <- vec2$value / sum(vec2$value)

# Loading the first network
edges1 <- read.table(here("data.txt"), header = FALSE)
node_ids1 <- unique(c(edges1$V1, edges1$V2))

# Solution 

# Creating full vectors with zeros for missing nodes in network 1
vec1_full_1 <- setNames(rep(0, length(node_ids1)), node_ids1)
vec2_full_1 <- setNames(rep(0, length(node_ids1)), node_ids1)
vec1_full_1[as.character(vec1$id)] <- vec1$value
vec2_full_1[as.character(vec2$id)] <- vec2$value

# Calculating variances for network 1
variance_vec1_net1 <- var(vec1_full_1)
variance_vec2_net1 <- var(vec2_full_1)

cat("Variance of vector1 on network 1:", variance_vec1_net1, "\n")
cat("Variance of vector2 on network 1:", variance_vec2_net1, "\n")

# Loading the second network
edges2 <- read.table(here("data.txt"), header = FALSE)
node_ids2 <- unique(c(edges2$V1, edges2$V2))

# Creating full vectors with zeros for missing nodes in network 2
vec1_full_2 <- setNames(rep(0, length(node_ids2)), node_ids2)
vec2_full_2 <- setNames(rep(0, length(node_ids2)), node_ids2)
vec1_full_2[as.character(vec1$id)] <- vec1$value
vec2_full_2[as.character(vec2$id)] <- vec2$value

# Calculating variances for network 2
variance_vec1_net2 <- var(vec1_full_2)
variance_vec2_net2 <- var(vec2_full_2)

cat("Variance of vector1 on network 2:", variance_vec1_net2, "\n")
cat("Variance of vector2 on network 2:", variance_vec2_net2, "\n")