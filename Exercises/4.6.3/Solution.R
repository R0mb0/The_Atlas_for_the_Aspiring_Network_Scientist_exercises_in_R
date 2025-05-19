# Generate a random vector with 100 normally distributed random
# values (with zero average and standard deviation of one). Implement the MAE and 
# MSE functions and compare their outputs when applied to the vector, by plotting 
# each of them.

set.seed(42)

# Solution

# Generating the vector
x <- rnorm(100, mean = 0, sd = 1)

# Implementing MAE function 
mae <- function(vec) {
  mean(abs(vec))
}

# Implementing MSE function 
mse <- function(vec) {
  mean(vec^2)
}

# Calculating the result
maey <- mae(x)
msey <- mse(x)

# Drawing the plots
barplot(
  c(MAE = maey, MSE = msey),
  main = "Confronto tra MAE e MSE",
  ylab = "Valore dell'errore",
  col = c("blue", "red")
)