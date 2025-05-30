# Given the bipartite network in http://www.networkatlas.eu/
# exercises/8/2/data.txt, calculate the stochastic adjacency matrix
# of its projection. Project along the axis of size 248. (Note: don’t
# ignore the weights)

library(here)

# Reading the data
dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
colnames(dat) <- c("from", "to", "weight")

# Write here the solution 