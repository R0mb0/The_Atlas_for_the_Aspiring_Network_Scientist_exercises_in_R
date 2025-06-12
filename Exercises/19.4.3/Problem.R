# Generate 50 Gn,m null versions of the network in http://www.
# networkatlas.eu/exercises/19/3/data.txt, respecting the number
# of nodes and edges. Derive the number of standard deviations
# between the observed values and the null average of clustering
# and average path length. (Consider only the largest connected
# component) Which of these two is statistically significant?

library(here)
library(igraph)

# Reading the data and creating the graph 
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Write here the solution 