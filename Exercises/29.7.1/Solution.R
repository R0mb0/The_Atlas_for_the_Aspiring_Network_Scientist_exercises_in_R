# Perform a random walk sampling of the network at http://www.
# networkatlas.eu/exercises/29/1/data.txt. Sample 2,000 nodes
# (1% of the network) and all their connections (note: the sample
# will end up having more than 2,000 nodes).

library(here)
library(igraph)

# Loading the network from file
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")

# Creating the graph (assuming undirected network)
g <- graph_from_data_frame(edges, directed = FALSE)

# This should be the Solution 

# Random Walk Sampling
target_sample_size <- 2000

all_nodes <- V(g)$name
start_node <- sample(all_nodes, 1)
sampled_nodes <- c(start_node)
visited <- setNames(rep(FALSE, vcount(g)), all_nodes)
visited[start_node] <- TRUE

current_node <- start_node

while (length(sampled_nodes) < target_sample_size) {
  neighbors_vec <- neighbors(g, current_node)
  if (length(neighbors_vec) == 0) {
    # pick a new random node if stuck (isolated)
    current_node <- sample(all_nodes, 1)
  } else {
    # choose a random neighbor and extract its name
    next_vertex <- sample(neighbors_vec, 1)
    next_node <- V(g)[next_vertex]$name
    if (!visited[next_node]) {
      sampled_nodes <- c(sampled_nodes, next_node)
      visited[next_node] <- TRUE
    }
    current_node <- next_node
  }
}

# Getting all edges with at least one endpoint in sampled_nodes
sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]

# Creating the sampled subgraph
g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)

# Plotting the graph 

set.seed(42)
plot(
  g_sampled,
  vertex.size = 3,
  vertex.label = NA,
  edge.arrow.size = 0.2,
  main = sprintf("Random Walk Sampled Subgraph (%d+ nodes)", length(V(g_sampled)))
)