# Calculate the global, average and local clustering coefficient for
# the network in http://www.networkatlas.eu/exercises/12/3/
# data.txt.

library(here)
#library(igraph)

# Reading the data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution