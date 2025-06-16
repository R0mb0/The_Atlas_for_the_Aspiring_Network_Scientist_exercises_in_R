# Draw the ROC curves on the cross validation of the network used
# at the previous question, comparing the following link predictors:
# preferential attachment, jaccard, Adamic-Adar, and resource alloca-
# tion. Which of those has the highest AUC? (Again, scikit-learn
# has helper functions for you)

library(here)
library(igraph)
library(caret)
library(pROC)

# Reading the data and building the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
edges[] <- lapply(edges, as.character)
g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

all_nodes <- V(g_full)$name

# Write here the solution 