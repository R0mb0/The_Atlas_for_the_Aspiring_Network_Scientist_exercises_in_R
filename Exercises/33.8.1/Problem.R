# Calculate the flow hierarchy of the network at http://www.
# networkatlas.eu/exercises/33/1/data.txt. Generate 25 ver-
# sions of the network with the same degree distributions of the
# observed one (use the directed configuration model) and calculate
# how many standard deviations the observed value is above or
# below the average value you obtain from the null model.

library(here)
library(igraph)

# Loading the directed edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = TRUE)

# Write here the solution