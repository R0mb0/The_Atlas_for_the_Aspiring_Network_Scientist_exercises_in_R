# Write the in- and out-degree sequence for the graph in Figure
# 9.3(a). Are there isolated nodes? Why? Why not?

library(igraph)

# Adjacency list based on the image (let's name nodes: E, C, D, B, A)
edges <- data.frame(
  from = c("E", "E", "C", "D", "B"),
  to   = c("C", "D", "B", "B", "A")
)

# Solution

g <- graph_from_data_frame(edges, directed=TRUE)

# In- and out-degree sequences
indegree <- degree(g, mode="in")
outdegree <- degree(g, mode="out")

cat("In-degree sequence:\n")
print(indegree)
cat("\nOut-degree sequence:\n")
print(outdegree)

# So there aren't isolated nodes because every node has at least one edge.