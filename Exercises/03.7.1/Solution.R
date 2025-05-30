#Calculate the mean, median, and standard deviation of the two
#variables at http://www.networkatlas.eu/exercises/3/1/data.
#txt (one variable per column).

library(here)

data <- read.table("data.txt", header = TRUE)

# Calculating the mean
meanX <- mean(data$x)
meanY <- mean(data$y)

# Calculating the median 
medianX <- median(data$x)
medianY <- median(data$y)

# Calculating the standard deviation
SDX <- sd(data$x)
SDY <- sd(data$y)

# Print the results

print(meanX)
print(meanY)
print(medianX)
print(medianY)
print(SDX)
print(SDY)