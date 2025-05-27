# How many weakly and strongly connected component does the
# network used in the previous question have? Compare their sizes,
# in number of nodes, with the entire network. Which nodes are in
# these two components?

library(here)
library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE, colClasses="character")
g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)

# Solution

# Calculating the Strongly Connected Components
scc <- components(g, mode="strong")
num_scc <- scc$no
sizes_scc <- scc$csize

# Calculating the Weakly Connected Components
wcc <- components(g, mode="weak")
num_wcc <- wcc$no
sizes_wcc <- wcc$csize

# Printing the result
num_nodes <- vcount(g)
cat(sprintf("Total nodes: %d\n", num_nodes))
cat(sprintf("Number of strongly connected components: %d\n", num_scc))
cat(sprintf("Sizes of SCCs: %s\n", paste(sizes_scc, collapse=", ")))
cat(sprintf("Number of weakly connected components: %d\n", num_wcc))
cat(sprintf("Sizes of WCCs: %s\n", paste(sizes_wcc, collapse=", ")))

################################################################################
# Optional

# List the nodes in each SCC
cat("\nStrongly connected components:\n")
for(i in seq_len(num_scc)) {
  nodes_in_scc <- V(g)$name[which(scc$membership == i)]
  cat(sprintf("SCC %d (%d nodes): %s\n", i, length(nodes_in_scc), paste(nodes_in_scc, collapse=", ")))
}

# List the nodes in each WCC
cat("\nWeakly connected components:\n")
for(i in seq_len(num_wcc)) {
  nodes_in_wcc <- V(g)$name[which(wcc$membership == i)]
  cat(sprintf("WCC %d (%d nodes): %s\n", i, length(nodes_in_wcc), paste(nodes_in_wcc, collapse=", ")))
}
################################################################################