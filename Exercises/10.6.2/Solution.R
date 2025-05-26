# Find all cycles in the network in http://www.networkatlas.eu/
# exercises/10/2/data.txt. Note: the network is directed.

library(here)
library(RBGL)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
nodes <- unique(c(edges$V1, edges$V2))

# Solution (this should be the solution, but I have problems to compile RBGL)

# Creating a directed graphNEL object
gNEL <- new("graphNEL", nodes = as.character(nodes), edgemode = "directed")
for(i in 1:nrow(edges)) {
  gNEL <- addEdge(as.character(edges$V1[i]), as.character(edges$V2[i]), gNEL)
}

# Finding all cycles
cycles <- johnson.all.cycles(gNEL)

# Printing cycles
cat("All cycles found:\n")
for (cyc in cycles) {
  cat(paste(cyc, collapse = " -> "), "\n")
}