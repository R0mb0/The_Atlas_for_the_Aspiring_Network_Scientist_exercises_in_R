# Compare the k-clique results with the coverage in http://www.
# networkatlas.eu/exercises/38/2/comms.txt, by using any variation
# of overlapping NMI from https://github.com/aaronmcdaid/
# Overlapping-NMI. For which value of k do you get the best performance?

library(here)
library(igraph)

# Defining the k_clique_communities function for finding k-clique communities
k_clique_communities <- function(graph, k) {
  all_cliques <- cliques(graph, min = k, max = k)
  if (length(all_cliques) == 0) return(list())
  clique_graph <- make_empty_graph(n = length(all_cliques))
  for (i in seq_along(all_cliques)) {
    for (j in seq_len(i-1)) {
      if (length(intersect(all_cliques[[i]], all_cliques[[j]])) == (k-1)) {
        clique_graph <- add_edges(clique_graph, c(i, j))
      }
    }
  }
  comps <- components(clique_graph)
  communities <- lapply(seq_len(comps$no), function(comp_id) {
    idx <- which(comps$membership == comp_id)
    unique(unlist(all_cliques[idx]))
  })
  lapply(communities, function(x) V(graph)$name[x])
}

source(here("OverlappingNMI.R"))

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution