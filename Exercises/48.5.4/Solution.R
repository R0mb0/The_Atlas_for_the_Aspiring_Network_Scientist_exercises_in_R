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

# Solution 

# Getting all edges as sorted character pairs
edges1 <- apply(g1_char, 1, function(x) paste(sort(x), collapse = "-"))
edges2 <- apply(g2_char, 1, function(x) paste(sort(x), collapse = "-"))
edges3 <- apply(g3_char, 1, function(x) paste(sort(x), collapse = "-"))

# Combining all edges to count their occurrences
all_edges <- c(edges1, edges2, edges3)
edge_table <- table(all_edges)

# Keeping edges that appear in at least two networks
cons_edges <- names(edge_table)[edge_table >= 2]

# Splitting edge names back into node pairs for the consensus edge list
cons_edge_list <- t(sapply(cons_edges, function(e) unlist(strsplit(e, "-"))))

# Building the consensus graph
cons_graph <- graph_from_edgelist(cons_edge_list, directed = FALSE)

# Printing the consensus graph summary
print(cons_graph)