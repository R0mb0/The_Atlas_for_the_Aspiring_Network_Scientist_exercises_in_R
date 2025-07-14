# Generate the two-order line graph of the network at http://www.
# networkatlas.eu/exercises/34/3/data.txt, using the average
# edge betweenness of the edges as the edge weight.

library(here)
library(igraph)

# Loading the edge list from file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building the original graph from the edge list
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Calculatng edge betweenness for each edge in the original graph
eb <- edge_betweenness(g)

# Creating a list of all edges and their names
edge_list <- as_edgelist(g)
edge_names <- apply(edge_list, 1, function(x) paste(sort(x), collapse="-"))
names(eb) <- edge_names
n_edges <- nrow(edge_list)

# Building adjacency for the line graph: edges become nodes, 
# connecting two "edge-nodes" if they share a node in the original graph
adj <- list()
for(i in 1:(n_edges-1)) {
  for(j in (i+1):n_edges) {
    # Check if edges i and j share one node
    if(length(intersect(edge_list[i,], edge_list[j,])) == 1) {
      e1 <- edge_names[i]
      e2 <- edge_names[j]
      # Weight is the average edge betweenness of the two edges
      w <- mean(c(eb[e1], eb[e2]))
      adj <- append(adj, list(c(e1, e2, w)))
    }
  }
}

# Combining adjacency list into a data frame for the line graph
if (length(adj) > 0) {
  line_edges <- do.call(rbind, adj)
  colnames(line_edges) <- c("from", "to", "weight")
  # Build the line graph using the edge list and weights
  line_g <- graph_from_data_frame(line_edges, directed=FALSE)
  print(line_g)
} else {
  cat("No edges in the second-order line graph.\n")
}