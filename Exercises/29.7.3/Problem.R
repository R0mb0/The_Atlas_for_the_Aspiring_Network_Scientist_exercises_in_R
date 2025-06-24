# Modify the degree distribution of your sample using the Re-
# Weighted Random Walk technique. Is the estimation of the expo-
# nent of the CCDF more precise?

library(here)
library(igraph)

# Loading the network
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

################################################################################
# Helper Functions

# Compute CCDF: for unweighted histogram
compute_ccdf <- function(degrees) {
  tab <- table(degrees)
  degs <- as.numeric(names(tab))
  freq <- as.numeric(tab)
  prob <- freq / sum(freq)
  ccdf <- rev(cumsum(rev(prob)))
  data.frame(degree = degs, ccdf = ccdf)
}
################################################################################

# Write here the solution