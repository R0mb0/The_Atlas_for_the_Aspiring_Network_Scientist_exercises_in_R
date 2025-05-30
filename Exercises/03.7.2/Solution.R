# Make a scatter plot of the variables used in the previous exercise
# – with one variable on the x axis and the other on the y axis. Do
# you think that they are skewed or not? Calculate their skewness to
# motivate your answer.

library(here)
library(e1071)

data <- read.table("data.txt", header = TRUE)

# Solution

# writing the plot 
plot(data$x, data$y, 
     main = "Scatter Plot", 
     xlab = "X Values", 
     ylab = "Y Values", 
     pch = 19,      # Solid circle points
     col = "blue")  # Point color

# Calculating the skewness
skewX <- skewness(data$x)
skewY <- skewness(data$y)

print(skewX)
print(skewY)

# skewX = 1.817525
# skewY = 3.984962
# The variables are skewed because their distribution is is right-skewed
