# Use the mutual information function from scikit-learn to im-
# plement a mutual information link predictor. Compare it with the
# results from the previous questions.

library(here)
library(igraph)
library(infotheo)

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

# Reading the edge list and building the graph 
edges <- read.table("data.txt", header=FALSE)
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Solution 

# Non-edges (potential links)
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

# Mutual Information
A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
mi_scores <- apply(non_edges, 1, function(pair) {
  v1 <- pair[1]
  v2 <- pair[2]
  idx1 <- which(all_nodes == v1)
  idx2 <- which(all_nodes == v2)
  # Removing self and each other from vectors
  vec1 <- A[idx1, -c(idx1, idx2)]
  vec2 <- A[idx2, -c(idx1, idx2)]
  mutinformation(factor(vec1), factor(vec2))
})

# Getting Top 10 for each method
get_top10 <- function(pairs, scores) {
  idx <- order(scores, decreasing=TRUE)[1:10]
  data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx], stringsAsFactors=FALSE)
}
top10_pa <- get_top10(non_edges, pa_scores)
top10_jaccard <- get_top10(non_edges, jaccard_scores)
top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores)
top10_ra <- get_top10(non_edges, ra_scores)
top10_mi <- get_top10(non_edges, mi_scores)

# Printing Top 10 Mutual Information
cat("Top 10 Mutual Information edges:\n")
print(top10_mi)

# Comparison: overlap and edge pairs
compare_top10 <- function(df1, df2, name1, name2) {
  m <- merge(df1, df2, by=c("node1","node2"))
  cat(sprintf("\nOverlap between %s and %s: %d edges\n", name1, name2, nrow(m)))
  if (nrow(m) > 0) print(m[,c("node1","node2")])
}

compare_top10(top10_mi, top10_pa, "Mutual Information", "Preferential Attachment")
compare_top10(top10_mi, top10_jaccard, "Mutual Information", "Jaccard")
compare_top10(top10_mi, top10_adamic_adar, "Mutual Information", "Adamic-Adar")
compare_top10(top10_mi, top10_ra, "Mutual Information", "Resource Allocation")