# Suppose:
#
#  A=(1 0)
#     0 2
#
#  B=(3 0)
#     0 -1
#
#  Are these two transformations commutative? Does applying A
#  first and B second lead to the same transformation as applying B
#  first and A second?

library(here)

# Defining the matrices
A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)

# Write here the solution