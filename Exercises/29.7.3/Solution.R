# Modify the degree distribution of your sample using the Re-
# Weighted Random Walk technique. Is the estimation of the expo-
# nent of the CCDF more precise?

library(here)
library(igraph)

# Loading the network
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

################################################################################
# Helper Functions

# Compute CCDF: for unweighted histogram
compute_ccdf <- function(degrees) {
  tab <- table(degrees)
  degs <- as.numeric(names(tab))
  freq <- as.numeric(tab)
  prob <- freq / sum(freq)
  ccdf <- rev(cumsum(rev(prob)))
  data.frame(degree = degs, ccdf = ccdf)
}
################################################################################

# This should be the solution

# Computing weighted CCDF: for RWRW
compute_weighted_ccdf <- function(degrees, weights) {
  # degrees: vector of degrees (possibly with duplicates)
  # weights: vector of weights for each node
  df <- data.frame(degree = degrees, weight = weights)
  degs <- sort(unique(degrees))
  weighted_prob <- sapply(degs, function(k) sum(df$weight[df$degree == k]))
  weighted_prob <- weighted_prob / sum(weighted_prob)
  weighted_ccdf <- rev(cumsum(rev(weighted_prob)))
  data.frame(degree = degs, ccdf = weighted_ccdf)
}

# Fit log-log regression
fit_log_log <- function(ccdf_df) {
  valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
  fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
  coef(fit)[2]
}

set.seed(42)
target_sample_size <- 2000

# Standard Random Walk
all_nodes <- V(g)$name
start_node <- sample(all_nodes, 1)
rw_walk <- start_node

current_node <- start_node
while (length(rw_walk) < target_sample_size) {
  neighbors_vec <- neighbors(g, current_node)
  if (length(neighbors_vec) == 0) {
    current_node <- sample(all_nodes, 1)
  } else {
    next_vertex <- sample(neighbors_vec, 1)
    next_node <- V(g)[next_vertex]$name
    rw_walk <- c(rw_walk, next_node)
    current_node <- next_node
  }
}

# CCDF for original network
orig_degrees <- degree(g)
orig_ccdf <- compute_ccdf(orig_degrees)
orig_exponent <- fit_log_log(orig_ccdf)

# Standard Random Walk: degree distribution and CCDF
rw_degrees <- degree(g, rw_walk)
rw_ccdf <- compute_ccdf(rw_degrees)
rw_exponent <- fit_log_log(rw_ccdf)

# RWRW: Re-weighted degree distribution and CCDF
rw_weights <- 1 / rw_degrees
rwrw_ccdf <- compute_weighted_ccdf(rw_degrees, rw_weights)
rwrw_exponent <- fit_log_log(rwrw_ccdf)

# Plot comparison
plot(orig_ccdf$degree, orig_ccdf$ccdf, log = "xy", type = "l", col = "red", lwd = 2,
     xlab = "Degree (k)", ylab = "CCDF (P(K>=k))",
     main = "CCDF (log-log): Original, RW, RWRW")
lines(rw_ccdf$degree, rw_ccdf$ccdf, col = "blue", lwd = 2)
lines(rwrw_ccdf$degree, rwrw_ccdf$ccdf, col = "darkgreen", lwd = 2)
legend("bottomleft", legend = c(
  sprintf("Original (%.3f)", orig_exponent),
  sprintf("RW (%.3f)", rw_exponent),
  sprintf("RWRW (%.3f)", rwrw_exponent)),
  col = c("red", "blue", "darkgreen"), lwd = 2)

cat(sprintf("Exponent - Original: %.3f\n", orig_exponent))
cat(sprintf("Exponent - RW: %.3f\n", rw_exponent))
cat(sprintf("Exponent - RWRW: %.3f\n", rwrw_exponent))

# Visualizing the last sampled subgraph for context
# Subgraph induced by unique nodes in the random walk
sampled_nodes <- unique(rw_walk)
sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]
g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)
plot(
  g_sampled,
  vertex.size = 3,
  vertex.label = NA,
  edge.arrow.size = 0.2,
  main = sprintf(
    "Random Walk Sampled Subgraph (%d nodes)", length(V(g_sampled))
  )
)