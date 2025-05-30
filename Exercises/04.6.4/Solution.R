# Plot the likelihood function for p H and p T for the events { H, H, T, H, T }.

library(here)

seqEvents <- c("H", "H", "T", "H", "T")

# Solution

# Counting the number of two kind of events
numberH <- sum(seqEvents == "H")
numberT <- sum(seqEvents == "T")

# Defining a sequence of probabilities for H
probabilityH <- seq(0, 1, length.out = 100)

# Likelihood function (ignoring constant binomial coefficient)
likelihood <- probabilityH^numberH * (1 - probabilityH)^numberT

# Writing the plot
plot(probabilityH, likelihood, type = "l", lwd = 2, col = "blue",
     xlab = "probabilityH (probability of heads)",
     ylab = "Likelihood",
     main = "Likelihood Function for p_H")
abline(v = numberH / (numberH + numberT), col = "red", lty = 2) # Maximum Likelihood Estimate
legend("topright", legend = "MLE", lty = 2, col = "red")
