# The network in http://www.networkatlas.eu/exercises/7/3/
# data.txt is a hypergraph, with a hyperedge per line. Transform it
# in a unipartite network in which each hyperedge is split in edges
# connecting all nodes in the hyperedge. Then transform it into a
# bipartite network in which each hyperedge is a node of one type
# and its nodes connect to it.

library(here)

# Read the data
lines <- readLines("data.txt")
# Converting data to a list of node numbers
hyperedges <- lapply(lines, function(line) as.numeric(strsplit(line, " ")[[1]]))

# Solution 

# Building the Unipartite Network

# Function to generate all unordered pairs from a vector
get_pairs <- function(nodes) {
  if(length(nodes) < 2) return(NULL)
  t(combn(nodes, 2))
}

# Applying to all hyperedges and combine
all_pairs <- do.call(rbind, lapply(hyperedges, get_pairs))
unipartite_edges <- unique(all_pairs)  # Removing duplicate edges

# Optional (converting to data frame for inspection)
unipartite_df <- as.data.frame(unipartite_edges)
colnames(unipartite_df) <- c("node1", "node2")
head(unipartite_df)

# Building the Bipartite Network

# Assigning a unique id to each hyperedge
num_hyperedges <- length(hyperedges)
hyperedge_names <- paste0("H", seq_len(num_hyperedges))

# For each hyperedge, create edges between the hyperedge node and its members
bipartite_edges <- data.frame()
for(i in seq_along(hyperedges)) {
  edge <- data.frame(
    hyperedge = hyperedge_names[i],
    node = hyperedges[[i]]
  )
  bipartite_edges <- rbind(bipartite_edges, edge)
}

head(bipartite_edges)
# Columns: hyperedge (e.g. "H1"), node (number)