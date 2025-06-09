# Generate an LFR benchmark with 100, 000 nodes, a degree expo-
# nent α = 3.13, a community exponent of 1.1, a mixing parameter
# µ = 0.1, average degree of 10, and minimum community size of
# 10, 000. (Note: there’s a networkx function to do this). Can you
# recover the α value by fitting the degree distribution?

library(here)
library(igraph)

# Solution 