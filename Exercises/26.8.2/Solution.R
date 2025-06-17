# Perform a network projection of the previously used bipartite
# network using cosine and Pearson weights. What is the Pearson
# correlation of these weights compared with the ones from the
# previous question?

library(here)
library(igraph)
library(Matrix)

# Reading the bipartite edge list
edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(edges) <- c("V1", "V2")

# Solution 

# Identifying node types (V1: starts with "a", V2: starts with "b")
V1 <- unique(c(edges$V1[grep("^a", edges$V1)], edges$V2[grep("^a", edges$V2)]))
V2 <- unique(c(edges$V1[grep("^b", edges$V1)], edges$V2[grep("^b", edges$V2)]))

# Preparing vertex dataframe with a type attribute (TRUE for V1, FALSE for V2)
vertex_df <- data.frame(
  name=c(V1, V2),
  type=c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
)

# Preparing edge list so all edges are from V1 to V2
edges_long <- data.frame(
  V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
  V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
  stringsAsFactors=FALSE
)

# Creating a bipartite graph
g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)

# Projecting onto type 1 nodes (V1, type==TRUE, simple weights)
proj <- bipartite_projection(g_bipartite)
g_proj <- proj$proj1

# Calculating density
n <- length(V1)
num_edges <- gsize(g_proj)
possible_edges <- n * (n - 1) / 2
density <- num_edges / possible_edges

# From the previous exercise printing the results 
cat(sprintf("Number of nodes in projection: %d\n", n))
cat(sprintf("Number of edges in projection: %d\n", num_edges))
cat(sprintf("Possible number of edges: %d\n", possible_edges))
cat(sprintf("Density of the unipartite projection: %.5f\n", density))

################################################################################
# Optional

# Plotting the projected network (simple weights)
set.seed(42)
plot(
  g_proj,
  vertex.size=3,
  vertex.label=NA,
  edge.width=1,
  edge.color="gray80",
  vertex.color="skyblue",
  main="Unipartite Projection (Simple Weights)"
)

# Plotting the original bipartite network
V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "salmon")
V(g_bipartite)$shape <- ifelse(V(g_bipartite)$type, "circle", "square")
V(g_bipartite)$size <- 3
V(g_bipartite)$label <- NA  # hide labels for clarity

layout_bip <- layout_as_bipartite(g_bipartite)
plot(
  g_bipartite,
  layout=layout_bip,
  main="Original Bipartite Network"
)
################################################################################

################ Cosine and Pearson Weighted Projections #######################

# Bipartite incidence matrix (rows: V1, cols: V2)
A <- as_incidence_matrix(g_bipartite, types=vertex_df$type, sparse=TRUE)
A <- as(A, "dgCMatrix") # Ensure sparse matrix

#  Cosine similarity matrix
norms <- sqrt(rowSums(A^2))
cosine_sim <- as.matrix(A %*% t(A))
norms_mat <- outer(norms, norms)
cosine_sim <- cosine_sim / norms_mat
diag(cosine_sim) <- 0 # Remove self-loops
cosine_sim[is.na(cosine_sim)] <- 0

#  Pearson similarity matrix
A_centered <- A - rowMeans(A)
pearson_num <- as.matrix(A_centered %*% t(A_centered))
pearson_denom <- outer(
  sqrt(rowSums((A - rowMeans(A))^2)),
  sqrt(rowSums((A - rowMeans(A))^2))
)
pearson_sim <- pearson_num / pearson_denom
diag(pearson_sim) <- 0
pearson_sim[is.na(pearson_sim)] <- 0

# Building edges for upper triangle only (i < j), using V1 names
get_upper_edges <- function(sim_matrix, node_names, min_weight = 0) {
  idx <- which(upper.tri(sim_matrix) & sim_matrix > min_weight, arr.ind=TRUE)
  if(nrow(idx) == 0) return(data.frame(from=character(), to=character(), weight=numeric()))
  data.frame(
    from = node_names[idx[,1]],
    to   = node_names[idx[,2]],
    weight = sim_matrix[idx],
    stringsAsFactors = FALSE
  )
}

edges_cosine <- get_upper_edges(cosine_sim, V1)
edges_pearson <- get_upper_edges(pearson_sim, V1)

# Cleaning up: removing NAs, NaNs, empties, self-loops, and non-existent nodes (shouldn't happen, but robust)
edges_cosine <- subset(edges_cosine, 
                       !is.na(from) & !is.na(to) & from != "" & to != "" & !is.nan(weight) & from %in% V1 & to %in% V1 & from != to
)
edges_pearson <- subset(edges_pearson, 
                        !is.na(from) & !is.na(to) & from != "" & to != "" & !is.nan(weight) & from %in% V1 & to %in% V1 & from != to
)

# Removing duplicate edges (if any)
edges_cosine <- unique(edges_cosine)
edges_pearson <- unique(edges_pearson)

# Only building the graph if there are edges
if (nrow(edges_cosine) > 0) {
  g_cosine <- graph_from_data_frame(edges_cosine, directed=FALSE, vertices=data.frame(name=V1))
  E(g_cosine)$weight <- edges_cosine$weight
} else {
  warning("No edges in cosine projection.")
  g_cosine <- make_empty_graph(n = length(V1))
}

if (nrow(edges_pearson) > 0) {
  g_pearson <- graph_from_data_frame(edges_pearson, directed=FALSE, vertices=data.frame(name=V1))
  E(g_pearson)$weight <- edges_pearson$weight
} else {
  warning("No edges in Pearson projection.")
  g_pearson <- make_empty_graph(n = length(V1))
}

################################# Optional #####################################
# Plotting Cosine Weights
set.seed(42)
plot(
  g_cosine,
  vertex.size=3,
  vertex.label=NA,
  edge.width=E(g_cosine)$weight * 5, # scale for visibility
  edge.color=rgb(0,0,0,alpha=0.3),
  vertex.color="skyblue",
  main="Projection (Cosine Similarity Weights)"
)

# Plotting Pearson Weights
set.seed(42)
plot(
  g_pearson,
  vertex.size=3,
  vertex.label=NA,
  edge.width=pmax(E(g_pearson)$weight,0) * 5,
  edge.color=rgb(0,0,1,alpha=0.3),
  vertex.color="skyblue",
  main="Projection (Pearson Similarity Weights)"
)
################################################################################

# Pearson correlation of weights (simple vs cosine, simple vs pearson, cosine vs pearson)
simple_weights <- E(g_proj)$weight
names(simple_weights) <- apply(as.data.frame(ends(g_proj, E(g_proj))), 1, function(x) paste(sort(x), collapse = "_"))
cosine_weights <- edges_cosine$weight
names(cosine_weights) <- apply(edges_cosine[,1:2], 1, function(x) paste(sort(x), collapse = "_"))
pearson_weights <- edges_pearson$weight
names(pearson_weights) <- apply(edges_pearson[,1:2], 1, function(x) paste(sort(x), collapse = "_"))

# Only comparing weights where an edge is present in all projections
common_keys <- Reduce(intersect, list(names(simple_weights), names(cosine_weights), names(pearson_weights)))
cat(sprintf("Number of common edges between all projections: %d\n", length(common_keys)))

if(length(common_keys) > 1) {
  cat(sprintf("Pearson correlation (simple vs cosine): %.4f\n",
              cor(simple_weights[common_keys], cosine_weights[common_keys])))
  cat(sprintf("Pearson correlation (simple vs pearson): %.4f\n",
              cor(simple_weights[common_keys], pearson_weights[common_keys])))
  cat(sprintf("Pearson correlation (cosine vs pearson): %.4f\n",
              cor(cosine_weights[common_keys], pearson_weights[common_keys])))
} else {
  cat("Not enough common edges to compute Pearson correlations.\n")
}