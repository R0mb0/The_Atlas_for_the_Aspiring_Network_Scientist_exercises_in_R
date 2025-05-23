# Plot the degree distribution of the network at http://www.networkatlas.
# eu/exercises/9/4/data.txt. Start from a plain degree distribu-
# tion, then in log-log scale, finally plot the complement of the
# cumulative distribution.

library(igraph)

# Read the edge list
edges <- read.table("data.txt", header=FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)

# Compute degree for each node
deg <- degree(g)

# Solution

# Frequency table of degrees
deg_dist <- table(deg)

# Plain degree distribution plot
plot(as.numeric(names(deg_dist)), as.numeric(deg_dist), type="h",
     xlab="Degree", ylab="Frequency", main="Degree Distribution")

# Avoiding log(0) by removing zero frequencies
nonzero <- deg_dist > 0
plot(log10(as.numeric(names(deg_dist[nonzero]))),
     log10(as.numeric(deg_dist[nonzero])),
     xlab="log10(Degree)", ylab="log10(Frequency)", main="Degree Distribution (log-log)",
     pch=20)

# Computing the cumulative distribution
deg_values <- as.numeric(names(deg_dist))
cum_dist <- cumsum(rev(as.numeric(deg_dist)))  # cumulative from high degree down
ccdf <- rev(cum_dist) / sum(deg_dist)  # normalize

# Plotting the CCDF in log-log
plot(log10(deg_values), log10(ccdf), type="b", pch=20,
     xlab="log10(Degree)", ylab="log10(CCDF)", main="Complementary Cumulative Degree Distribution")