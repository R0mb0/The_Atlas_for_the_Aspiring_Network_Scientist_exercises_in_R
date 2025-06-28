# Calculate the degree assortativity of the network from the previ-
# ous question using the first (edge-centric Pearson correlation) and
# the second (node-centric power fit) strategies explained in Section
# 31.1.

library(here)
library(igraph)

# Load edge list from local file
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Build graph
g <- graph_from_data_frame(edges, directed=FALSE)

deg <- degree(g)
V(g)$deg <- deg

# Solution 

# --- Edge-centric Pearson correlation (strategy 1) ---
edge_deg_df <- data.frame(
  k1 = deg[as.character(edges$from)],
  k2 = deg[as.character(edges$to)]
)
# Pearson correlation of degrees at both ends of edges
edge_centric_pearson <- cor(edge_deg_df$k1, edge_deg_df$k2)

cat(sprintf("Edge-centric Pearson correlation (degree assortativity): %.4f\n", edge_centric_pearson))

# Comparing with igraph's built-in degree assortativity
igraph_assort <- assortativity_degree(g, directed=FALSE)
cat(sprintf("igraph::assortativity_degree: %.4f\n", igraph_assort))

# --- Node-centric power fit (strategy 2) ---
# For each node: degree and average neighbor degree
node_ids <- V(g)$name
k <- deg[node_ids]
k_nn <- sapply(node_ids, function(v) {
  nbs <- neighbors(g, v)
  if (length(nbs) == 0) return(NA)
  mean(deg[nbs$name])
})
# Removing nodes with degree 0 (isolated)
valid <- !is.na(k_nn) & k > 0
log_k <- log10(k[valid])
log_k_nn <- log10(k_nn[valid])

# Linear regression in log-log space: log(k_nn) ~ log(k)
fit <- lm(log_k_nn ~ log_k)
node_centric_power_slope <- coef(fit)[2]

cat(sprintf("Node-centric power fit exponent (slope in log-log): %.4f\n", node_centric_power_slope))