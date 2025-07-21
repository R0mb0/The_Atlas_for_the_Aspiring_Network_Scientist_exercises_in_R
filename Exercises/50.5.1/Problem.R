# Build on top of you visualization from exercise #2 in Chapter 49.
# Assign to edges a sequential color gradient and a transparency
# proportional to the logarithm of their edge betweenness (the
# higher the edge betweenness the more opaque the edge).

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Reading the community information
node_community <- read.table(here("nodes.txt"), header = FALSE)
communities <- node_community$V2
names(communities) <- as.character(node_community$V1)

# Assigning a community to each node in the graph
all_communities <- rep(NA, vcount(g))
names(all_communities) <- V(g)$name
for (i in V(g)$name) {
  if (!is.na(communities[i])) {
    all_communities[i] <- communities[i]
  } else {
    all_communities[i] <- 0
  }
}

# Setting the community attribute for all nodes
V(g)$community <- all_communities

# Write here the solution 