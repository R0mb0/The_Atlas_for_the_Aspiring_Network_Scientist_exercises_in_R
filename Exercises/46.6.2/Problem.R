# The table at http://www.networkatlas.eu/exercises/46/2/
# diffusion.txt contains the information of which node (first
# column) influenced which other node (second column). Use it
# to summarize the graph by keeping only the edges used by the
# spreading process.

library(igraph)
library(here)

# Loading the diffusion edge list from the file in the script folder
diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)

# Building the graph using the edges from the diffusion process
diffusion_graph <- graph_from_edgelist(as.matrix(diffusion_edges), directed = TRUE)

# Write here the solution 