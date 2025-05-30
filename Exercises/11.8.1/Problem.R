# Calculate the stationary distribution of the network at http://
# www.networkatlas.eu/exercises/11/1/data.txt in three ways: by
# raising the stochastic adjacency to a high power, by looking at the
# leading left eigenvector, and by normalizing the degree. Verify that
# they are all equivalent.

library(here)

# Reading the data 
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution