# Generate a series of Erdős-Rényi graphs with 1, 000 nodes and
# n increasing p value, from .00025 to .0025, with increments of
# .000025. Make a plot with the p value on the x axis and the size of
# the largest connected component on the y axis. Can you find the
# phase transition?

library(here)
library(igraph)

# Setting up the parameters
n <- 1000
p_vals <- seq(0.00025, 0.0025, by=0.000025)
largest_cc_sizes <- numeric(length(p_vals))
set.seed(42) # For reproducibility

# Write here the solution