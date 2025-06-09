# Generate a series of Erdős-Rényi graphs with p = .02 and increas-
# ing number of nodes, from 200 to 1, 400 with increments of 200.
# Make a plot with the |V | value on the x axis and the average path
# length on the y axis. Since the graph might not be connected, only
# consider the largest connected component. How does the APL
# scale with the number of nodes?

library(here)
library(igraph)

# Setting parameters
p <- 0.02
v_vals <- seq(200, 1400, by=200)
apl_vals <- numeric(length(v_vals))  # to store average path length
set.seed(42)  # for reproducibility

# Write here the solution