# The network in http://www.networkatlas.eu/exercises/7/2/
# data.txt is multilayer. The data has three columns: source and
# target node, and edge type. The edge type is either the numerical
# id of the layer, or “C” for an inter-layer coupling. Given that this is
# a one-to-one multilayer network, determine whether this network
# has a star, clique or chain coupling.

library(here)

# Reading the data
data <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
colnames(data) <- c("source", "target", "type")

# Write here the solution 