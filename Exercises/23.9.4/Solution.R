# Use your code to calculate the hitting time (from exercise 3 of
# Chapter 11) to implement a hit time link predictor – use the com-
# mute time since the network is undirected. Compare it with the
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

# Reading the data and building the graph 
edges <- read.table("data.txt", header=FALSE)
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

all_nodes <- V(g)$name
n <- length(all_nodes)
A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))

# Solution 

# Computing hitting time and commute time matrices via Laplacian pseudoinverse
D <- diag(rowSums(A))
L <- D - A

# Computing Moore-Penrose pseudoinverse with eigen-decomposition (L is symmetric, positive semi-definite)
eig <- eigen(L)
# Setting a threshold for zero eigenvalues
tol <- 1e-10
inv_eigvals <- ifelse(abs(eig$values) < tol, 0, 1 / eig$values)
Lplus <- eig$vectors %*% diag(inv_eigvals) %*% t(eig$vectors)

# The commute time between nodes i and j is: C_ij = vol(G) * (L+_ii + L+_jj - 2*L+_ij)
volG <- sum(A)
commute_time_mat <- matrix(NA, n, n)
for(i in 1:n) {
  for(j in 1:n) {
    commute_time_mat[i, j] <- volG * (Lplus[i,i] + Lplus[j,j] - 2 * Lplus[i,j])
  }
}
rownames(commute_time_mat) <- all_nodes
colnames(commute_time_mat) <- all_nodes

# Finding all potential links (non-edges)
all_pairs <- t(combn(all_nodes, 2))
non_edges <- all_pairs[!apply(all_pairs, 1, function(pair) are.connected(g, pair[1], pair[2])), , drop=FALSE]

# Commuting time predictor: lower = more likely
commute_times <- apply(non_edges, 1, function(pair) {
  commute_time_mat[pair[1], pair[2]]
})

get_top10 <- function(pairs, scores, decreasing=TRUE) {
  idx <- order(scores, decreasing=decreasing)[1:10]
  data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx], stringsAsFactors=FALSE)
}

top10_commute <- get_top10(non_edges, commute_times, decreasing=FALSE) # Lower is better

# Other predictors for comparison
deg <- degree(g)
pa_scores <- apply(non_edges, 1, function(pair) deg[pair[1]] * deg[pair[2]])
top10_pa <- get_top10(non_edges, pa_scores, decreasing=TRUE)

jaccard_scores <- apply(non_edges, 1, function(pair) jaccard_similarity(g, pair[1], pair[2]))
top10_jaccard <- get_top10(non_edges, jaccard_scores, decreasing=TRUE)

adamic_adar_scores <- apply(non_edges, 1, function(pair) adamic_adar_similarity(g, pair[1], pair[2]))
top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores, decreasing=TRUE)

ra_scores <- apply(non_edges, 1, function(pair) resource_allocation_index(g, pair[1], pair[2]))
top10_ra <- get_top10(non_edges, ra_scores, decreasing=TRUE)

# Mutual Information
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
top10_mi <- get_top10(non_edges, mi_scores, decreasing=TRUE)

# Printing Top 10 for all predictors
cat("Top 10 Commute Time (lowest values):\n"); print(top10_commute)
cat("\nTop 10 Preferential Attachment:\n"); print(top10_pa)
cat("\nTop 10 Jaccard:\n"); print(top10_jaccard)
cat("\nTop 10 Adamic-Adar:\n"); print(top10_adamic_adar)
cat("\nTop 10 Resource Allocation:\n"); print(top10_ra)
cat("\nTop 10 Mutual Information:\n"); print(top10_mi)

# Overlap comparison
compare_top10 <- function(df1, df2, name1, name2) {
  m <- merge(df1, df2, by=c("node1","node2"))
  cat(sprintf("\nOverlap between %s and %s: %d edges\n", name1, name2, nrow(m)))
  if (nrow(m) > 0) print(m[,c("node1","node2")])
}

cat("\n--- Overlaps with Commute Time (Hitting Time) ---\n")
compare_top10(top10_commute, top10_pa, "Commute Time", "Preferential Attachment")
compare_top10(top10_commute, top10_jaccard, "Commute Time", "Jaccard")
compare_top10(top10_commute, top10_adamic_adar, "Commute Time", "Adamic-Adar")
compare_top10(top10_commute, top10_ra, "Commute Time", "Resource Allocation")
compare_top10(top10_commute, top10_mi, "Commute Time", "Mutual Information")