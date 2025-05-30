# Generate a random vector with 100 normally distributed random
# values (with zero average and standard deviation of one). Imple-
# ment the ReLU function. Plot the result with the original vector on
# the x axis and the ReLU output on the y axis.

library(here)
set.seed(42)

# Solution

# Generating the vector 
x <- rnorm(100, mean = 0, sd = 1)

# Implementing the ReLu function
relu <- function(z) {
  pmax(0, z)
}

y <- relu(x)

# Drawing the result 
plot(x, y,
     main = "ReLU Output vs Original Vector",
     xlab = "Original Values",
     ylab = "ReLU Output",
     pch = 19, col = "blue")