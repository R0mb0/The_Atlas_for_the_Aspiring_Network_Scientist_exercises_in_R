# Prove whether the network from the previous questions is affected
# or not by the friendship paradox.

library(here)
library(igraph)

# Loading edge list from local file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building graph
g <- graph_from_data_frame(edges, directed=FALSE)

deg <- degree(g)
V(g)$deg <- deg

# Solution

# checking Friendship paradox 

# Mean degree
mean_deg <- mean(deg)

# For each node: averaging neighbor degree
node_ids <- V(g)$name
k_nn <- sapply(node_ids, function(v) {
  nbs <- neighbors(g, v)
  if (length(nbs) == 0) return(NA)
  mean(deg[nbs$name])
})

# Excluding isolated nodes from average neighbor degree calculation
mean_neighbor_deg <- mean(k_nn, na.rm=TRUE)

# Printing results 

cat(sprintf("Mean degree: %.4f\n", mean_deg))
cat(sprintf("Mean neighbor degree: %.4f\n", mean_neighbor_deg))

if (mean_neighbor_deg > mean_deg) {
  cat("The network IS affected by the friendship paradox: on average, your friends have more friends than you do.\n")
} else if (mean_neighbor_deg < mean_deg) {
  cat("The network is NOT affected by the friendship paradox: on average, your friends have fewer friends than you do.\n")
} else {
  cat("The network is at the threshold: on average, your friends have the same number of friends as you do.\n")
}