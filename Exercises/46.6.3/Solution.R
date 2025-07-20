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

# Solution 

# Removing possible NA edges between communities
community_edges <- community_edges[complete.cases(community_edges),]

# Building the community-level graph from mapped diffusion edges
community_graph <- graph_from_edgelist(community_edges, directed = TRUE)

# Checking if the community graph is strongly connected
cat("Checking if the community graph is strongly connected\n")
print(is.connected(community_graph, mode = "strong"))