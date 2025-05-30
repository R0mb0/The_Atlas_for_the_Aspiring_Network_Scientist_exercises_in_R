# Draw the spectral plot of the network at http://www.networkatlas.
# eu/exercises/11/5/data.txt, showing the relationship between
# the second and third eigenvectors of its Laplacian. Can you find
# clusters?

library(here)

# Reading the data 
edges <- read.table("data.txt", header=FALSE)
nodes <- sort(unique(c(edges$V1, edges$V2)))

# Write here the solution