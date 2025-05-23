# Calculate the degree of the nodes for both node types in the
# bipartite adjacency matrix from Figure 9.5(a). Find the isolated
# node(s).

library(igraph)

# Bipartite adjacency matrix
A <- matrix(c(
  0,0,1,0,0,0,0,1,
  0,0,0,0,1,1,0,0,
  0,1,1,0,1,0,0,0,
  0,0,0,1,0,0,1,0,
  1,0,0,0,0,0,0,1,
  0,0,0,1,1,0,0,0,
  0,0,1,1,0,0,1,0,
  0,0,0,0,0,0,1,0
), nrow=8, byrow=TRUE)

# Solution 

# Degree for type 1 nodes (rows)
degree_type1 <- rowSums(A)

# Degree for type 2 nodes (columns)
degree_type2 <- colSums(A)

cat("Degree of type 1 nodes (rows):\n")
print(degree_type1)

cat("\nDegree of type 2 nodes (columns):\n")
print(degree_type2)

# Finding isolated nodes
isolated_type1 <- which(degree_type1 == 0)
isolated_type2 <- which(degree_type2 == 0)

cat("\nIsolated type 1 nodes (rows):", if(length(isolated_type1) == 0) "none" else isolated_type1, "\n")
cat("Isolated type 2 nodes (columns):", if(length(isolated_type2) == 0) "none" else isolated_type2, "\n")

################################################################################
# Optional generating a graph

g <- graph_from_incidence_matrix(A)

V(g)$color <- ifelse(V(g)$type, "skyblue", "orange")

plot(
  g,
  vertex.label=NA,
  vertex.size=25,
  layout=layout_as_bipartite,
  main="Bipartite Graph from Figure 9.5(a)"
)
################################################################################