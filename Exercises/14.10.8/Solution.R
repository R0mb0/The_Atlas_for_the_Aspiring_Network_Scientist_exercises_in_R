# What’s the degree of centralization of the network used in the
# previous question? Compare the answer you’d get by using, as
# your centrality measure, the degree, closeness, and betweenness
# centrality.

library(here)
library(igraph)

# Building the graph
edges <- as.matrix(read.table("data.txt"))
g <- graph_from_edgelist(edges, directed=FALSE)

# Solution

# Calculating centralization measures
deg_cent <- centr_degree(g, normalized=TRUE)$centralization
clo_cent <- centr_clo(g, normalized=TRUE)$centralization
bet_cent <- centr_betw(g, normalized=TRUE)$centralization

cat(sprintf("Degree centralization:      %.4f\n", deg_cent))
cat(sprintf("Closeness centralization:  %.4f\n", clo_cent))
cat(sprintf("Betweenness centralization:%.4f\n", bet_cent))