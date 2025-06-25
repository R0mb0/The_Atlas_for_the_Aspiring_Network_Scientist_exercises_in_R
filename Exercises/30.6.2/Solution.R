# What is the assortativity of the leaning attribute?

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

# Converting leaning to a numeric factor for assortativity calculation
leaning_fac <- as.numeric(as.factor(V(g)$leaning))

# Calculating assortativity for the leaning attribute
assort <- assortativity_nominal(g, leaning_fac, directed=FALSE)

# Printing the result
cat(sprintf("Assortativity of the leaning attribute: %.4f\n", assort))