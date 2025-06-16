# Compare the top ten edges predicted for the previous question
# with the ones predicted by the jaccard, Adamic-Adar, and resource
# allocation indexes.

library(here)
library(igraph)

########################### Helper functions ###################################
jaccard_similarity <- function(graph, v1, v2) {
  n1 <- neighbors(graph, v1)
  n2 <- neighbors(graph, v2)
  intersect_len <- length(intersect(n1, n2))
  union_len <- length(union(n1, n2))
  if (union_len == 0) 0 else intersect_len / union_len
}

adamic_adar_similarity <- function(graph, v1, v2) {
  n1 <- neighbors(graph, v1)
  n2 <- neighbors(graph, v2)
  comm <- intersect(n1, n2)
  if (length(comm) == 0) return(0)
  sum(1 / log(degree(graph, comm)))
}

resource_allocation_index <- function(graph, v1, v2) {
  n1 <- neighbors(graph, v1)
  n2 <- neighbors(graph, v2)
  comm <- intersect(n1, n2)
  if (length(comm) == 0) return(0)
  sum(1 / degree(graph, comm))
}
####################### End Helper functions ###################################

# Reading edge list
edges <- read.table("data.txt", header=FALSE)
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Solution 

# All possible node pairs not in the graph
all_nodes <- V(g)$name
all_pairs <- t(combn(all_nodes, 2))
non_edges <- all_pairs[!apply(all_pairs, 1, function(pair) are.connected(g, pair[1], pair[2])), , drop=FALSE]

# Preferential Attachment
deg <- degree(g)
pa_scores <- apply(non_edges, 1, function(pair) deg[pair[1]] * deg[pair[2]])

# Jaccard
jaccard_scores <- apply(non_edges, 1, function(pair) {
  jaccard_similarity(g, pair[1], pair[2])
})

# Adamic-Adar
adamic_adar_scores <- apply(non_edges, 1, function(pair) {
  adamic_adar_similarity(g, pair[1], pair[2])
})

# Resource Allocation
ra_scores <- apply(non_edges, 1, function(pair) {
  resource_allocation_index(g, pair[1], pair[2])
})

get_top10 <- function(pairs, scores) {
  idx <- order(scores, decreasing=TRUE)[1:10]
  data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx])
}

top10_pa <- get_top10(non_edges, pa_scores)
top10_jaccard <- get_top10(non_edges, jaccard_scores)
top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores)
top10_ra <- get_top10(non_edges, ra_scores)

cat("Top 10 Preferential Attachment:\n"); print(top10_pa)
cat("\nTop 10 Jaccard:\n"); print(top10_jaccard)
cat("\nTop 10 Adamic-Adar:\n"); print(top10_adamic_adar)
cat("\nTop 10 Resource Allocation:\n"); print(top10_ra)

################### Optional: seeing overlap ###################################

cat("\nOverlap (node1, node2) between indices:\n")
cat(sprintf("PA & Jaccard: %d\n", nrow(merge(top10_pa, top10_jaccard, by=c("node1","node2")))))
cat(sprintf("PA & Adamic-Adar: %d\n", nrow(merge(top10_pa, top10_adamic_adar, by=c("node1","node2")))))
cat(sprintf("PA & RA: %d\n", nrow(merge(top10_pa, top10_ra, by=c("node1","node2")))))
cat(sprintf("Jaccard & Adamic-Adar: %d\n", nrow(merge(top10_jaccard, top10_adamic_adar, by=c("node1","node2")))))
cat(sprintf("Jaccard & RA: %d\n", nrow(merge(top10_jaccard, top10_ra, by=c("node1","node2")))))
cat(sprintf("Adamic-Adar & RA: %d\n", nrow(merge(top10_adamic_adar, top10_ra, by=c("node1","node2")))))