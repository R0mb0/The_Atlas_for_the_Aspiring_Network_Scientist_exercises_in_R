# What is the minimum statistically significant edge weight – the
# one two standard deviations away from the average – of the previ-
# ous network? How many edges would you keep if you were to set
# that as the threshold?

library(here)
library(igraph)

# Reading the edge list from file
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Extracting edge weights
w <- E(g)$weight

# Solution 

# Computing mean and standard deviation
w_mean <- mean(w)
w_sd <- sd(w)
# Minimum statistically significant edge weight (mean + 2*sd)
threshold <- w_mean + 2*w_sd


# Printing solutions 
cat(sprintf("Average edge weight: %.2f\n", w_mean))
cat(sprintf("Standard deviation: %.2f\n", w_sd))
cat(sprintf("Minimum statistically significant edge weight (mean + 2*sd): %.2f\n", threshold))

# How many edges meet or exceed this threshold?
n_above <- sum(w >= threshold)
cat(sprintf("Number of edges retained with threshold %.2f: %d (out of %d)\n", threshold, n_above, length(w)))