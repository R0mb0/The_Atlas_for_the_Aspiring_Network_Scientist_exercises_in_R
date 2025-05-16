# Suppose you’re tossing two coins at the same time. They’re loaded
# in different ways, according to the table below. Calculate the
# probability of getting all possible outcomes:

#p1(H)  p2(H) | H-H  H-T  T-H  T-T
#---------------------------------
# 0.5    0.5  |
# 0.6    0.7  |
# 0.4    0.8  |
# 0.1    0.2  |
# 0.3    0.4  |

library(here)

# Matrix creation

mat <- matrix(NA, nrow = 5, ncol = 6, 
              dimnames = list(NULL, c("p1(H)", "p2(H)", "H-H", "H-T", "T-H", "T-T")))

mat[1, ] <- c(0.5, 0.5, NA, NA, NA, NA)
mat[2, ] <- c(0.6, 0.7, NA, NA, NA, NA)
mat[3, ] <- c(0.4, 0.8, NA, NA, NA, NA)
mat[4, ] <- c(0.1, 0.2, NA, NA, NA, NA)
mat[5, ] <- c(0.3, 0.4, NA, NA, NA, NA)

# Solution -> Using the formula:  P ( A ∩ B ) = P ( A ) ⋅ P ( B ) 

for (r in 1:nrow(mat)) {
  mat[r,3] <- mat[r,1] * mat[r,2]
  mat[r,4] <- mat[r,2] * (1 - mat[r,2])
  mat[r,5] <- (1 - mat[r,1]) * mat[r,2]
  mat[r,6] <- (1 - mat[r,1]) * (1 - mat[r,2])
}

print(mat)


