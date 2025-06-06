# Which is the most authoritative node in the network used for
# the previous question? Which one is the best hub? Use the HITS
# algorithm to motivate your answer (if using networkx, use the
# scipy version of the algorithm).

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Solution

# Computing PageRank for each node
pr <- page.rank(g)$vector

# Computing in-degree for each node
indeg <- degree(g, mode="in")

# Finding the most central node(s) by PageRank
max_pr <- max(pr)
most_central_nodes <- which(pr == max_pr)
cat("Most central node(s) by PageRank (numeric ID):", most_central_nodes, "\n")
cat("Highest PageRank value:", max_pr, "\n\n")

# Printing a table of
cat("Node\tPageRank\tIn-degree\n")
for (i in 1:vcount(g)) {
  cat(sprintf("%d\t%.4f\t\t%d\n", i, pr[i], indeg[i]))
}

cat("\n")

# Calculating Spearman and Pearson correlation between PageRank and in-degree
spearman_corr <- cor(pr, indeg, method="spearman")
pearson_corr  <- cor(pr, indeg, method="pearson")
cat(sprintf("Spearman correlation between PageRank and in-degree: %.4f\n", spearman_corr))
cat(sprintf("Pearson correlation between PageRank and in-degree: %.4f\n", pearson_corr))