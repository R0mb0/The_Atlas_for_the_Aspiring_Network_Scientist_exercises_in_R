library(igraph)
library(here)
library(Rtsne)
library(word2vec)
library(stats)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
network_data <- as.matrix(network_data)
network_data_char <- apply(network_data, 2, as.character)
g <- graph_from_edgelist(network_data_char, directed = FALSE)

# Loading the node colors (ground truth labels)
node_colors_data <- read.table(here("nodes.txt"), header = FALSE)
node_colors <- node_colors_data[,2]
names(node_colors) <- as.character(node_colors_data[,1])

# Generating random walks
set.seed(42)
num_walks <- 10000
walk_length <- 6
nodes <- V(g)$name
walks <- vector("list", num_walks)

for (i in 1:num_walks) {
  current <- sample(nodes, 1)
  walk <- as.character(current)
  for (j in 2:walk_length) {
    neighbors_list <- neighbors(g, current)
    neighbors_char <- as.character(neighbors_list$name)
    if (length(neighbors_char) == 0) break
    current <- sample(neighbors_char, 1)
    walk <- c(walk, current)
  }
  walks[[i]] <- walk
}

# Writing walks to a temporary text file for word2vec
walks_file <- here("walks.txt")
writeLines(sapply(walks, paste, collapse = " "), walks_file)

# Training Word2Vec embeddings (d = 32)
emb <- word2vec::word2vec(walks_file, type = "skip-gram", dim = 32, window = 5, min_count = 1, iter = 10)
emb_df <- word2vec::as.data.frame(emb)
emb_matrix <- as.matrix(emb_df)
rownames(emb_matrix) <- emb_df$word
emb_matrix <- emb_matrix[nodes, -1, drop = FALSE] # drop the 'word' column

# Reducing to 2D using t-SNE
set.seed(42)
tsne_result <- Rtsne(emb_matrix, dims = 2)
embedding_2d <- tsne_result$Y

# Running k-means clustering to find 4 clusters
set.seed(42)
kmeans_result <- kmeans(embedding_2d, centers = 4)
clusters <- kmeans_result$cluster

# Converting clustering results and ground truth to communities format
# Each cluster becomes a list of node names
clustering_communities <- lapply(1:4, function(k) nodes[clusters == k])
# Each ground truth label becomes a list of node names
ground_truth_labels <- unique(node_colors[nodes])
ground_truth_communities <- lapply(ground_truth_labels, function(l) nodes[node_colors[nodes] == l])

# Copying the NMI implementation provided
get_membership_matrix <- function(communities, all_nodes) {
  mat <- matrix(0, nrow=length(all_nodes), ncol=length(communities))
  rownames(mat) <- all_nodes
  for (j in seq_along(communities)) {
    idx <- match(communities[[j]], all_nodes)
    idx <- idx[!is.na(idx)]
    if (length(idx) > 0) {
      mat[idx, j] <- 1
    }
  }
  mat
}

NMI <- function(cover1, cover2) {
  all_nodes <- sort(unique(c(unlist(cover1), unlist(cover2))))
  X <- get_membership_matrix(cover1, all_nodes)
  Y <- get_membership_matrix(cover2, all_nodes)
  n <- length(all_nodes)
  safe_log2 <- function(x) ifelse(x > 0, log2(x), 0)
  cond_entropy <- function(A, B) {
    kA <- ncol(A)
    kB <- ncol(B)
    H <- 0
    for (i in 1:kA) {
      minH <- Inf
      for (j in 1:kB) {
        Nij <- sum(A[,i] & B[,j])
        if (Nij == 0) next
        Ni <- sum(A[,i])
        Nj <- sum(B[,j])
        pij <- Nij / n
        pi <- Ni / n
        pj <- Nj / n
        Hij <- 0
        if (pij > 0 && (pi * pj) > 0)
          Hij <- Hij - (pij) * safe_log2(pij / (pi * pj))
        if ((Ni-Nij) > 0 && (pi * (1-pj)) > 0)
          Hij <- Hij - ((Ni-Nij)/n) * safe_log2(((Ni-Nij)/n) / (pi*(1-pj)))
        if ((Nj-Nij) > 0 && ((1-pi)*pj) > 0)
          Hij <- Hij - ((Nj-Nij)/n) * safe_log2(((Nj-Nij)/n) / ((1-pi)*pj))
        if ((n-Ni-Nj+Nij) > 0 && ((1-pi)*(1-pj)) > 0)
          Hij <- Hij - ((n-Ni-Nj+Nij)/n) * safe_log2(((n-Ni-Nj+Nij)/n) / ((1-pi)*(1-pj)))
        if (!is.nan(Hij) && Hij < minH)
          minH <- Hij
      }
      if (is.finite(minH)) H <- H + minH
    }
    H / kA
  }
  H_XY <- cond_entropy(X, Y)
  H_YX <- cond_entropy(Y, X)
  NMI_value <- 1 - 0.5 * (H_XY + H_YX)
  NMI_value
}

# Calculating NMI score for k-means clustering vs ground truth
nmi_kmeans <- NMI(clustering_communities, ground_truth_communities)
cat("NMI for k-means clustering:", nmi_kmeans, "\n")

# Running label propagation for classical community discovery
set.seed(42)
lp_membership <- cluster_label_prop(g)
lp_communities <- communities(lp_membership)

# Calculating NMI score for label propagation vs ground truth
nmi_labelprop <- NMI(lp_communities, ground_truth_communities)
cat("NMI for label propagation:", nmi_labelprop, "\n")

# Printing instructions for comparing distributions
cat("You can repeat the clustering and label propagation multiple times to see the distributions of NMI scores due to randomness.\n")