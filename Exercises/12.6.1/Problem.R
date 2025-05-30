# Calculate the density of hypothetical undirected networks with
# the following statistics: |V | = 26, | E| = 180; |V | = 44, | E| = 221;
# |V | = 8, | E| = 201. Which of these networks is an impossible
# topology (unless we allow it to be a multigraph)?

# Defining the statistics
networks <- data.frame(
  V = c(26, 44, 8),
  E = c(180, 221, 201)
)

# Write here the solution