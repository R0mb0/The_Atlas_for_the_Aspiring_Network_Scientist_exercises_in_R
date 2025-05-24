# Write the code to perform a random walk of arbitrary length on
# the network in http://www.networkatlas.eu/exercises/10/1/
# data.txt.

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# For printing all node's name
#print(V(g)$name)

################################################################################
# Optional: plotting the graph

plot(g,
     vertex.size=3,
     vertex.label=NA,
     edge.arrow.size=0.3,
     main="Network Graph from data.txt")

################################################################################

# Parameters for the random walk
walk_length <- 100 # Setting walk length
start_node_name <- "100" # Setting start node name

# Checking if the node's name exist 
start_node <- which(V(g)$name == start_node_name)

if (length(start_node) == 0) {
  stop(paste("Node", start_node_name, "not found in the network!"))
}

# Write here the solution 