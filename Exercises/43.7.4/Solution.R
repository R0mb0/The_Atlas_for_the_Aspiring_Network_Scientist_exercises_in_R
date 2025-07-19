# Use the Word2Vec embeddings reduced to 2D with tSNE you
# found in the previous exercise as a link prediction score (if Zu and
# Zv are node embeddings, then the score for edge u, v is ZuT Zv ).
# Draw the ROC curve of your predictions, assuming that the true
# new edges are the ones you can find in http://www.networkatlas.
# eu/exercises/43/4/newedges.txt.

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
score <- function(u, v, emb) {
  sum(emb[u, c("V1", "V2")] * emb[v, c("V1", "V2")])
}
test_edges$score <- mapply(score, test_edges$u, test_edges$v, MoreArgs = list(emb = embedding_2d))

# Drawing the ROC curve
roc_obj <- roc(test_edges$label, test_edges$score)
plot(roc_obj, main = "ROC Curve for Link Prediction (t-SNE embeddings)")
cat("AUC:", auc(roc_obj), "\n")