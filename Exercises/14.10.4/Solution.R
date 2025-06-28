# What’s the most central node in the network used for the previous
# exercise according to PageRank? How does PageRank compares
# with the in-degree? (for instance, you could calculate the Spear-
# man and/or Pearson correlation between the two)

library(here)
library(igraph)

# Building the graph (reusing your code)
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=TRUE)

# Solution 

# Calculating PageRank for each node
pr <- page.rank(g)$vector

# Finding the most central node(s) by PageRank
max_pr <- max(pr)
most_central_pagerank_nodes <- which(pr == max_pr)

# Calculating in-degree for each node
in_deg <- degree(g, mode = "in")

# Comparing PageRank with in-degree using correlations
spearman_cor <- cor(pr, in_deg, method = "spearman")
pearson_cor <- cor(pr, in_deg, method = "pearson")

# Printing results
cat("PageRank for each node:\n")
for (i in 1:length(pr)) {
  cat(sprintf("Node %s: %.4f\n", V(g)[i]$name, pr[i]))
}
cat("\n")

cat("Most central node(s) by PageRank:", paste(V(g)[most_central_pagerank_nodes]$name, collapse=", "), "\n")
cat("Highest PageRank value:", max_pr, "\n")
cat("\n")

cat("In-degree for each node:\n")
for (i in 1:length(in_deg)) {
  cat(sprintf("Node %s: %d\n", V(g)[i]$name, in_deg[i]))
}
cat("\n")

cat(sprintf("Spearman correlation between PageRank and in-degree: %.4f\n", spearman_cor))
cat(sprintf("Pearson correlation between PageRank and in-degree: %.4f\n", pearson_cor))