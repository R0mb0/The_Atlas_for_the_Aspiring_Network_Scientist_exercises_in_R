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

# Solution

# Detecting communities
com_lp <- cluster_label_prop(g)
com_fg <- cluster_fast_greedy(g)

mod_lp <- modularity(com_lp)
mod_fg <- modularity(com_fg)

cat("Label Propagation modularity:", mod_lp, "\n")
cat("Fast Greedy modularity:", mod_fg, "\n\n")

# Getting membership vectors
memb_lp <- membership(com_lp)
memb_fg <- membership(com_fg)

# For each algorithm, for each community, compute metrics
algorithms <- list(LabelPropagation=memb_lp, FastGreedy=memb_fg)
for (alg in names(algorithms)) {
  membership <- algorithms[[alg]]
  cat(sprintf("\n--- %s ---\n", alg))
  comm_ids <- sort(unique(membership))
  for (cid in comm_ids) {
    comm_nodes <- names(membership)[membership == cid]
    cs <- cut_size(g, comm_nodes)
    cond <- conductance(g, comm_nodes)
    ncs <- normalized_cut_size(g, comm_nodes)
    cat(sprintf("Community %d: size=%d, cut_size=%.2f, conductance=%.4f, normalized_cut_size=%.4f\n",
                cid, length(comm_nodes), cs, cond, ncs))
  }
}