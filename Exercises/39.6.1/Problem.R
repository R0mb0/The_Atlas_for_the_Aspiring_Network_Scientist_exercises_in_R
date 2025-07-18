# The network at http://www.networkatlas.eu/exercises/39/
# 1/data.txt is bipartite. Project it into unipartite and find five
# communities with the Girvan-Newman edge betweenness algorithm
# (repeat for both node types, so you find a total of ten
# communities). What is the NMI with the partition proposed at
# http://www.networkatlas.eu/exercises/39/1/nodes.txt?


#__The data for this exercise is bad. How can you understand this? ________

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

# Inferring bipartite sets using the first 60 rows
N <- 60
set1 <- unique(edges$from[1:N])
set2 <- unique(edges$to[1:N])
set1 <- setdiff(set1, set2)
set2 <- setdiff(set2, set1)

# Filtering edges so that only between set1 and set2 remain
edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))

# Building the bipartite graph
g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
V(g)$type <- V(g)$name %in% set1

# Projecting the bipartite graph
proj <- bipartite_projection(g)
g1 <- proj$proj1
g2 <- proj$proj2

# Loading the ground truth communities
gt <- read.table(here("nodes.txt"), header=TRUE)
gt_comm <- as.character(gt$truecomm)
names(gt_comm) <- as.character(gt$node)

# Write here the solution