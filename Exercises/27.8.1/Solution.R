# Plot the CCDF edge weight distribution of the network at http:
# //www.networkatlas.eu/exercises/27/1/data.txt. Calculate its
# average and standard deviation. NOTE: this is a directed graph!

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
colnames(edges) <- c("from", "to", "weight")

# Creating a directed, weighted graph
g <- graph_from_data_frame(edges, directed=TRUE)

# Extract edge weights
w <- E(g)$weight

# Solution 

# Computing average and standard deviation of edge weights
w_mean <- mean(w)
w_sd <- sd(w)
cat(sprintf("Average edge weight: %.2f\n", w_mean))
cat(sprintf("Standard deviation of edge weights: %.2f\n", w_sd))

# Computing CCDF
w_sorted <- sort(w)
ccdf <- 1 - ecdf(w_sorted)(w_sorted) + 1/length(w_sorted)

################################################################################
# Optional 

# Plotting CCDF (log-log scale, typical for weight distributions)
plot(
  w_sorted, ccdf,
  log="xy",
  type="s",
  xlab="Edge weight",
  ylab="CCDF",
  main="CCDF of Edge Weights"
)
grid()

legend(
  "bottomleft",
  legend=c(
    sprintf("Mean = %.2f", w_mean),
    sprintf("SD = %.2f", w_sd)
  ),
  bty="n"
)
################################################################################