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

# Write here the solution