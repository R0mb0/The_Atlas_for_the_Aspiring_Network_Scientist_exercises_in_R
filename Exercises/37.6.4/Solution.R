# Using the algorithm you made for exercise 3, answer these questions:
# What is the latest step for which you have the average
# internal community edge density equal to 1? What is the modularity
# at that step? What is the highest modularity you can obtain?
# What is the average internal community edge density at that step?

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"))
colnames(edges) <- c("from", "to", "weight")
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Initializing membership: each node is its own community
membership <- seq_along(V(g))
names(membership) <- V(g)$name

# For tracking the state after each merge
all_memberships <- list()
all_modularities <- c()
all_densities <- c()

g_merge <- g

while(ecount(g_merge) > 0) {
  # Find the edge with the maximum weight
  max_w_idx <- which.max(E(g_merge)$weight)
  max_edge <- ends(g_merge, E(g_merge)[max_w_idx])
  n1 <- max_edge[1]
  n2 <- max_edge[2]
  
  # Get community ids
  comm1 <- membership[n1]
  comm2 <- membership[n2]
  if(comm1 == comm2) break # Already merged
  
  # Merge the communities
  membership[membership == comm2] <- comm1
  
  # Contract nodes in graph
  vmap <- membership[V(g_merge)$name]
  vmap <- as.integer(factor(vmap))
  g_merge <- contract(g_merge, mapping=vmap, vertex.attr.comb="first")
  g_merge <- simplify(g_merge, edge.attr.comb = list(weight="sum"))
  
  # Store membership mapping for this step
  comm_ids <- as.integer(factor(membership))
  all_memberships[[length(all_memberships) + 1]] <- comm_ids
  
  # Compute modularity for this partition
  all_modularities <- c(all_modularities, modularity(g, comm_ids))
  
  # Compute average internal community edge density for this partition
  # For each community, get the subgraph and calculate density, then average
  communities <- split(V(g)$name, comm_ids)
  densities <- c()
  for (comm in communities) {
    if (length(comm) == 1) {
      densities <- c(densities, 1) # Single node: density=1 by convention
    } else {
      subg <- induced_subgraph(g, comm)
      d <- edge_density(subg, loops=FALSE)
      densities <- c(densities, d)
    }
  }
  all_densities <- c(all_densities, mean(densities))
}

# Find the latest step where average internal community density == 1
last_perfect_density <- max(which(abs(all_densities - 1) < 1e-8))
mod_at_perfect_density <- all_modularities[last_perfect_density]

# Find the step with highest modularity
max_modularity <- max(all_modularities)
step_max_modularity <- which.max(all_modularities)
density_at_max_modularity <- all_densities[step_max_modularity]

# Printing the results
cat("Step with latest average internal community density = 1:", last_perfect_density, "\n")
cat("Modularity at that step:", mod_at_perfect_density, "\n")
cat("Step with highest modularity:", step_max_modularity, "\n")
cat("Highest modularity:", max_modularity, "\n")
cat("Average internal community density at that step:", density_at_max_modularity, "\n")