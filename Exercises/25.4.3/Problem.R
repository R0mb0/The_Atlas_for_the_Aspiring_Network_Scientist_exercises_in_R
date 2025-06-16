# Calculate precision, recall, and F1-score for the four link predictors
# as used in the previous question. Set up as cutoff point the nineti-
# eth percentile, meaning that you predict a link only for the highest
# ten percent of the scores in each classifier. Which method performs
# best according to these measures? (Note: when scoring with the
# scikit-learn function, remember that this is a binary prediction
# task)

library(igraph)
library(caret)

# Reading the data and building the graph
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
edges[] <- lapply(edges, as.character)
g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

all_nodes <- V(g_full)$name

# Write here the solution