# Calculate the structural similarities of all pairs of nodes for all
# pairs of networks used in the previous question. Derive a network
# similarity value by averaging the node-node similarities. Since
# the networks are aligned, the node-node similarity is the Jaccard
# coefficient of their neighbor sets, and you should only calculate
# them for pairs of nodes with the same id. Which pair of networks
# are more similar to each other?

library(here)
library(igraph)

# Loading the edge list and building the graph for data1.txt
g1 <- read.table(here("data1.txt"))
g1 <- as.matrix(g1)
g1_char <- apply(g1, 2, as.character)
graph1 <- graph_from_edgelist(g1_char, directed = FALSE)

# Loading the edge list and building the graph for data2.txt
g2 <- read.table(here("data2.txt"))
g2 <- as.matrix(g2)
g2_char <- apply(g2, 2, as.character)
graph2 <- graph_from_edgelist(g2_char, directed = FALSE)

# Loading the edge list and building the graph for data3.txt
g3 <- read.table(here("data3.txt"))
g3 <- as.matrix(g3)
g3_char <- apply(g3, 2, as.character)
graph3 <- graph_from_edgelist(g3_char, directed = FALSE)

# Solution 

# Getting all node ids as characters
all_ids <- as.character(sort(unique(c(V(graph1)$name, V(graph2)$name, V(graph3)$name))))

# Defining a function for calculating Jaccard similarity
jaccard_sim <- function(neigh1, neigh2) {
  if(length(neigh1) == 0 & length(neigh2) == 0) return(1)
  intersect_len <- length(intersect(neigh1, neigh2))
  union_len <- length(union(neigh1, neigh2))
  if(union_len == 0) return(1)
  return(intersect_len / union_len)
}

# Calculating node-node similarities for each pair of graphs
# Calculating similarities between graph1 and graph2
sim12 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
  n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
  sim12[i] <- jaccard_sim(as.character(n1$name), as.character(n2$name))
}
network_sim12 <- mean(sim12)

# Calculating similarities between graph1 and graph3
sim13 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
  n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
  sim13[i] <- jaccard_sim(as.character(n1$name), as.character(n3$name))
}
network_sim13 <- mean(sim13)

# Calculating similarities between graph2 and graph3
sim23 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
  n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
  sim23[i] <- jaccard_sim(as.character(n2$name), as.character(n3$name))
}
network_sim23 <- mean(sim23)

# Printing the network similarity values
print(paste("Network similarity between 1 and 2:", network_sim12))
print(paste("Network similarity between 1 and 3:", network_sim13))
print(paste("Network similarity between 2 and 3:", network_sim23))

# Printing which pair is most similar
if(network_sim12 >= network_sim13 & network_sim12 >= network_sim23){
  print("Network 1 and Network 2 are the most similar.")
} else if(network_sim13 >= network_sim12 & network_sim13 >= network_sim23){
  print("Network 1 and Network 3 are the most similar.")
} else{
  print("Network 2 and Network 3 are the most similar.")
}