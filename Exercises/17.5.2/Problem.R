# Generate a preferential attachment network with 2, 000 nodes and
# average degree of 2. Estimate its degree distribution exponent
# (you can use either the powerlaw package, or do a simple log-log
# regression of the CCDF).

library(here)
library(igraph)

# Generate the network
set.seed(42)
g <- sample_pa(n = 2000, m = 1, directed = FALSE)

# Write here the solution