# Find a way to fit the truncated power law of the network at http:
#  //www.networkatlas.eu/exercises/9/6/data.net. Hint: use the
# scipy.optimize.curve_fit to fit an arbitrary function and use the
# functional form I provide in the text.

library(here)
library(igraph)
# library(poweRlaw)

# Read the Pajek network
g <- read_graph("data.net", format="pajek")

# Get degree sequence
deg <- degree(g)

# Write here the solution 