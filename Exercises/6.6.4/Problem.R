# Draw a correlation network for the vectors in http://www.networkatlas.
# eu/exercises/6/4/data.txt, by only drawing edges with positive
# weights, ignoring self loops.

library(here)
library(igraph)

# reading the data
dat <- read.table("data.txt", header=TRUE)

# Write here the solution