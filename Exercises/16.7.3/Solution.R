# Generate a series of Erdős-Rényi graphs with p = .02 and increas-
# ing number of nodes, from 200 to 1, 400 with increments of 200.
# Make a plot with the |V | value on the x axis and the average path
# length on the y axis. Since the graph might not be connected, only
# consider the largest connected component. How does the APL
# scale with the number of nodes?

library(here)
library(igraph)

# Setting parameters
p <- 0.02
v_vals <- seq(200, 1400, by=200)
apl_vals <- numeric(length(v_vals))  # to store average path length
set.seed(42)  # for reproducibility

# Solution 

# Generating Graphs and extracting the largest connected component
for (i in seq_along(v_vals)) {
  n <- v_vals[i]
  g <- sample_gnp(n, p, directed=FALSE)
  
  # Extract the largest connected component
  comps <- components(g)
  giant <- which.max(comps$csize)
  v_giant <- V(g)[comps$membership == giant]
  g_giant <- induced_subgraph(g, v_giant)
  
  # Compute average path length
  apl_vals[i] <- average.path.length(g_giant)
}

# Plotting the result 
plot(v_vals, apl_vals, type="b", pch=19, col="blue",
     xlab="Number of nodes (|V|)", ylab="Average Path Length (APL)",
     main="APL of Erdős-Rényi Graphs (p = 0.02)")

# Interpretation

# - The APL in Erdős-Rényi graphs typically grows like (\log(|V|)) for fixed (p)
# (if the graph is connected or for the giant component).

# - Your plot should show a slowly increasing curve, roughly resembling a 
# logarithmic function