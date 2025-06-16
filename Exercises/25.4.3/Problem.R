# Calculate precision, recall, and F1-score for the four link predictors
# as used in the previous question. Set up as cutoff point the nineti-
# eth percentile, meaning that you predict a link only for the highest
# ten percent of the scores in each classifier. Which method performs
# best according to these measures? (Note: when scoring with the
# scikit-learn function, remember that this is a binary prediction
# task)

library(igraph)
library(caret)

########################### Helper functions ###################################

# Predictor functions
preferential_attachment <- function(g, v1, v2) {
  deg <- degree(g)
  deg[v1] * deg[v2]
}
jaccard_score <- function(g, v1, v2) {
  n1 <- neighbors(g, v1)
  n2 <- neighbors(g, v2)
  intersect_len <- length(intersect(n1, n2))
  union_len <- length(union(n1, n2))
  if (union_len == 0) return(0) else return(intersect_len / union_len)
}
adamic_adar_score <- function(g, v1, v2) {
  n1 <- neighbors(g, v1)
  n2 <- neighbors(g, v2)
  comm <- intersect(n1, n2)
  if (length(comm) == 0) return(0)
  sum(1 / log(degree(g, comm)))
}
resource_allocation_score <- function(g, v1, v2) {
  n1 <- neighbors(g, v1)
  n2 <- neighbors(g, v2)
  comm <- intersect(n1, n2)
  if (length(comm) == 0) return(0)
  sum(1 / degree(g, comm))
}
####################### End Helper functions ###################################

# Reading the data and building the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
edges[] <- lapply(edges, as.character)
g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

all_nodes <- V(g_full)$name

# Write here the solution