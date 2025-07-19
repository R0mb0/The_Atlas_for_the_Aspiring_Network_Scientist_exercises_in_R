# Is the AUC you get from the previous question better or worse
# than the one you’d get from a classical link prediction like Jaccard,
# Resource Allocation, Preferential Attachment, or Adamic-Adar?

library(here)
library(data.table)
library(igraph)
library(wordVectors)
library(Rtsne)
library(ggplot2)
library(pROC)

# Loading the edge list and building the graph
edges <- fread(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

# Getting the node names
nodes <- V(g)$name

# This is a idea of solution 

# Performing random walks
set.seed(42)
walk_length <- 6
n_walks <- 10000
walks <- vector("list", n_walks)
for (i in seq_len(n_walks)) {
  start_node <- sample(nodes, 1)
  walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
  walks[[i]] <- as.character(walk)
}

# Saving the walks
walks_char <- sapply(walks, paste, collapse = " ")
walks_file <- here("walks.txt")
writeLines(walks_char, walks_file)

# Training Word2Vec model with d = 32
embedding_file <- here("walks.bin")
train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)

# Loading the embeddings
embeddings <- read.vectors(embedding_file)
nodes_in_embedding <- rownames(embeddings)
X <- embeddings[nodes_in_embedding, ]

# Reducing to two dimensions using t-SNE
set.seed(42)
tsne_result <- Rtsne(as.matrix(X), dims = 2)
embedding_2d <- as.data.frame(tsne_result$Y)
embedding_2d$node <- nodes_in_embedding
rownames(embedding_2d) <- embedding_2d$node

# Loading the new edges for link prediction
new_edges <- fread(here("newedges.txt"), header = FALSE)
colnames(new_edges) <- c("u", "v")
new_edges$u <- as.character(new_edges$u)
new_edges$v <- as.character(new_edges$v)

# Preparing positive samples (new edges)
positive_edges <- new_edges[
  new_edges$u %in% embedding_2d$node & new_edges$v %in% embedding_2d$node, ]

# Sampling negative edges (node pairs not connected and not in newedges)
existing_edges <- as.data.table(get.edgelist(g))
existing_edges$V1 <- as.character(existing_edges$V1)
existing_edges$V2 <- as.character(existing_edges$V2)

all_possible <- CJ(u=embedding_2d$node, v=embedding_2d$node)[u < v]
all_possible <- all_possible[!paste(u, v) %in% paste(existing_edges$V1, existing_edges$V2)]
all_possible <- all_possible[!paste(u, v) %in% paste(positive_edges$u, positive_edges$v)]

set.seed(42)
negative_edges <- all_possible[sample(.N, nrow(positive_edges))]

# Combining positive and negative edges for predictions
test_edges <- rbind(
  data.table(u = positive_edges$u, v = positive_edges$v, label = 1),
  data.table(u = negative_edges$u, v = negative_edges$v, label = 0)
)

# Computing link prediction scores using 2D t-SNE embeddings
score_tsne <- function(u, v, emb) {
  sum(emb[u, c("V1", "V2")] * emb[v, c("V1", "V2")])
}
test_edges$score_tsne <- mapply(score_tsne, test_edges$u, test_edges$v, MoreArgs = list(emb = embedding_2d))

# Calculating AUC for t-SNE embeddings
roc_tsne <- roc(test_edges$label, test_edges$score_tsne)
auc_tsne <- auc(roc_tsne)

# Calculating Jaccard scores
test_edges$jaccard <- mapply(function(u, v) {
  neighbors_u <- neighbors(g, u)
  neighbors_v <- neighbors(g, v)
  length(intersect(neighbors_u, neighbors_v)) / length(union(neighbors_u, neighbors_v))
}, test_edges$u, test_edges$v)
roc_jaccard <- roc(test_edges$label, test_edges$jaccard)
auc_jaccard <- auc(roc_jaccard)

# Calculating Resource Allocation scores
test_edges$ra <- mapply(function(u, v) {
  neighbors_u <- neighbors(g, u)
  neighbors_v <- neighbors(g, v)
  common <- intersect(neighbors_u, neighbors_v)
  sum(1 / degree(g, common))
}, test_edges$u, test_edges$v)
roc_ra <- roc(test_edges$label, test_edges$ra)
auc_ra <- auc(roc_ra)

# Calculating Preferential Attachment scores
test_edges$pa <- mapply(function(u, v) {
  degree(g, u) * degree(g, v)
}, test_edges$u, test_edges$v)
roc_pa <- roc(test_edges$label, test_edges$pa)
auc_pa <- auc(roc_pa)

# Calculating Adamic-Adar scores
test_edges$aa <- mapply(function(u, v) {
  neighbors_u <- neighbors(g, u)
  neighbors_v <- neighbors(g, v)
  common <- intersect(neighbors_u, neighbors_v)
  sum(1 / log(degree(g, common)))
}, test_edges$u, test_edges$v)
roc_aa <- roc(test_edges$label, test_edges$aa)
auc_aa <- auc(roc_aa)

# Plotting ROC curves
plot(roc_tsne, col="red", main="ROC Curves for Link Prediction Methods")
plot(roc_jaccard, col="blue", add=TRUE)
plot(roc_ra, col="green", add=TRUE)
plot(roc_pa, col="purple", add=TRUE)
plot(roc_aa, col="orange", add=TRUE)
legend("bottomright",
       legend=c(
         paste("t-SNE Embeddings (AUC =", round(auc_tsne,3), ")"),
         paste("Jaccard (AUC =", round(auc_jaccard,3), ")"),
         paste("Resource Allocation (AUC =", round(auc_ra,3), ")"),
         paste("Pref. Attachment (AUC =", round(auc_pa,3), ")"),
         paste("Adamic-Adar (AUC =", round(auc_aa,3), ")")
       ),
       col=c("red","blue","green","purple","orange"), lwd=2, cex=0.9
)

cat("AUC t-SNE Embeddings:", auc_tsne, "\n")
cat("AUC Jaccard:", auc_jaccard, "\n")
cat("AUC Resource Allocation:", auc_ra, "\n")
cat("AUC Preferential Attachment:", auc_pa, "\n")
cat("AUC Adamic-Adar:", auc_aa, "\n")