# Fuse the three networks together to produce a consensus network.
# You can keep an edge in the consensus network only if it appears
# in two out of three networks – assume that their are aligned and
# that nodes with the same id are the same node.

library(here)
library(igraph)

# Loading the edge lists and building the graphs
g1 <- read.table(here("data1.txt"))
g1 <- as.matrix(g1)
g1_char <- apply(g1, 2, as.character)
graph1 <- graph_from_edgelist(g1_char, directed = FALSE)

g2 <- read.table(here("data2.txt"))
g2 <- as.matrix(g2)
g2_char <- apply(g2, 2, as.character)
graph2 <- graph_from_edgelist(g2_char, directed = FALSE)

g3 <- read.table(here("data3.txt"))
g3 <- as.matrix(g3)
g3_char <- apply(g3, 2, as.character)
graph3 <- graph_from_edgelist(g3_char, directed = FALSE)

# Write here the solution 