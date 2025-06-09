# Generate a connected caveman graph with 10 cliques, each with
# 10 nodes. Generate a small world graph with 100 nodes, each
# connected to 8 of their neighbors. Add shortcuts for each edge
# with probability of .05. The two graphs have approximately the
# same number of edges. Compare their clustering coefficients and
# their average path lengths.

library(here)
library(igraph)

##################### Making graphs #####################
# g_cave <- make_connected_caveman(10, 10) # sostitute of this line

# Parameters
num_cliques <- 10
clique_size <- 10

# Create empty graph
g_cave <- make_empty_graph(n = 0, directed = FALSE)

# Add cliques one by one
for (i in 0:(num_cliques-1)) {
  # Each clique's nodes
  nodes <- (i*clique_size + 1):((i+1)*clique_size)
  clique <- make_full_graph(clique_size)
  # Relabel the clique to correct node numbers
  clique <- set_vertex_attr(clique, "name", value=as.character(nodes))
  # Union with the main graph
  g_cave <- g_cave %u% clique
}

# Connect each clique to the next by rewiring one edge
for (i in 1:(num_cliques-1)) {
  g_cave <- add_edges(g_cave, c(i*clique_size, i*clique_size + 1))
}

# Last graph 
g_sw <- sample_smallworld(dim=1, size=100, nei=4, p=0.05)

#####################               #####################

# Write here the solution