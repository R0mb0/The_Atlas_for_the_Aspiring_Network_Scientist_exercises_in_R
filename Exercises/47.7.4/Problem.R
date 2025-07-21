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

# Write here the solution 