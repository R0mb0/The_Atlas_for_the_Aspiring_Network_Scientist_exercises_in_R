# The network in http://www.networkatlas.eu/exercises/7/4/
# data.txt is dynamic, the third and fourth columns of the edge
# list tell you the first and last snapshot in which the edge was
# continuously present. An edge can reappear if the edge was
# present in two discontinuous time periods. Aggregate it using a
# disjoint window of size 3.

library(here)
library(igraph)

# Reading the data
dat <- read.table("data.txt", header=FALSE)
colnames(dat) <- c("source", "target", "start", "end")

# Solution 

# Window settings to aggregate edges
window_size <- 3
max_snapshot <- max(dat$end)
windows <- split(1:max_snapshot, ceiling((1:max_snapshot) / window_size))

# For each window, aggregating the network and plot
if (!require(igraph)) install.packages("igraph")
library(igraph)

for (i in seq_along(windows)) {
  wsnap <- windows[[i]]
  wname <- paste0("Snapshots ", min(wsnap), "-", max(wsnap))
  # Selecting edges that are present in at least one snapshot in this window
  present <- dat[
    (dat$start <= max(wsnap)) & (dat$end >= min(wsnap)),
  ]
  cat("\nWindow", i, "(", wname, "):\n")
  print(present[,1:2])
  
################################################################################
# Optional: creating a plot 
  
  if (nrow(present) > 0) {
    g <- graph_from_data_frame(present[,1:2], directed=FALSE)
    plot(g, main=paste("Aggregated network:", wname))
  }
################################################################################
}