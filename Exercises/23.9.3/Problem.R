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

# Write here the solution