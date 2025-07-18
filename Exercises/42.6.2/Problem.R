# Compare the embeddings you obtained from the previous exercise
# with the ones you get by taking the second and third eigenvectors
# of ( I − A) T ( I − A). Which one has the lowest loss according to
# 
# 2
# ∑ Zu − ∑ Zv Auv ?

library(igraph)
library(here)

# Loading the edge list and building the graph
network_data <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)

# Write here the solution