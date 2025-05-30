# Calculate the non-backtracking matrix of the network used for the
# previous question. (The network is undirected)

library(here)

# Reading the data
edges <- read.table("data.txt", header = FALSE)
colnames(edges) <- c("from", "to")

# Write here the solution