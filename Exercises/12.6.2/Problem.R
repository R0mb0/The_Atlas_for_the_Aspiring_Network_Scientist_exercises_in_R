# Calculate the density of hypothetical directed networks with the
# following statistics: |V | = 15, | E| = 380; |V | = 77, | E| = 391;
# |V | = 101, | E| = 566. Which of these networks is an impossible
# topology (unless we allow it to be a multigraph)?

# Defining network statistics
networks <- data.frame(
  V = c(15, 77, 101),
  E = c(380, 391, 566)
)

# Write here the solution