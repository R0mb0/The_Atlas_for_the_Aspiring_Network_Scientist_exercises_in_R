# Write the degree sequence of the graph in Figure 9.7. First consid-
# ering all layers at once, then separately for each layer.

library(igraph)

nodes <- as.character(1:9)

# Edge lists for each layer/color (example, adapt if you see differences!)
edges_brown <- matrix(c(1,3, 3,2, 2,4, 3,4, 6,8, 6,9), ncol=2, byrow=TRUE)
edges_green <- matrix(c(1,4, 4,5, 5,8, 4,7, 8,9), ncol=2, byrow=TRUE)
edges_blue  <- matrix(c(2,5, 5,7, 6,9), ncol=2, byrow=TRUE)
edges_orange<- matrix(c(1,2, 2,5, 7,8, 7,6, 6,9), ncol=2, byrow=TRUE)
edges_purple<- matrix(c(2,5, 5,7, 5,6, 6,8), ncol=2, byrow=TRUE)
edges_red   <- matrix(c(1,3, 4,5), ncol=2, byrow=TRUE)

# Write here the solution