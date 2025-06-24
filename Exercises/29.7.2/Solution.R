# Compare the CCDF of your sample with the one of the original
# network by fitting a log-log regression and comparing the ex-
# ponents. You can take multiple samples from different seeds to
# ensure the robustness of your result.

library(here)
library(igraph)

# Loading the network from file
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

################################################################################
# Helper functions 

# Helper function to compute CCDF of a degree vector
compute_ccdf <- function(degrees) {
  tab <- table(degrees)
  degs <- as.numeric(names(tab))
  freq <- as.numeric(tab)
  prob <- freq / sum(freq)
  ccdf <- rev(cumsum(rev(prob)))
  data.frame(degree = degs, ccdf = ccdf)
}

# Helper function to fit log-log regression and return the exponent/slope
fit_log_log <- function(ccdf_df) {
  valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
  fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
  coef(fit)[2] # Slope
}

################################################################################a

# Parameters
n_samples <- 5                   # Number of samples for robustness
target_sample_size <- 2000       # As before
seeds <- 100 * (1:n_samples)     # Example: 100, 200, 300,...

# This should be the solution 

# Computing degree distribution and CCDF of the original graph
orig_degrees <- degree(g)
orig_ccdf <- compute_ccdf(orig_degrees)
orig_exponent <- fit_log_log(orig_ccdf)

cat(sprintf("Original network log-log CCDF exponent: %.3f\n", orig_exponent))

# For storing sampled exponents and last sampled graph
sampled_exponents <- numeric(n_samples)
last_g_sampled <- NULL

# Sampling and analysis
for (i in seq_along(seeds)) {
  set.seed(seeds[i])
  
  # Random Walk Sampling
  all_nodes <- V(g)$name
  start_node <- sample(all_nodes, 1)
  sampled_nodes <- c(start_node)
  visited <- setNames(rep(FALSE, vcount(g)), all_nodes)
  visited[start_node] <- TRUE
  current_node <- start_node
  while (length(sampled_nodes) < target_sample_size) {
    neighbors_vec <- neighbors(g, current_node)
    if (length(neighbors_vec) == 0) {
      current_node <- sample(all_nodes, 1)
    } else {
      next_vertex <- sample(neighbors_vec, 1)
      next_node <- V(g)[next_vertex]$name
      if (!visited[next_node]) {
        sampled_nodes <- c(sampled_nodes, next_node)
        visited[next_node] <- TRUE
      }
      current_node <- next_node
    }
  }
  sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]
  g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)
  last_g_sampled <- g_sampled
  
  # Computing sampled degree distribution and CCDF
  sample_degrees <- degree(g_sampled)
  sample_ccdf <- compute_ccdf(sample_degrees)
  sampled_exponents[i] <- fit_log_log(sample_ccdf)
  
  # Plotting for the first sample
  if (i == 1) {
    plot(orig_ccdf$degree, orig_ccdf$ccdf, log = "xy", type = "l", col = "red", lwd = 2,
         xlab = "Degree (k)", ylab = "CCDF (P(K>=k))",
         main = "CCDF (log-log) of Original vs Sampled Network")
    lines(sample_ccdf$degree, sample_ccdf$ccdf, col = "blue", lwd = 2)
    legend("bottomleft", legend = c("Original", "Sampled"), col = c("red", "blue"), lwd = 2)
  }
}

cat(sprintf("Sampled network log-log CCDF exponents: %s\n", paste(round(sampled_exponents, 3), collapse = ", ")))
cat(sprintf("Mean sampled exponent: %.3f, SD: %.3f\n", mean(sampled_exponents), sd(sampled_exponents)))

################################################################################
# Optional 
# Plotting the last sampled network

set.seed(42)
plot(
  last_g_sampled,
  vertex.size = 3,
  vertex.label = NA,
  edge.arrow.size = 0.2,
  main = sprintf(
    "Random Walk Sampled Subgraph (last sample, %d nodes)",
    length(V(last_g_sampled))
  )
)
################################################################################