# Estimate the power law exponent of the CCDF degree distribution
# from the previous exercise. First by a linear regression on the log-
# log plane, then by using the powerlaw package. Do they agree? Is
# this a shifted power law? If so, what’s k min ? (Hint: powerlaw can
# calculate this for you)

library(here)
library(igraph)
library(poweRlaw)

# Read the edge list
edges <- read.table("data.txt", header=FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
deg <- degree(g)

# Solution

# Linear Regression on the Log-Log CCDF
# Degree distribution
deg_dist <- table(deg)
deg_vals <- as.numeric(names(deg_dist))
deg_freq <- as.numeric(deg_dist)
deg_ccdf <- rev(cumsum(rev(deg_freq))) / sum(deg_freq)

# Removing degrees with zero frequency
nonzero <- deg_ccdf > 0

# Preparing log-log data
log_deg <- log10(deg_vals[nonzero])
log_ccdf <- log10(deg_ccdf[nonzero])

# Linear regression (excluding degree=0)
fit <- lm(log_ccdf ~ log_deg)

cat("Estimated exponent (linear regression):", -coef(fit)[2], "\n")
summary(fit)

library(poweRlaw)

# Create a discrete power law object
pl_model <- displ$new(deg)

# Estimate xmin and alpha automatically
est <- estimate_xmin(pl_model)
pl_model$setXmin(est)

cat("poweRlaw estimated xmin (k_min):", pl_model$getXmin(), "\n")
cat("poweRlaw estimated exponent (alpha):", pl_model$pars, "\n")

if (pl_model$getXmin() > 1) {
  cat("This is a shifted power law, starting from k_min =", pl_model$getXmin(), "\n")
} else {
  cat("This is not a shifted power law (k_min = 1).\n")
}

# So they agreeing because is a shit powerlaw!
