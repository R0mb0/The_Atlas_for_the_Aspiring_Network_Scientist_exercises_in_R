# Find a way to fit the truncated power law of the network at http:
#  //www.networkatlas.eu/exercises/9/6/data.net. Hint: use the
# scipy.optimize.curve_fit to fit an arbitrary function and use the
# functional form I provide in the text.

library(here)
library(igraph)
library(poweRlaw)

# Read the Pajek network
g <- read_graph("data.net", format="pajek")

# Get degree sequence
deg <- degree(g)

# Solution 

# Preparing the Degree Distribution
deg_tab <- table(deg)
deg_vals <- as.numeric(names(deg_tab))
deg_freq <- as.numeric(deg_tab)

# Fitting a Truncated Power Law

# Creating data for fitting (exclude zeros)
fit_idx <- deg_vals > 0
x <- deg_vals[fit_idx]
y <- deg_freq[fit_idx]

# Normalizing y for probability (optional, but better for fit)
y <- y / sum(y)

# Nonlinear fit: y ~ C * x^(-alpha) * exp(-lambda * x)
tplaw <- nls(y ~ C * x^(-alpha) * exp(-lambda * x),
             start=list(C=1, alpha=2, lambda=0.1),
             control = nls.control(maxiter = 100))

summary(tplaw)

# Plotting the fit

plot(x, y, log="xy", pch=20, xlab="Degree", ylab="P(k)", main="Truncated Power Law Fit")
lines(x, predict(tplaw), col="red", lwd=2)
legend("topright", legend="TPL fit", col="red", lwd=2)

################################################################################
# Optional: Using poweRlaw for Comparison

# Suppose deg is the degree vector
m <- displ$new(deg)

# Estimating xmin and exponent (alpha)
est <- estimate_xmin(m)
m$setXmin(est)
est_pars <- estimate_pars(m)
m$setPars(est_pars$pars)

# Plotting the data and the fit
plot(m, main="Using poweRlaw for Comparison")
lines(m, col="red")
################################################################################