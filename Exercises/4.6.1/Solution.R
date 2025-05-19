# Generate a random vector with 100 normally distributed random
# values (with zero average and standard deviation of one). Imple-
# ment the softmax function. Plot the result with the original vector
# on the x axis and the softmax output on the y axis.

library(here)
set.seed(42)

# Solution

# Generating the vector 
x <- rnorm(100, mean = 0, sd = 1)

# Implementing softmax function
softmax <- function(z) {
  exp_z <- exp(z - max(z)) # For numerical stability
  exp_z / sum(exp_z)
}

y <- softmax(x)

# Drawing the results.
plot(x, y, 
     main = "Softmax Output vs Original Vector", 
     xlab = "Original Values", 
     ylab = "Softmax Output", 
     pch = 19, col = "blue")