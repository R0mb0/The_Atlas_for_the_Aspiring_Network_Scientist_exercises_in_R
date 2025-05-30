# Calculate the density of hypothetical undirected networks with
# the following statistics: |V | = 26, | E| = 180; |V | = 44, | E| = 221;
# |V | = 8, | E| = 201. Which of these networks is an impossible
# topology (unless we allow it to be a multigraph)?

# Defining the statistics
networks <- data.frame(
  V = c(26, 44, 8),
  E = c(180, 221, 201)
)

# Solution 

# Computing densities and checking if each network is a simple graph
networks$density <- with(networks, 2 * E / (V * (V - 1)))
networks$max_edges <- with(networks, V * (V - 1) / 2)
networks$impossible <- networks$E > networks$max_edges

# Printing the result 
print(networks)
