# Run the same SI model on the network at http://www.networkatlas.
# eu/exercises/20/2/data.txt as well. One of the two networks is
# a Gn,p graph while the other has a power law degree distribution.
# Can you tell which is which by how much the disease takes to
# infect 80% of the network for the same starting conditions used in
# the previous question?

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