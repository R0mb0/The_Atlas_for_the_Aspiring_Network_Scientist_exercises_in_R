# Consider the multilayer network at at http://www.networkatlas.
# eu/exercises/24/3/data.txt. Calculate the Pearson correlation
# between layers (each layer is a vector with an entry per edge. The
# entry is 1 if the edge is present in the layer, 0 otherwise). What
# does this tell you about multilayer link prediction? Should you
# assume layers are independent and therefore apply a single layer
# link prediction to each layer?

library(here)

# Reading the data
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "layer")

# Write here the solution