# The network in http://www.networkatlas.eu/exercises/7/4/
# data.txt is dynamic, the third and fourth columns of the edge
# list tell you the first and last snapshot in which the edge was
# continuously present. An edge can reappear if the edge was
# present in two discontinuous time periods. Aggregate it using a
# disjoint window of size 3.

library(here)
#library(igraph)

# Reading the data
dat <- read.table("data.txt", header=FALSE)
colnames(dat) <- c("source", "target", "start", "end")

# Write here the solution 