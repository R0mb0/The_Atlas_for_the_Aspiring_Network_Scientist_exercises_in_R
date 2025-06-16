# Divide the network at http://www.networkatlas.eu/exercises/
# 25/1/data.txt into train and test sets using a ten-fold cross vali-
# dation scheme. Draw its confusion matrix after applying a jaccard
# link prediction to it. Use 0.5 as you cutoff score: scores equal to or
# higher than 0.5 are predicted to be an edge, anything lower is pre-
# dicted to be a non-edge. (Hint: make heavy use of scikit-learn
# capabilities of performing KFold divisions and building confusion
# matrices)

library(here)
library(igraph)
library(caret)
library(yardstick)

########################### Helper functions ###################################

# Function to compute Jaccard index for a pair in a given graph
jaccard_score <- function(g, v1, v2) {
  n1 <- neighbors(g, v1)
  n2 <- neighbors(g, v2)
  intersect_len <- length(intersect(n1, n2))
  union_len <- length(union(n1, n2))
  if (union_len == 0) return(0) else return(intersect_len / union_len)
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

# For cross-validation, combine positives and sample negatives to match number 
# of positives (for balanced evaluation)
set.seed(42)
neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
data_cv <- rbind(
  data.frame(pos_edges, label=1),
  data.frame(neg_edges, label=0)
)
data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle

# 10-fold cross-validation
folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)

# Running cross-validation and collect predictions
true_labels <- c()
pred_labels <- c()

for(i in seq_along(folds)) {
  test_idx <- folds[[i]]
  train_edges <- data_cv[-test_idx, ]
  test_edges <- data_cv[test_idx, ]
  
  # Building training graph
  train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
  
  # Predicting for test set
  for(j in 1:nrow(test_edges)) {
    v1 <- test_edges$from[j]
    v2 <- test_edges$to[j]
    score <- jaccard_score(train_g, v1, v2)
    pred <- as.integer(score >= 0.5)
    true_labels <- c(true_labels, test_edges$label[j])
    pred_labels <- c(pred_labels, pred)
  }
}

# Confusion matrix
results <- data.frame(
  truth = factor(true_labels, levels=c(1,0)),
  prediction = factor(pred_labels, levels=c(1,0))
)
cm <- conf_mat(results, truth="truth", estimate="prediction")
print(cm)

########################## Optional plot confusion matrix ######################
autoplot(cm, type = "heatmap") + ggplot2::scale_fill_gradient(low="white", high="red")
################################################################################