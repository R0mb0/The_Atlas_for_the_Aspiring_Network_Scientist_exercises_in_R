# Draw the precision-recall curves of the four link predictors as used
# in the previous questions. Which of those has the highest AUC?

library(here)
library(igraph)
library(caret)
library(PRROC)

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

# For cross-validation, combine positives and sample negatives to match number of positives (for balanced evaluation)
set.seed(42)
neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
data_cv <- rbind(
  data.frame(pos_edges, label=1),
  data.frame(neg_edges, label=0)
)
data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle

# 10-fold cross-validation
folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)

# Run cross-validation & collect scores/labels
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

# Calculating PR curves and AUCs
pr_pa <- pr.curve(scores.class0=score_pa[label_all==1], scores.class1=score_pa[label_all==0], curve=TRUE)
pr_jaccard <- pr.curve(scores.class0=score_jaccard[label_all==1], scores.class1=score_jaccard[label_all==0], curve=TRUE)
pr_adamic <- pr.curve(scores.class0=score_adamic[label_all==1], scores.class1=score_adamic[label_all==0], curve=TRUE)
pr_ra <- pr.curve(scores.class0=score_ra[label_all==1], scores.class1=score_ra[label_all==0], curve=TRUE)

# Plotting PR curves
plot(pr_pa$curve[,1], pr_pa$curve[,2], type="l", col="red", lwd=2, xlab="Recall", ylab="Precision",
     main="Precision-Recall Curves: Link Predictors", xlim=c(0,1), ylim=c(0,1))
lines(pr_jaccard$curve[,1], pr_jaccard$curve[,2], col="blue", lwd=2)
lines(pr_adamic$curve[,1], pr_adamic$curve[,2], col="green", lwd=2)
lines(pr_ra$curve[,1], pr_ra$curve[,2], col="purple", lwd=2)
legend("topright", legend=c(
  sprintf("Pref. Attach. (AUC = %.3f)", pr_pa$auc.integral),
  sprintf("Jaccard (AUC = %.3f)", pr_jaccard$auc.integral),
  sprintf("Adamic-Adar (AUC = %.3f)", pr_adamic$auc.integral),
  sprintf("Resource Alloc. (AUC = %.3f)", pr_ra$auc.integral)
), col=c("red", "blue", "green", "purple"), lwd=2)

# Printing AUCs and best curve
auc_vals <- c(
  Preferential_Attachment=pr_pa$auc.integral,
  Jaccard=pr_jaccard$auc.integral,
  Adamic_Adar=pr_adamic$auc.integral,
  Resource_Allocation=pr_ra$auc.integral
)
print(round(auc_vals, 3))
cat(sprintf("\nHighest PR AUC: %s (%.3f)\n", names(which.max(auc_vals)), max(auc_vals)))