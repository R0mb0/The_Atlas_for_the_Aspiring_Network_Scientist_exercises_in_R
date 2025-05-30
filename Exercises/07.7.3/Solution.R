# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)
library(igraph)

# Reading the hypergraph data (each line is a hyperedge)
lines <- readLines("data.txt")
hyperedges <- lapply(lines, function(x) strsplit(x, "\\s+")[[1]])

# Solution

# Unipartiting network: clique expansion
get_pairs <- function(nodes) {
  nodes <- as.character(nodes)
  if(length(nodes) < 2) return(NULL)
  t(combn(nodes, 2))
}
all_pairs <- do.call(rbind, lapply(hyperedges, get_pairs))
all_pairs <- unique(all_pairs)

################################################################################
# Optional: creating a plot

g_unipartite <- graph_from_edgelist(all_pairs, directed = FALSE)

set.seed(42)
plot(
  g_unipartite,
  layout = layout_with_fr,
  vertex.size = 25,
  vertex.color = "orange",
  vertex.label.cex = 1.1,
  main = " Hypergraph as Unipartite Network"
)

################################################################################

# Building bipartite edge list: hyperedge node -> member node
bipartite_edges <- data.frame(
  from = rep(paste0("H", seq_along(hyperedges)), sapply(hyperedges, length)),
  to = as.character(unlist(hyperedges))
)

################################################################################
# Optional: creating a plot

g_bipartite <- graph_from_data_frame(bipartite_edges, directed = FALSE)
V(g_bipartite)$type <- grepl("^H", V(g_bipartite)$name)
V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "orange")

# Arranging bipartite layout: hyperedges (H nodes) on top row, other nodes on bottom row
hyper_nodes <- V(g_bipartite)$name[V(g_bipartite)$type]
elem_nodes <- V(g_bipartite)$name[!V(g_bipartite)$type]

layout_bipartite <- matrix(NA, nrow = vcount(g_bipartite), ncol = 2)
layout_bipartite[V(g_bipartite)$type, 1] <- seq_along(hyper_nodes)
layout_bipartite[V(g_bipartite)$type, 2] <- 1
layout_bipartite[!V(g_bipartite)$type, 1] <- match(elem_nodes, sort(elem_nodes))
layout_bipartite[!V(g_bipartite)$type, 2] <- 0

plot(
  g_bipartite,
  layout = layout_bipartite,
  vertex.size = 22,
  vertex.label.cex = 1,
  vertex.color = V(g_bipartite)$color,
  main = "Hypergraph as Bipartite Network"
)
legend(
  "topright",
  legend = c("Hyperedge", "Node"),
  col = c("skyblue", "orange"),
  pch = 19,
  pt.cex = 2,
  bty = "n"
)
################################################################################