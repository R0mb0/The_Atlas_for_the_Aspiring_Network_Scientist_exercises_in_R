# Generate an LFR benchmark with 100, 000 nodes, a degree expo-
# nent α = 3.13, a community exponent of 1.1, a mixing parameter
# µ = 0.1, average degree of 10, and minimum community size of
# 10, 000. (Note: there’s a networkx function to do this). Can you
# recover the α value by fitting the degree distribution?

library(here)
library(igraph)

# Solution 

# Generating LFR benchmark
set.seed(123)
g_lfr <- sample_lfr(
  n = 100000,
  tau1 = 3.13,
  tau2 = 1.1,
  mu = 0.1,
  average_degree = 10,
  min_community = 10000
)

# Estimating alpha (degree exponent)
deg <- degree(g_lfr)
deg_tab <- table(deg)
deg_vals <- as.numeric(names(deg_tab))
deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
ccdf <- rev(cumsum(rev(deg_prob)))

sel <- deg_vals > 0
log_k <- log(deg_vals[sel])
log_ccdf <- log(ccdf[sel])

fit <- lm(log_ccdf ~ log_k)
alpha_est <- -coef(fit)[2] + 1

cat(sprintf("Recovered degree exponent (alpha): %.2f\n", alpha_est))

################################################################################
# Optional
# Plotting the results
plot(deg_vals, ccdf, log="xy", xlab="Degree (k)", ylab="CCDF", pch=19, main="LFR Degree Distribution")
abline(fit, col="red")
legend("bottomleft", legend=paste("α =", round(alpha_est, 2)), bty="n")
################################################################################