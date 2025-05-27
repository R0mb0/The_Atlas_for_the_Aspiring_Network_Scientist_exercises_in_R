# What is the average reciprocity in the network used in the previous
# question? How many nodes have a reciprocity of zero?

library(here)
library(igraph)

# Reading the data 
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)

# Solution

# Calculating the Average reciprocity
avg_reciprocity <- reciprocity(g)
cat(sprintf("Average reciprocity of the network: %.3f\n", avg_reciprocity))

# Calculating the Reciprocity per node
node_recip <- reciprocity(g, mode="ratio") # returning a vector, one per node

# Calculating How many nodes have a reciprocity of zero?
num_zero_recip_nodes <- sum(node_recip == 0)
cat(sprintf("Number of nodes with reciprocity zero: %d\n", num_zero_recip_nodes))

################################################################################
# Optional - printing those nodes:

zero_recip_nodes <- V(g)$name[node_recip == 0]
cat("Nodes with reciprocity zero:\n")
print(zero_recip_nodes)
################################################################################