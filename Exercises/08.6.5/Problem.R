# Generate the signed and unsigned Laplacians of the signed graph
# at http://www.networkatlas.eu/exercises/8/5/data.txt – the
# third column contains the sign. Calculate their eigenvalues as well
# as the eigenvalue of the version of the graph ignoring edge signs.

library(here)
library(igraph)

# Reading the data
dat <- read.table("data.txt", header=FALSE)
colnames(dat) <- c("from", "to", "sign")

# Write here the solution