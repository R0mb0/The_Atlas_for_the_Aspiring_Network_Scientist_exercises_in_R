# Run a classical SIR model on the network used in the previous
# exercise, but set the recovery probability µ = 0. At each timestep,
# before the infection phase pick a random node. Pick one random
# neighbor in status S, if it has one, and transition it to the R state.
# Compare the I infection curves with and without immunization,
# with β = 0.1 (average over 10 runs, each run of 50 steps).

library(here)
library(igraph)

# Reading the network
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# This should be the solution 

# Classic SIR Model (µ = 0, only infection, no recovery)
classic_SIR <- function(g, beta=0.1, steps=50) {
  N <- vcount(g)
  state <- rep(0, N) # 0 = S, 1 = I, 2 = R
  state[sample(1:N, 1)] <- 1 # Random initial infected
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    new_state <- state
    for (node in which(state == 1)) { # For each infected node
      nbrs <- neighbors(g, node)
      for (nbr in nbrs) {
        nbr_idx <- as.integer(nbr)
        if (state[nbr_idx] == 0 && runif(1) < beta) {
          new_state[nbr_idx] <- 1
        }
      }
    }
    state <- new_state
    I_frac[t] <- mean(state == 1)
    if (all(state != 1)) break # No more infected
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(0, steps - length(I_frac)))
  return(I_frac)
}

# SIR Model With Immunization
SIR_immunization <- function(g, beta=0.1, steps=50) {
  N <- vcount(g)
  state <- rep(0, N) # 0 = S, 1 = I, 2 = R
  state[sample(1:N, 1)] <- 1 # Random initial infected
  I_frac <- numeric(steps)
  for (t in 1:steps) {
    # Immunization phase: pick random node, immunize 1 susceptible neighbor if possible
    chosen <- sample(1:N, 1)
    nbrs <- neighbors(g, chosen)
    s_nbrs <- nbrs[state[as.integer(nbrs)] == 0]
    if (length(s_nbrs) > 0) {
      to_immunize <- sample(s_nbrs, 1)
      state[as.integer(to_immunize)] <- 2
    }
    # Infection phase
    new_state <- state
    for (node in which(state == 1)) {
      nbrs <- neighbors(g, node)
      for (nbr in nbrs) {
        nbr_idx <- as.integer(nbr)
        if (state[nbr_idx] == 0 && runif(1) < beta) {
          new_state[nbr_idx] <- 1
        }
      }
    }
    state <- new_state
    I_frac[t] <- mean(state == 1)
    if (all(state != 1)) break # No more infected
  }
  if (length(I_frac) < steps) I_frac <- c(I_frac, rep(0, steps - length(I_frac)))
  return(I_frac)
}

# Running Simulations and Plotting Results
steps <- 50
runs <- 10
set.seed(42)

# Classic SIR
classic_mat <- replicate(runs, classic_SIR(g, beta=0.1, steps=steps))
classic_mean <- rowMeans(classic_mat)

# SIR with Immunization
immun_mat <- replicate(runs, SIR_immunization(g, beta=0.1, steps=steps))
immun_mean <- rowMeans(immun_mat)

# Plot
plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
     ylab="Fraction Infected (I)", xlab="Step",
     main="SIR Model: With vs Without Immunization (mean of 10 runs)")
lines(immun_mean, col="red", lwd=2)
legend("topright", legend=c("Classic SIR", "SIR with Immunization"),
       col=c("blue", "red"), lwd=2)

# Interpretation

# The red curve (SIR with immunization) should show a noticeably slower and/or 
# smaller epidemic than the blue curve (classic SIR).

# Immunization before the infection phase reduces the number of susceptible 
# nodes, thereby limiting the spread.

