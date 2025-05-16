# Draw the probability mass function and the cumulative 
# distribution of the following outcome probabilities:
#
#   Outcome  |  p
#   -------------
#       1    |  0.1
#       2    |  0.15
#       3    |  0.2
#       4    |  0.21
#       5    |  0.17
#       6    |  0.09
#       7    |  0.06
#       8    |  0.02

library(here)

# Define the outcomes and their probabilities
outcomes <- c(1, 2, 3, 4, 5, 6, 7, 8)
probabilities <- c(0.1, 0.15, 0.2, 0.21, 0.17, 0.09, 0.06, 0.02)

# Plot the Probability Mass Function
plot(outcomes, probabilities, type = "b", col = "blue", lwd = 2,
     main = "Probability Mass Function plot",
     xlab = "Outcomes", ylab = "Probability")
points(outcomes, probabilities, pch = 19, col = "red")

# Compute the Cumulative Distribution Function
cumulative_probabilities <- cumsum(probabilities)

# Plot the Cumulative Distribution Function
plot(outcomes, cumulative_probabilities, type = "s", col = "blue", lwd = 2,
     main = "Cumulative Distribution Function plot",
     xlab = "Outcomes", ylab = "Cumulative Probability")
points(outcomes, cumulative_probabilities, pch = 19, col = "red")
