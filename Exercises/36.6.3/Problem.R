# Repeat exercise 1, but now evaluate the difference in performance
# of the two community discovery algorithms by means of conduc-
# tance, cut size, and normalized cut size.

library(here)
library(igraph)

#================== Helper functions for metrics ==================
conductance <- function(g, comm_nodes) {
  # Number of edges leaving community / min(total degree in/out)
  in_set <- comm_nodes
  out_set <- setdiff(V(g)$name, comm_nodes)
  cut_edges <- ecount(induced_subgraph(g, c(in_set, out_set))) - ecount(induced_subgraph(g, in_set)) - ecount(induced_subgraph(g, out_set))
  degree_in <- sum(degree(g, v=in_set))
  degree_out <- sum(degree(g, v=out_set))
  if (min(degree_in, degree_out) > 0) {
    return(cut_edges / min(degree_in, degree_out))
  } else {
    return(NA)
  }
}

cut_size <- function(g, comm_nodes) {
  # Number of edges with one endpoint in comm_nodes, one outside
  cut_edges <- 0
  for (v in comm_nodes) {
    for (n in neighbors(g, v)$name) {
      if (!(n %in% comm_nodes)) {
        cut_edges <- cut_edges + 1
      }
    }
  }
  # Each edge counted twice, so divide by 2
  return(cut_edges / 2)
}

normalized_cut_size <- function(g, comm_nodes) {
  cs <- cut_size(g, comm_nodes)
  deg <- sum(degree(g, v=comm_nodes))
  if (deg > 0) {
    return(cs / deg)
  } else {
    return(NA)
  }
}

#================== End Helper functions for metrics ==================

# Loading the edge list and build the graph
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Write here the solution