# Generate an Erdős-Rényi graph with the same number of nodes
# and edges as the network used for question 1. Calculate and
# compare the networks’ clustering coefficients. Compare this with
# the connection probability p of the random graph (which you
# should derive from the number of edges and number of nodes
# using the formula I show in this chapter).

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Number of nodes and edges
n_nodes <- vcount(g)
n_edges <- ecount(g)

# Solution 

# ER connection probability
p_er <- 2 * n_edges / (n_nodes * (n_nodes - 1))
cat("Nodes:", n_nodes, "Edges:", n_edges, "\n")
cat("Connection probability p (ER):", p_er, "\n")

# Generating ER random graph
set.seed(42)
g_er <- sample_gnm(n_nodes, n_edges, directed=FALSE)

# Clustering coefficients
cc_real <- transitivity(g, type="global")
cc_er   <- transitivity(g_er, type="global")
cat("Clustering coefficient (real network):", cc_real, "\n")
cat("Clustering coefficient (ER):", cc_er, "\n")

################################################################################
# Optional
# Plotting both graphs side by side
par(mfrow=c(1,2), mar=c(1,1,2,1))
plot(g,
     vertex.size=5,
     vertex.label=NA,
     edge.arrow.size=0.5,
     layout=layout_with_fr,
     main="Original Network")
plot(g_er,
     vertex.size=5,
     vertex.label=NA,
     edge.arrow.size=0.5,
     layout=layout_with_fr,
     main="Erdős-Rényi Random Graph")
par(mfrow=c(1,1))
################################################################################