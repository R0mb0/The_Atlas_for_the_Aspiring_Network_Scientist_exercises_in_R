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

# Write here the solution