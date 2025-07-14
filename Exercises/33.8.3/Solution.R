# The arborescence algorithm is simple: condense the graph to
# remove the strongly connected components and then remove
# random incoming edges from all nodes remaining with in-degree
# larger than one, until all nodes have in-degree of one or zero.
# Implement the algorithm and calculate the arborescence score.

library(here)
library(igraph)

# Loading directed edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = TRUE)
original_edge_count <- gsize(g)

# Solution

# Condensing the graph by collapsing SCCs
scc <- components(g, mode = "strong")
# Each SCC will become a single node; build a new edge list
map <- scc$membership
from_scc <- map[as.character(edges$from)]
to_scc <- map[as.character(edges$to)]
condensed_edges <- unique(data.frame(from = from_scc, to = to_scc))
condensed_edges <- condensed_edges[condensed_edges$from != condensed_edges$to, ]
g_c <- graph_from_data_frame(condensed_edges, directed = TRUE,
                             vertices = as.character(1:max(map)))

# Prune incoming edges for nodes with in-degree > 1
repeat {
  indegs <- degree(g_c, mode = "in")
  nodes_to_prune <- which(indegs > 1)
  if (length(nodes_to_prune) == 0) break
  for (v in nodes_to_prune) {
    # Getting incoming edges to this node
    inc_edges <- incident(g_c, v, mode = "in")
    # Randomly keep 1 incoming edge:
    if (length(inc_edges) > 1) {
      edges_to_remove <- sample(inc_edges, length(inc_edges) - 1)
      g_c <- delete_edges(g_c, edges_to_remove)
    }
  }
}

arborescence_edge_count <- gsize(g_c)

# Arborescence score
arborescence_score <- arborescence_edge_count / original_edge_count

# Printing the results
cat(sprintf("Arborescence score: %.4f\n", arborescence_score))
cat(sprintf("Original number of edges: %d\n", original_edge_count))
cat(sprintf("Edges in arborescence: %d\n", arborescence_edge_count))