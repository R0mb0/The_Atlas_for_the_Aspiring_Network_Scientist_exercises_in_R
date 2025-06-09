# Generate a preferential attachment network with 2, 000 nodes and
# average degree of 2. Estimate its degree distribution exponent
# (you can use either the powerlaw package, or do a simple log-log
# regression of the CCDF).

library(here)
library(igraph)

# Generate the network
set.seed(42)
g <- sample_pa(n = 2000, m = 1, directed = FALSE)

# Solution 

# Calculating the degree sequence
deg <- degree(g)

# Computing the CCDF (Complementary Cumulative Distribution Function)
deg_tab <- table(deg)
deg_vals <- as.numeric(names(deg_tab))
deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
ccdf <- rev(cumsum(rev(deg_prob)))

# Log-log regression (excluding degree 0)
min_deg <- 1
sel <- deg_vals >= min_deg
log_k <- log(deg_vals[sel])
log_ccdf <- log(ccdf[sel])

fit <- lm(log_ccdf ~ log_k)
gamma_est <- -coef(fit)[2] + 1

# Plotting the results
plot(deg_vals, ccdf, log="xy", xlab="Degree (k)", ylab="CCDF", pch=19,
     main="Degree CCDF (log-log) for Preferential Attachment")
abline(fit, col="red")
legend("bottomleft", legend=paste("Estimated gamma =", round(gamma_est, 2)), bty="n")

# Printing last elaboration
cat("Estimated power-law exponent (gamma):", gamma_est, "\n")