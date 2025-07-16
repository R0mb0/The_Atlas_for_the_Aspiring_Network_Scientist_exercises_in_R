# Use the maximum edge weight pointing to a community as a
# guiding principle to merge nodes into communities using the
# bottom-up approach. (An easy way is to just condense the graph
# by merging the two nodes with the maximum edge weight, for
# every edge in the network)

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Initializing membership: each node is its own community
membership <- seq_along(V(g))
names(membership) <- V(g)$name

# Copying the graph for iterative merging
g_merge <- g

# Tracking modularity after each merge
mod_vals <- c()

# Solution 

while(ecount(g_merge) > 0) {
  # Finding the edge with the maximum weight
  max_w_idx <- which.max(E(g_merge)$weight)
  max_edge <- ends(g_merge, E(g_merge)[max_w_idx])
  n1 <- max_edge[1]
  n2 <- max_edge[2]
  
  # Getting the membership IDs for the two nodes
  comm1 <- membership[n1]
  comm2 <- membership[n2]
  if(comm1 == comm2) break # Already in the same community
  
  # Merging the communities: assign all nodes of comm2 to comm1's community
  membership[membership == comm2] <- comm1
  
  # Contracting the nodes in the graph
  # Build a mapping: for each vertex in g_merge, what is its current (minimum) community ID?
  vmap <- membership[V(g_merge)$name]
  # The mapping must be recoded as 1...N for contract()
  vmap <- as.integer(factor(vmap))
  
  g_merge <- contract(g_merge, mapping = vmap, vertex.attr.comb="first")
  g_merge <- simplify(g_merge, edge.attr.comb = list(weight="sum"))
  
  # Ensuring membership vector for modularity is always consecutive positive integers
  comm_ids <- as.integer(factor(membership))
  mod_vals <- c(mod_vals, modularity(g, comm_ids))
}

# Finding the best step by modularity
max_modularity <- max(mod_vals)
best_step <- which.max(mod_vals)

# Printing the results
cat("Merging nodes using the maximum edge weight (bottom-up)\n")
cat(sprintf("The step with the highest modularity is merge %d with modularity %.4f\n", best_step, max_modularity))