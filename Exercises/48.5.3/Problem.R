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

# Write here the solution