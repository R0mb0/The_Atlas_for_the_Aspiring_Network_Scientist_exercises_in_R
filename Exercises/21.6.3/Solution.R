# Modify the simple SI model so that nodes become resistant after
# the second failed infection attempt. Compare the I infection curves
# of the SI model before and after this operation on the network
# used in the previous exercise, with β = 0.3 (average over 10 runs,
# each run of 50 steps).

library(here)
library(igraph)

# Read and remap the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# This should be the Solution 

# Classic SI Model
classic_SI <- function(g, beta=0.3, steps=50) {
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

# Modified SI Model with Resistance after 2 Failed Attempts
resist_SI <- function(g, beta=0.3, steps=50) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  resistant <- rep(FALSE, N)
  failed_attempts <- rep(0, N)
  infected[sample(1:N, 1)] <- TRUE
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    new_infected <- infected
    new_resistant <- resistant
    new_failed <- failed_attempts
    for (node in which(infected)) {
      nbrs <- neighbors(g, node)
      for (nbr in nbrs) {
        nbr_idx <- as.integer(nbr)
        if (!infected[nbr_idx] && !resistant[nbr_idx]) {
          if (runif(1) < beta) {
            new_infected[nbr_idx] <- TRUE
          } else {
            new_failed[nbr_idx] <- new_failed[nbr_idx] + 1
            if (new_failed[nbr_idx] >= 2) {
              new_resistant[nbr_idx] <- TRUE
            }
          }
        }
      }
    }
    infected <- new_infected
    resistant <- new_resistant
    failed_attempts <- new_failed
    I_frac[t] <- mean(infected)
    if (all(infected | resistant)) break
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
  return(I_frac)
}

# Running Simulations and Plotting Results
steps <- 50
runs <- 10
set.seed(42)

# Classic SI
classic_mat <- replicate(runs, classic_SI(g, beta=0.3, steps=steps))
classic_mean <- rowMeans(classic_mat)

# Modified SI with resistance
resist_mat <- replicate(runs, resist_SI(g, beta=0.3, steps=steps))
resist_mean <- rowMeans(resist_mat)

# Plot
plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
     ylab="Fraction Infected (I)", xlab="Step",
     main="SI vs SI with Resistance after 2 Failed Attempts (mean of 10 runs)")
lines(resist_mean, col="red", lwd=2)
legend("bottomright", legend=c("Classic SI", "Resistant after 2 fails"),
       col=c("blue", "red"), lwd=2)

# Interpretation


# The classic SI curve (blue) will typically rise quickly and reach 1 
# (full infection).

# The resistance SI curve (red) will generally rise more slowly and may plateau 
# below 1, as some nodes become resistant and never get infected.
