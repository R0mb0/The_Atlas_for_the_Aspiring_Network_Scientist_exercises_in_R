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

# Solution 

# Removing weights for clique percolation
g_unweighted <- delete_edge_attr(g, "weight")

# Loading the ground truth communities from comms.txt
comms_lines <- readLines(here("comms.txt"))
gt_communities <- lapply(comms_lines, function(line) strsplit(line, " ")[[1]])
gt_communities <- lapply(gt_communities, as.character)

# Defining a function for extracting k-clique communities as lists of character vectors
get_kc_comms <- function(graph, k) {
  kc <- k_clique_communities(graph, k)
  lapply(kc, as.character)
}

# Initializing a results data frame
results <- data.frame(k=integer(), nmi=numeric())

# Calculating the NMI for k = 3, 4, 5
for (k in 3:5) {
  cat(sprintf("Calculating for k = %d\n", k))
  detected <- get_kc_comms(g_unweighted, k)
  nmi_value <- NMI(gt_communities, detected)
  results <- rbind(results, data.frame(k=k, nmi=nmi_value))
  cat(sprintf("k = %d | NMI = %.4f\n", k, nmi_value))
}

cat("\nSummary of k-clique NMI results:\n")
print(results, row.names = FALSE)

best_k <- results$k[which.max(results$nmi)]
cat(sprintf("\nBest performance for k = %d (NMI = %.4f)\n", best_k, max(results$nmi)))