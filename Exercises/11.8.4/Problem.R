# Calculate the effective resistance matrix of the network at http:
# //www.networkatlas.eu/exercises/11/3/data.txt and prove it is
# equal to the commute time divided by 2| E|. Note: differently from
# above, the effective resistance matrix can be calculated in python
# without an issue. But the second part of the exercise might fail if
# not done in Octave (or Matlab).

library(here)
library(MASS)

# Reading data
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution 