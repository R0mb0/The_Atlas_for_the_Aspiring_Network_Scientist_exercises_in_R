# Consider the network in http://www.networkatlas.eu/exercises/
# 16/1/data.txt. Generate an Erdős-Rényi graph with the same
# number of nodes and edges. Plot both networks’ degree CCDFs,
# in log-log scale. Discuss the salient differences between these
# istributions.

library(here)
library(igraph)

# Loading data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Erdős-Rényi graph
n_nodes <- vcount(g)
n_edges <- ecount(g)
set.seed(42)
g_er <- sample_gnm(n=n_nodes, m=n_edges, directed=FALSE)

# Degree CCDFs
degree_ccdf <- function(degrees) {
  degs <- sort(unique(degrees))
  ccdf <- sapply(degs, function(k) mean(degrees >= k))
  data.frame(degree=degs, ccdf=ccdf)
}

deg_g   <- degree(g)
deg_er  <- degree(g_er)
ccdf_g  <- degree_ccdf(deg_g)
ccdf_er <- degree_ccdf(deg_er)

# printign the plot 
plot(ccdf_g$degree, ccdf_g$ccdf, log="xy", type="b", col="blue", pch=19,
     xlab="Degree (log)", ylab="CCDF (log)", main="Degree CCDF (log-log)")
points(ccdf_er$degree, ccdf_er$ccdf, col="red", pch=17, type="b")
legend("bottomleft", legend=c("Original Network", "Erdős-Rényi"),
       col=c("blue", "red"), pch=c(19,17), lty=1)

# Discussion: 

# - Original Network: Often has a "heavy tail" (some nodes with much higher 
# degree than the average), suggesting hubs or scale-free structure.

# - Erdős-Rényi: Degree distribution is binomial/Poisson-like, so the CCDF 
# drops off exponentially, with very small chance of high-degree nodes.
