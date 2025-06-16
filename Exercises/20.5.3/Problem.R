# Extend your SI model to an SIS. With β = 0.2, run the model
# with µ values of 0.05, 0.1, and 0.2 on both networks used in the
# previous questions. Run the SIS model, with a random node as a
# starting Infected set, for 100 steps and plot the share of nodes in
# the Infected state. For which of these values and networks do you
# have an endemic state? How big is the set of nodes in state I com-
# pared to the number of nodes in the network? (Note, randomness
# might affect your results. Run the experiment multiple times)

library(here)
library(igraph)

# Loading data and remapping the first network 
edges1 <- read.table("data1.txt", header=FALSE)
nodes1 <- unique(c(edges1$V1, edges1$V2))
map1 <- setNames(seq_along(nodes1), nodes1)
edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)

# Loading data and remapping the second network 
edges2 <- read.table("data2.txt", header=FALSE)
nodes2 <- unique(c(edges2$V1, edges2$V2))
map2 <- setNames(seq_along(nodes2), nodes2)
edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)

# Write here the solution