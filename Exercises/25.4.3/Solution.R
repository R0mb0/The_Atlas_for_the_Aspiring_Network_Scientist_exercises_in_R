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

# Solution

# Generating all possible node pairs
all_pairs <- t(combn(all_nodes, 2))
all_edges_df <- data.frame(from=all_pairs[,1], to=all_pairs[,2], stringsAsFactors=FALSE)

# Marking which pairs are actual edges
all_edges_df$edge <- mapply(function(f, t) {
  are.connected(g_full, f, t)
}, all_edges_df$from, all_edges_df$to)

# Getting positive (edges) and negative (non-edges) samples
pos_edges <- all_edges_df[all_edges_df$edge, c("from", "to")]
neg_edges <- all_edges_df[!all_edges_df$edge, c("from", "to")]

# For cross-validation, combine positives and sample negatives to match 
# number of positives (for balanced evaluation)
set.seed(42)
neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
data_cv <- rbind(
  data.frame(pos_edges, label=1),
  data.frame(neg_edges, label=0)
)
data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle

# 10-fold cross-validation
folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)

# Running cross-validation & collect scores/labels
label_all = c()
score_pa = c()
score_jaccard = c()
score_adamic = c()
score_ra = c()

for(i in seq_along(folds)) {
  test_idx <- folds[[i]]
  train_edges <- data_cv[-test_idx, ]
  test_edges <- data_cv[test_idx, ]
  
  # Building training graph
  train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
  
  for(j in 1:nrow(test_edges)) {
    v1 <- test_edges$from[j]
    v2 <- test_edges$to[j]
    label_all <- c(label_all, test_edges$label[j])
    score_pa <- c(score_pa, preferential_attachment(train_g, v1, v2))
    score_jaccard <- c(score_jaccard, jaccard_score(train_g, v1, v2))
    score_adamic <- c(score_adamic, adamic_adar_score(train_g, v1, v2))
    score_ra <- c(score_ra, resource_allocation_score(train_g, v1, v2))
  }
}

# Appling 90th percentile cutoff for each predictor
predict_by_percentile <- function(scores, percentile=0.9) {
  cutoff <- quantile(scores, probs=percentile, na.rm=TRUE)
  as.integer(scores >= cutoff)
}

pred_pa <- predict_by_percentile(score_pa)
pred_jaccard <- predict_by_percentile(score_jaccard)
pred_adamic <- predict_by_percentile(score_adamic)
pred_ra <- predict_by_percentile(score_ra)

# Computing precision, recall, F1 for each
get_metrics <- function(truth, pred) {
  cm <- table(Prediction=pred, Truth=truth)
  TP <- sum(pred==1 & truth==1)
  FP <- sum(pred==1 & truth==0)
  FN <- sum(pred==0 & truth==1)
  precision <- ifelse(TP+FP==0, 0, TP/(TP+FP))
  recall <- ifelse(TP+FN==0, 0, TP/(TP+FN))
  f1 <- ifelse(precision+recall==0, 0, 2*precision*recall/(precision+recall))
  list(precision=precision, recall=recall, f1=f1)
}

metrics_pa <- get_metrics(label_all, pred_pa)
metrics_jaccard <- get_metrics(label_all, pred_jaccard)
metrics_adamic <- get_metrics(label_all, pred_adamic)
metrics_ra <- get_metrics(label_all, pred_ra)

# Printing results in a table
results <- data.frame(
  Predictor = c("Preferential Attachment", "Jaccard", "Adamic-Adar", "Resource Allocation"),
  Precision = c(metrics_pa$precision, metrics_jaccard$precision, metrics_adamic$precision, metrics_ra$precision),
  Recall    = c(metrics_pa$recall, metrics_jaccard$recall, metrics_adamic$recall, metrics_ra$recall),
  F1        = c(metrics_pa$f1, metrics_jaccard$f1, metrics_adamic$f1, metrics_ra$f1)
)
print(results, digits=3, row.names=FALSE)

# Which performs best?
best_idx <- which.max(results$F1)
cat(sprintf("\nBest method by F1-score: %s (F1=%.3f)\n", results$Predictor[best_idx], results$F1[best_idx]))