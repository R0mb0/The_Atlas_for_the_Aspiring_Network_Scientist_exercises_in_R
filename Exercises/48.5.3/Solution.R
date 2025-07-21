# Calculate the graph edit distances between the networks used in
# the previous questions. Remember that the networks are aligned,
# thus you just need to iterate over nodes and compare their neigh-
# borhoods. Which pair of networks are more similar to each other?

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

# Defining a function for calculating edit distance between neighborhoods
edit_dist <- function(neigh1, neigh2) {
  diff <- setdiff(neigh1, neigh2)
  diff2 <- setdiff(neigh2, neigh1)
  return(length(diff) + length(diff2))
}

# Calculating node-wise edit distances for each pair of graphs
dist12 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
  n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
  dist12[i] <- edit_dist(as.character(n1$name), as.character(n2$name))
}
ged12 <- mean(dist12)

dist13 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
  n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
  dist13[i] <- edit_dist(as.character(n1$name), as.character(n3$name))
}
ged13 <- mean(dist13)

dist23 <- numeric(length(all_ids))
for(i in seq_along(all_ids)) {
  id <- all_ids[i]
  n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
  n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
  dist23[i] <- edit_dist(as.character(n2$name), as.character(n3$name))
}
ged23 <- mean(dist23)

# Printing the graph edit distances
print(paste("Graph edit distance between Network 1 and 2:", ged12))
print(paste("Graph edit distance between Network 1 and 3:", ged13))
print(paste("Graph edit distance between Network 2 and 3:", ged23))

# Indicating which pair is most similar
if(ged12 <= ged13 & ged12 <= ged23){
  print("Network 1 and Network 2 are the most similar.")
} else if(ged13 <= ged12 & ged13 <= ged23){
  print("Network 1 and Network 3 are the most similar.")
} else{
  print("Network 2 and Network 3 are the most similar.")
}