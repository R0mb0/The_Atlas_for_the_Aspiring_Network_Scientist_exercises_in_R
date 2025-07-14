# Perform the null model test you did for exercise 1 also for global
# reach centrality and arborescence. Which method is farther from
# the average expected hierarchy value?

library(here)
library(igraph)

# Loading the network ----
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building tha graph
g <- graph_from_data_frame(edges, directed = TRUE)
N <- vcount(g)
original_edge_count <- gsize(g)

# Solution 

# Observed Global Reach Centrality
lrc <- numeric(N)
for (v in seq_len(N)) {
  reachable <- subcomponent(g, v, mode = "out")
  lrc[v] <- (length(reachable) - 1) / (N - 1)
}
max_lrc <- max(lrc)
mean_lrc <- mean(lrc)
grc_obs <- (max_lrc - mean_lrc) / (N - 1)

# Observed Arborescence
# Condense SCCs
scc <- components(g, mode = "strong")
map <- scc$membership
from_scc <- map[as.character(edges$from)]
to_scc <- map[as.character(edges$to)]
condensed_edges <- unique(data.frame(from = from_scc, to = to_scc))
condensed_edges <- condensed_edges[condensed_edges$from != condensed_edges$to, ]
verts_obs <- unique(c(condensed_edges$from, condensed_edges$to))
g_c <- graph_from_data_frame(condensed_edges, directed = TRUE, vertices = verts_obs)

# Prune incoming edges
repeat {
  indegs <- degree(g_c, mode = "in")
  nodes_to_prune <- which(indegs > 1)
  if (length(nodes_to_prune) == 0) break
  for (v in nodes_to_prune) {
    inc_edges <- incident(g_c, v, mode = "in")
    if (length(inc_edges) > 1) {
      edges_to_remove <- sample(inc_edges, length(inc_edges) - 1)
      g_c <- delete_edges(g_c, edges_to_remove)
    }
  }
}
arbo_obs <- gsize(g_c) / original_edge_count

# Null Model: Directed Configuration Model 
in_deg <- degree(g, mode = "in")
out_deg <- degree(g, mode = "out")
grc_null <- numeric(25)
arbo_null <- numeric(25)

for(i in 1:25) {
  g_null <- sample_degseq(out_deg, in_deg, method = "fast.heur.simple")
  N_null <- vcount(g_null)
  
  # GRC for null
  lrc_null <- numeric(N_null)
  for (v in seq_len(N_null)) {
    reachable_null <- subcomponent(g_null, v, mode = "out")
    lrc_null[v] <- (length(reachable_null) - 1) / (N_null - 1)
  }
  max_lrc_null <- max(lrc_null)
  mean_lrc_null <- mean(lrc_null)
  grc_null[i] <- (max_lrc_null - mean_lrc_null) / (N_null - 1)
  
  # Arborescence for null
  scc_null <- components(g_null, mode = "strong")
  map_null <- scc_null$membership
  null_edges <- as.data.frame(ends(g_null, E(g_null)), stringsAsFactors = FALSE)
  from_scc_null <- map_null[as.character(null_edges$V1)]
  to_scc_null <- map_null[as.character(null_edges$V2)]
  condensed_edges_null <- unique(data.frame(from = from_scc_null, to = to_scc_null))
  condensed_edges_null <- condensed_edges_null[condensed_edges_null$from != condensed_edges_null$to, ]
  verts_null <- unique(c(condensed_edges_null$from, condensed_edges_null$to))
  if (nrow(condensed_edges_null) == 0) {
    # Trivial case: no edges left after condensing SCCs
    arbo_null[i] <- 0
    next
  }
  g_c_null <- graph_from_data_frame(condensed_edges_null, directed = TRUE, vertices = verts_null)
  repeat {
    indegs_null <- degree(g_c_null, mode = "in")
    nodes_to_prune_null <- which(indegs_null > 1)
    if (length(nodes_to_prune_null) == 0) break
    for (v in nodes_to_prune_null) {
      inc_edges_null <- incident(g_c_null, v, mode = "in")
      if (length(inc_edges_null) > 1) {
        edges_to_remove_null <- sample(inc_edges_null, length(inc_edges_null) - 1)
        g_c_null <- delete_edges(g_c_null, edges_to_remove_null)
      }
    }
  }
  arbo_null[i] <- gsize(g_c_null) / gsize(g_null)
}

# Z-score Calculation & Comparison
grc_z <- (grc_obs - mean(grc_null)) / sd(grc_null)
arbo_z <- (arbo_obs - mean(arbo_null)) / sd(arbo_null)

# Printing the results

cat(sprintf("Observed GRC: %.4f\n", grc_obs))
cat(sprintf("Null mean GRC: %.4f, SD: %.4f, Z-score: %.2f\n", mean(grc_null), sd(grc_null), grc_z))
cat(sprintf("Observed Arborescence: %.4f\n", arbo_obs))
cat(sprintf("Null mean Arborescence: %.4f, SD: %.4f, Z-score: %.2f\n", mean(arbo_null), sd(arbo_null), arbo_z))

if(abs(grc_z) > abs(arbo_z)) {
  cat("Global reach centrality is farther from its null model expectation.\n")
} else if(abs(arbo_z) > abs(grc_z)) {
  cat("Arborescence is farther from its null model expectation.\n")
} else {
  cat("Both are equally far from their null model expectation.\n")
}