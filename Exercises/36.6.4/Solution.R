# Assume that http://www.networkatlas.eu/exercises/36/4/
# nodes.txt contains the “true” community partition of the nodes
# from the network at http://www.networkatlas.eu/exercises/
# 36/1/data.txt. Determine which algorithm between the asynchronous
# and the semi-synchronous label propagation achieves
# higher Normalized Mutual Information with such gold standard.

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Loading the gold standard communities from nodes.txt
true_membership_df <- read.table(here("nodes.txt"))
colnames(true_membership_df) <- c("node", "community")
true_membership <- setNames(true_membership_df$community, as.character(true_membership_df$node))

# Solution 

# Computing the detected communities using label propagation (asynchronous)
com_lp <- cluster_label_prop(g)
lp_membership <- membership(com_lp)

# Matching true membership and detected membership
common_nodes <- intersect(names(true_membership), names(lp_membership))
true <- true_membership[common_nodes]
pred_lp <- lp_membership[common_nodes]

# Computing the Normalized Mutual Information (NMI) between true and detected partitions
nmi_lp <- compare(true, pred_lp, method="nmi")

# Printing the results
cat("Evaluating Normalized Mutual Information (NMI) with the gold standard\n")
cat(sprintf("Label Propagation (asynchronous) NMI: %.4f\n", nmi_lp))