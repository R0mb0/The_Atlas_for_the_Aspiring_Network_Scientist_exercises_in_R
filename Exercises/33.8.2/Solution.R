# Calculate the global reach centrality of the network at http://
# www.networkatlas.eu/exercises/33/1/data.txt (note: it’s much
# better to calculate all shortest paths beforehand and cache the
# result to calculate all local reaching centralities). Is there a single
# head of the hierarchy or multiple? How many?

library(here)
library(igraph)

# Loading the directed edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = TRUE)
N <- vcount(g)

# Solution

# Precomputing all shortest paths (for reachability)
# Getting reachability for each node
lrc <- numeric(N)
for (v in seq_len(N)) {
  reachable <- subcomponent(g, v, mode = "out")
  # Exclude self
  lrc[v] <- (length(reachable) - 1) / (N - 1)
}

names(lrc) <- V(g)$name

# Global reach centrality
max_lrc <- max(lrc)
mean_lrc <- mean(lrc)
grc <- (max_lrc - mean_lrc) / (N - 1)


# Printing results
cat(sprintf("Global Reaching Centrality (GRC): %.4f\n", grc))

# Heads of hierarchy (nodes with maximal LRC)
heads <- names(lrc)[lrc == max_lrc]
cat("Node(s) with maximal local reaching centrality (head(s) of hierarchy):\n")
print(heads)
cat(sprintf("Number of head(s) of hierarchy: %d\n", length(heads)))