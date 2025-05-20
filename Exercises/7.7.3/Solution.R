# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)
library(igraph)

# Reading your data
df <- read.table("data.txt", header=TRUE)

# Hyperedges as list: each row is a hyperedge, nonzero entries only
hyperedges <- apply(df, 1, function(row) as.numeric(row[row != 0]))

# Solution

# Here solving the third exercise question (for graph convenience)

# All unique nodes
all_nodes <- sort(unique(unlist(hyperedges)))

# Creating bipartite edge list: hyperedge node -> member node 
#(Bipartite Plot (nodes + hyperedges))
bipartite_edges <- data.frame(
  from = rep(paste0("H", seq_along(hyperedges)), lengths(hyperedges)),
  to = as.character(unlist(hyperedges))
)

#===============================================================================
#                      OPTIONAL: Creating a graph

# Building igraph object
g_bipartite <- graph_from_data_frame(bipartite_edges, directed=FALSE)
V(g_bipartite)$type <- grepl("^H", V(g_bipartite)$name)
V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "orange")

# Plot bipartite graph
plot(g_bipartite,
     layout = layout_with_fr,
     vertex.size = 26,
     vertex.label.cex=0.9,
     vertex.color=V(g_bipartite)$color,
     main = "Hypergraph as Bipartite Network\n(Skyblue: Hyperedges, Orange: Nodes)"
)
#===============================================================================

# Here solving the second exercise question

# For each hyperedge, create all possible pairs 
#(Clique Expansion Plot (Unipartite))
get_pairs <- function(nodes) if(length(nodes) < 2) NULL else t(combn(nodes, 2))
all_pairs <- do.call(rbind, lapply(hyperedges, get_pairs))
all_pairs <- unique(all_pairs)

#===============================================================================
#                      OPTIONAL: Creating a graph

# Building igraph object for unipartite graph
g_unipartite <- graph_from_edgelist(all_pairs, directed=FALSE)

# Plotting unipartite graph
plot(g_unipartite,
     layout = layout_with_fr,
     vertex.size = 28,
     vertex.label.cex=1.0,
     main = "Clique Expansion of Hypergraph"
)
#===============================================================================