# How many bits do we need to independently encode v1 and v2
# from http://www.networkatlas.eu/exercises/3/5/data.txt?
# How much would we save in encoding v1 if we knew v2 ?

library(here)
library(entropy)

data <- read.table("data.txt", header = TRUE)

# Solution

# Calculating the entropy of v1 & v2 

# Function to compute entropy for a vector
get_entropy <- function(vec) {
  tab <- table(vec)
  probs <- tab / sum(tab)
  entropy.empirical(probs, unit = "log2")
}

H_v1 <- get_entropy(data$v1)

cat("Entropy of v1:", H_v1, "bits\n")

# Calculating the conditional entropy of v1 & v2 
get_conditional_entropy <- function(x, y) {
  tab <- table(x, y)
  joint_probs <- tab / sum(tab)
  cond_entropy <- 0
  for (j in 1:ncol(tab)) {
    p_y <- sum(joint_probs[, j])
    if (p_y > 0) {
      cond_entropy <- cond_entropy + p_y * entropy.empirical(joint_probs[, j] / p_y, unit = "log2")
    }
  }
  return(cond_entropy)
}

H_v1_given_v2 <- get_conditional_entropy(data$v1, data$v2)
cat("Conditional entropy H(v1|v2):", H_v1_given_v2, "bits\n")

# Calculating the bits saved
bits_saved <- H_v1 - H_v1_given_v2
cat("Bits saved in encoding v1 if v2 is known:", bits_saved, "bits\n")