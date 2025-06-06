# Calculate the k-core decomposition of the network in http://www.
# networkatlas.eu/exercises/14/7/data.txt. What’s the highest
# core number in the network? How many nodes are part of the
# maximum core?

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=FALSE)

# Solution 

core_numbers <- coreness(g)
max_core <- max(core_numbers)
num_max_core_nodes <- sum(core_numbers == max_core)

cat("Highest core number (max k):", max_core, "\n")
cat("Number of nodes in the maximum core:", num_max_core_nodes, "\n")
cat("Nodes in the maximum core:\n")
print(V(g)[core_numbers == max_core])