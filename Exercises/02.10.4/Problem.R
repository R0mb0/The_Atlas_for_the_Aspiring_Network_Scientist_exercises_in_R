# Suppose that we are examining a painting and we’re trying to
# date it with the century when it was produced. Find out the Belief
# and Plausibility values for all hypotheses given the following Mass
# estimation (note that, by definition Ω = {XIV, XV, XVI} must have
# Belief and Plausibility equal to one):
#
# Hypothesis  |  Mass    Belief    Plausibility
# ---------------------------------------------
#     ∅       |  0.00
#    XIV      |  0.16 
#    XV       |  0.04
#    XVI      |  0.21
# {XIV, XV}   |  0.34
# {XV, XVI}   |  0.16
# {XIV, XVI}  |  0.08
#     Ω       |  0.01     1            1 

library(here)


# Matrix creation

mat <- matrix(NA, nrow = 8, ncol = 4, 
              dimnames = list(NULL, c("Hypothesis", "Mass", "Belief", "Plausibility")))

mat[1, ] <- c("∅", 0.00, NA, NA)
mat[2, ] <- c("XIV", 0.16, NA, NA)
mat[3, ] <- c("XV", 0.04, NA, NA)
mat[4, ] <- c("XVI", 0.21, NA, NA)
mat[5, ] <- c("{XIV, XV}", 0.34, NA, NA)
mat[6, ] <- c("{XV, XVI}", 0.16, NA, NA)
mat[7, ] <- c("{XIV, XVI}", 0.08, NA, NA)
mat[8, ] <- c("Ω", 0.01, 1, 1)


# write here the solution 

print(mat)