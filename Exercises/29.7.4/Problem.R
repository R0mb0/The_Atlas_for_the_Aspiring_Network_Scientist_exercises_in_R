# Modify your random walk sampler so that it applied the Metropolis-
# Hastings correction. Is the estimation of the exponent of the CCDF
# more precise? Is MHRW more or less precise than RWRW?

library(here)
library(igraph)

# Load the network
edges <- read.table(here("data.txt"), header = FALSE)
colnames(edges) <- c("from", "to")
g <- graph_from_data_frame(edges, directed = FALSE)

# Write here the solution