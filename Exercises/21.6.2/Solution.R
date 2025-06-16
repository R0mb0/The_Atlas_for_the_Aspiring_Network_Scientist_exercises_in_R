# Modify the SI model developed in the previous exercise so that
# it works with a cascade trigger. Set β = 0.1 and compare the I
# infection curves for the three triggers on the network used in the
# previous exercise (average over 10 runs, each run of 50 steps).

library(here)
library(igraph)

# Read and remap the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# this should be the Solution 

# Classic SI (probabilistic trigger, β)
classic_SI <- function(g, beta=0.2, steps=50) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  infected[sample(1:N, 1)] <- TRUE
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    new_infected <- infected
    for (node in which(infected)) {
      nbrs <- neighbors(g, node)
      for (nbr in nbrs) {
        nbr_idx <- as.integer(nbr)
        if (!infected[nbr_idx] && runif(1) < beta) {
          new_infected[nbr_idx] <- TRUE
        }
      }
    }
    infected <- new_infected
    I_frac[t] <- mean(infected)
    if (all(infected)) break
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
  return(I_frac)
}

# Threshold SI (κ = 2)
threshold_SI <- function(g, kappa=2, steps=50) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  infected[sample(1:N, 1)] <- TRUE
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    new_infected <- infected
    for (node in which(!infected)) {
      nbrs <- neighbors(g, node)
      if (sum(infected[as.integer(nbrs)]) >= kappa) {
        new_infected[node] <- TRUE
      }
    }
    infected <- new_infected
    I_frac[t] <- mean(infected)
    if (all(infected)) break
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
  return(I_frac)
}

# Cascade SI (each susceptible node with at least one infected neighbor becomes 
# infected with probability β)
cascade_SI <- function(g, beta=0.1, steps=50) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  infected[sample(1:N, 1)] <- TRUE
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    new_infected <- infected
    for (node in which(!infected)) {
      nbrs <- neighbors(g, node)
      if (any(infected[as.integer(nbrs)])) {
        if (runif(1) < beta) {
          new_infected[node] <- TRUE
        }
      }
    }
    infected <- new_infected
    I_frac[t] <- mean(infected)
    if (all(infected)) break
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
  return(I_frac)
}

# Running 10 Simulations and Averaging for Each Model
steps <- 50
runs <- 10
set.seed(42)

# Classic SI (β=0.2 as before)
classic_mat <- replicate(runs, classic_SI(g, beta=0.2, steps=steps))
classic_mean <- rowMeans(classic_mat)

# Threshold SI (κ=2)
threshold_mat <- replicate(runs, threshold_SI(g, kappa=2, steps=steps))
threshold_mean <- rowMeans(threshold_mat)

# Cascade SI (β=0.1)
cascade_mat <- replicate(runs, cascade_SI(g, beta=0.1, steps=steps))
cascade_mean <- rowMeans(cascade_mat)

# Plotting and Comparing Infection Curves
plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
     ylab="Fraction Infected (I)", xlab="Step", main="SI Model Comparison (mean of 10 runs)")
lines(threshold_mean, col="red", lwd=2)
lines(cascade_mean, col="darkgreen", lwd=2)
legend("bottomright",
       legend=c("Classic SI (β=0.2)", "Threshold SI (κ=2)", "Cascade SI (β=0.1)"),
       col=c("blue", "red", "darkgreen"), lwd=2)

# Interpretation


# Classic SI: Any infected neighbor can transmit; spread is typically fastest.

# Threshold SI: Infection requires at least κ infected neighbors; spread is 
# typically slowest.

# Cascade SI: Any susceptible node with at least one infected neighbor can become
# infected with probability β; spread is intermediate (β-dependent).

# The curves will show you which mechanism leads to faster or slower spread, and 
# how the final epidemic size differs.