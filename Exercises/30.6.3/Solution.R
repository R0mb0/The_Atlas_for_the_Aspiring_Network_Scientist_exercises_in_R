# What is the relative popularity of attribute values “right-leaning”
# and “left-leaning”? Based on what you discovered in the first
# exercise, would you say that there is a majority illusion in the
# network?

library(here)
library(igraph)

# Loading edge list
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Loading node attributes
nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
colnames(nodes_df) <- c("id", "leaning")

# Solution 

# Ensuring node ids are characters for matching
nodes_df$id <- as.character(nodes_df$id)
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Creating igraph object
g <- graph_from_data_frame(edges, directed=FALSE, vertices=nodes_df)

# Relative popularity: proportion of each leaning in the whole network
table_leaning <- table(V(g)$leaning)
total_nodes <- sum(table_leaning)
rel_popularity <- table_leaning / total_nodes

# Printing the result 
cat("Relative popularity in the whole network:\n")
print(rel_popularity)

# Now, majority illusion: For each node, what is the majority attribute among its neighbors?
neighbor_majority <- character(vcount(g))
names(neighbor_majority) <- V(g)$name

for (v in V(g)) {
  ego_name <- as.character(v)
  neighbors <- neighbors(g, ego_name)
  if (length(neighbors) == 0) {
    neighbor_majority[ego_name] <- NA
  } else {
    neighbor_leanings <- V(g)[neighbors]$leaning
    tab <- table(neighbor_leanings)
    # If tie, pick one arbitrarily
    majority_attr <- names(tab)[which.max(tab)]
    neighbor_majority[ego_name] <- majority_attr
  }
}

# Proportion of nodes whose majority neighbor attribute is "right-leaning" or "left-leaning"
majority_table <- table(neighbor_majority, useNA="no")
majority_prop <- majority_table / sum(majority_table)

# Printing the result 
cat("\nRelative popularity among neighbors (majority illusion measure):\n")
print(majority_prop)

# Comparing network-level proportion vs. neighbor-majority proportion
cat("\nIf the proportion of 'right-leaning' as majority among neighbors is much higher than global, there is a majority illusion.\n")