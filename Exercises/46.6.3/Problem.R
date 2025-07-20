# Summarize the summary you generated answering question #1
# with the data from question #2. Do you still obtain a connected
# graph?

library(igraph)
library(here)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Detecting communities using label propagation
communities <- cluster_label_prop(g)
membership <- membership(communities)

# Loading the diffusion edge list
diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)

# Mapping diffusion edges to communities
comm_from <- membership[as.character(diffusion_edges$V1)]
comm_to <- membership[as.character(diffusion_edges$V2)]
community_edges <- cbind(comm_from, comm_to)

# Write here the solution 