# Perform a network projection of the previously used bipartite
# network using hyperbolic weights. Draw a scatter plot comparing
# hyperbolic and simple weights.

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
  name = c(V1, V2),
  type = c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
)

# Preparing edge list so all edges are from V1 to V2
edges_long <- data.frame(
  V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
  V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
  stringsAsFactors = FALSE
)

# Creating bipartite graph
g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)

# Projecting onto type 1 nodes (V1) using simple weights (number of shared neighbors in V2)
proj <- bipartite_projection(g_bipartite)
g_proj <- proj$proj1

# Incidence matrix (rows: V1 nodes, cols: V2 nodes)
A <- as_incidence_matrix(g_bipartite, types=vertex_df$type, sparse=TRUE)
A <- as(A, "dgCMatrix") # Ensure sparse matrix
V1_names <- rownames(A)
V2_names <- colnames(A)

# Hyperbolic weights (using rownames(A) for matrix names and all node accesses)
hyperbolic_weights <- matrix(0, nrow=length(V1_names), ncol=length(V1_names), dimnames=list(V1_names, V1_names))
deg_V2 <- Matrix::colSums(A) # degree for each V2 node

for (k in which(deg_V2 > 1)) {
  v2 <- V2_names[k]
  nodes <- V1_names[which(A[, v2] == 1)]
  if(length(nodes) < 2) next
  w <- 1 / (deg_V2[k] - 1)
  for(i in 1:(length(nodes)-1)) {
    for(j in (i+1):length(nodes)) {
      hyperbolic_weights[nodes[i], nodes[j]] <- hyperbolic_weights[nodes[i], nodes[j]] + w
      hyperbolic_weights[nodes[j], nodes[i]] <- hyperbolic_weights[nodes[j], nodes[i]] + w
    }
  }
}

# Extracting simple weights for V1 pairs
simple_weights <- as.matrix(A %*% t(A))
diag(simple_weights) <- 0 # remove self-loops

# Preparing data for scatter plot (upper triangle, i < j)
scatter_data <- data.frame(
  from = character(), to = character(),
  simple = numeric(), hyperbolic = numeric(),
  stringsAsFactors = FALSE
)
for(i in 1:(length(V1_names)-1)) {
  for(j in (i+1):length(V1_names)) {
    s <- simple_weights[V1_names[i], V1_names[j]]
    h <- hyperbolic_weights[V1_names[i], V1_names[j]]
    if(s > 0 || h > 0) {
      scatter_data <- rbind(scatter_data, data.frame(
        from=V1_names[i], to=V1_names[j], simple=s, hyperbolic=h
      ))
    }
  }
}

# Scatter plot: hyperbolic vs simple weights
plot(
  scatter_data$simple, scatter_data$hyperbolic,
  pch=20, col=rgb(0,0,1,0.5),
  xlab="Simple Weight (shared neighbors)", ylab="Hyperbolic Weight",
  main="Scatter Plot: Hyperbolic vs Simple Weights"
)
abline(0, 1, col="red", lty=2)

################################################################################
# Optional

# Printing correlation
cor_val <- cor(scatter_data$simple, scatter_data$hyperbolic)
cat(sprintf("Pearson correlation between simple and hyperbolic weights: %.4f\n", cor_val))
################################################################################