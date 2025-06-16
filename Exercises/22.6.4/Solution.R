# The network at http://www.networkatlas.eu/exercises/22/4/
# data.txt has nodes metadata at http://www.networkatlas.eu/
# exercises/22/4/node_metadata.txt, telling you the current load
# and the maximum load. If the current load exceeds the maximum
# load, the node will shut down and equally distribute all of its
# current load to its neighbors. Some nodes have a current load
# higher than their maximum load. Run the cascade failure and
# report how many nodes are left standing once the cascade finishes.

library(here)
library(igraph)

# Loading the network
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("from", "to")
edges[] <- lapply(edges, as.character)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Loading metadata
meta <- read.delim("node_metadata.txt", header=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
# Cleaning up column names: remove leading/trailing spaces, replace multiple spaces/tabs with "_"
colnames(meta) <- gsub("[ \t]+", "_", trimws(colnames(meta)))

meta$node <- as.character(meta$node)

# Get the correct column names for current and max load
current_col <- grep("^current.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)
max_col <- grep("^max.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)

current_load <- setNames(meta[[current_col]], meta$node)
max_load <- setNames(meta[[max_col]], meta$node)
standing <- setNames(rep(TRUE, length(current_load)), names(current_load))

# Solution 

repeat {
  overloaded <- names(current_load)[standing & (current_load > max_load)]
  if(length(overloaded) == 0) break
  
  for(node in overloaded) {
    neighbors_vec <- neighbors(g, node)
    # Only distribute to standing neighbors
    neighbors_ids <- names(current_load)[neighbors_vec %in% which(standing)]
    n_neighbors <- length(neighbors_ids)
    if(n_neighbors > 0) {
      load_to_give <- current_load[node]
      current_load[neighbors_ids] <- current_load[neighbors_ids] + load_to_give / n_neighbors
    }
    current_load[node] <- 0
    standing[node] <- FALSE
  }
}

# Printing results
n_standing <- sum(standing)
cat("Number of nodes left standing after cascade:", n_standing, "\n")