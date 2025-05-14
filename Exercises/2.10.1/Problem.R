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

# Matrix creation

mat <- matrix(NA, nrow = 5, ncol = 6, 
              dimnames = list(NULL, c("p1(H)", "p2(H)", "H-H", "H-T", "T-H", "T-T")))

mat[1, ] <- c(0.5, 0.5, NA, NA, NA, NA)
mat[2, ] <- c(0.6, 0.7, NA, NA, NA, NA)
mat[3, ] <- c(0.4, 0.8, NA, NA, NA, NA)
mat[4, ] <- c(0.1, 0.2, NA, NA, NA, NA)
mat[5, ] <- c(0.3, 0.4, NA, NA, NA, NA)

# Write here the solution 

print(mat)


