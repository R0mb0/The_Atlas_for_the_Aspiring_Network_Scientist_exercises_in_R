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

# Write here the solution