# Calculate the hitting time matrix of the network at http://www.
# networkatlas.eu/exercises/11/3/data.txt. Note: for various
# reasons, a naive implementation in python using numpy and scipy
# might lead to the wrong result. I would advise to try and do this
# in Octave (or Matlab).

library(here)

# Reading the data
edges <- read.table("data.txt", header = FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution