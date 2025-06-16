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

# Write here the solution