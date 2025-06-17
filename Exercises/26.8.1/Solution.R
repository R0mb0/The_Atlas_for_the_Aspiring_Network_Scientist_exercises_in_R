# Perform a network projection of the bipartite network at http:
# //www.networkatlas.eu/exercises/26/1/data.txt using simple
# weights. The unipartite projection should only contain nodes of
# type 1 (|V1 | = 248). How dense is the projection?

library(here)
library(igraph)

# Reading the bipartite edge list
edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(edges) <- c("V1", "V2")

# Solution 

# Identifying node types
V1 <- unique(c(edges$V1[grep("^a", edges$V1)], edges$V2[grep("^a", edges$V2)]))
V2 <- unique(c(edges$V1[grep("^b", edges$V1)], edges$V2[grep("^b", edges$V2)]))

# Preparing vertex dataframe with a type attribute (TRUE for V1, FALSE for V2)
vertex_df <- data.frame(
  name=c(V1, V2),
  type=c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
)

# Preparing edge list so all edges are from V1 to V2 (order doesn't matter for undirected)
edges_long <- data.frame(
  V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
  V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
  stringsAsFactors=FALSE
)

# Creating a bipartite graph
g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)

# Projecting onto type 1 nodes (V1, type==TRUE)
proj <- bipartite_projection(g_bipartite)
g_proj <- proj$proj1  # This will be the V1 projection, since we ordered the vertex_df

# Calculating the density
n <- length(V1)
num_edges <- gsize(g_proj)
possible_edges <- n * (n - 1) / 2
density <- num_edges / possible_edges

# Printing the results 
cat(sprintf("Number of nodes in projection: %d\n", n))
cat(sprintf("Number of edges in projection: %d\n", num_edges))
cat(sprintf("Possible number of edges: %d\n", possible_edges))
cat(sprintf("Density of the unipartite projection: %.5f\n", density))

################################################################################
# Optional

# Plotting the original bipartite network
V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "salmon")
V(g_bipartite)$shape <- ifelse(V(g_bipartite)$type, "circle", "square")
V(g_bipartite)$size <- 3
V(g_bipartite)$label <- NA  # hide labels for clarity

# Use a bipartite layout (type1 nodes on one axis, type2 on the other)
layout_bip <- layout_as_bipartite(g_bipartite)
plot(
  g_bipartite,
  layout=layout_bip,
  main="Original Bipartite Network"
)

# Plotting the projected network
set.seed(42) # For reproducible layout
plot(
  g_proj,
  vertex.size=3,
  vertex.label=NA,
  edge.width=1,
  edge.color="gray80",
  vertex.color="skyblue",
  main="Unipartite Projection of Type 1 Nodes"
)
################################################################################