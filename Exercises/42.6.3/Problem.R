# Compare the embeddings you obtained from the previous two
# exercises with the ones you get by taking the first two eigenvectors
# of D −1/2 LD −1/2 . Which one has the lowest loss according to
# 1
# 2
# ∑ ( Zu − Zv ) Auv ?

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Write here the solution 