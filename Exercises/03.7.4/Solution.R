# Which correlation coefficient should you use to calculate the corre-
# lation between the variables used in the exercise 2? Motivate your
# answer by calculating covariance, and the Pearson and Spearman
#correlation coefficients (and their p-values). Does the Spearman
# correlation coefficient agree with the Pearson correlation calculated
# on log-transformed values?

library(here)

data <- read.table("data.txt", header = TRUE)

# Solution

# Calculating the covariance
covariance <- cov(data$x, data$y)
cat("Covariance: ", covariance, "\n") # 673232178181

# Calculating the Pearson correlation
pearson <- cor.test(data$x, data$y, method = "pearson")
cat("Pearson's correlation coefficient: ", pearson$estimate, "\n") # 0.4437232
cat("Pearson's p-value: ", pearson$p.value, "\n") # 0.003246258

# Calculating the Spearman correlation
spearman <- cor.test(data$x, data$y, method = "spearman")
cat("Spearman's correlation coefficient: ", spearman$estimate, "\n")# 0.7392432
cat("Spearman's p-value: ", spearman$p.value, "\n")# 1.723284e-07 

# Pearson is not preferable because the data is highly skewed so the Spearman is 
# best the correlation coefficient

# Pearson on log-transformed values
log_x <- log(data$x)
log_y <- log(data$y)

pearson_log <- cor.test(log_x, log_y, method = "pearson")
cat("Pearson's correlation on log-transformed values:", pearson_log$estimate, "p-value:", pearson_log$p.value, "\n")# 0.8280876 - 1.323059e-11

# The Spearman correlation coefficient agree with the Pearson correlation because the values are close