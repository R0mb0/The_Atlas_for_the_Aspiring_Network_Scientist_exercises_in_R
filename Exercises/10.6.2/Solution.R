library(here)
library(igraph)

# Read the edge list (assuming two columns, space separated, no header)
edges <- read.table("data.txt", header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = TRUE)

# all_simple_cycles() returns a list of cycles (each as a vector of vertex ids)
cycles <- all_simple_cycles(g)

# Print cycles with node numbers as in the input
cat("All cycles found:\n")
for (cyc in cycles) {
  cat(V(g)$name[cyc], "\n")
}