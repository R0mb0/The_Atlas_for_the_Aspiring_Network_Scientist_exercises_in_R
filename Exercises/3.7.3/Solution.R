#Draw the mass function and the cumulative distribution of the
#following outcome probabilities:

#  Outcome  |    P
#  ----------------
#    1      |    0.1
#    2      |    0.15
#    3      |    0.2
#    4      |    0.21
#    5      |    0.17
#    6      |    0.09
#    7      |    0.06
#    8      |    0.02

Outcome <- 1:8
P <- c(0.1, 0.15, 0.2, 0.21, 0.17, 0.09, 0.06, 0.02)

# Solution

# Drawing the mass function 
barplot(P, names.arg = Outcome, 
        xlab = "Outcome", 
        ylab = "Probability", 
        main = "Mass Function",
        col = "blue")

# Drawing the cumulative distribution

# Calculate the cumulative distribution 
cum_p <- cumsum(p)

# Draw the graph
plot(Outcome, cum_p, type = "s", 
     xlab = "Outcome", 
     ylab = "Cumulative Probability", 
     main = "Cumulative Distribution Function",
     col = "blue", lwd = 2)
points(Outcome, cum_p, pch = 19, col = "red")