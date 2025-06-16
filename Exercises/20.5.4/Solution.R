# Extend your SI model to an SIR. With β = 0.2, run the model for
# 400 steps with µ values of 0.01, 0.02, and 0.04 and plot the share of
# nodes in the Removed state for both the networks used in Q1 and
# Q2. How quickly does it converge to a full R state network?

library(here)  
library(igraph)
  
# Loading data and remapping the first network 
edges1 <- read.table("data1.txt", header=FALSE)
nodes1 <- unique(c(edges1$V1, edges1$V2))
map1 <- setNames(seq_along(nodes1), nodes1)
edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)

# Loading data and remapping the second network 
edges2 <- read.table("data2.txt", header=FALSE)
nodes2 <- unique(c(edges2$V1, edges2$V2))
map2 <- setNames(seq_along(nodes2), nodes2)
edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)

# This should be the Solution 

# Creating SIR Simulation Function
SIR_simulation <- function(g, beta, mu, steps=400) {
  N <- vcount(g)
  # 0 = S, 1 = I, 2 = R
  state <- rep(0, N)
  state[sample(1:N, 1)] <- 1 # Start with 1 random infected
  removed_frac <- numeric(steps)
  
  for (t in 1:steps) {
    new_state <- state
    for (node in 1:N) {
      if (state[node] == 1) { # Infected
        # Try to infect susceptible neighbors
        nbrs <- neighbors(g, node)
        for (nbr in nbrs) {
          nbr_idx <- as.integer(nbr)
          if (state[nbr_idx] == 0 && runif(1) < beta) {
            new_state[nbr_idx] <- 1
          }
        }
        # Try to recover
        if (runif(1) < mu) {
          new_state[node] <- 2 # Removed
        }
      }
    }
    state <- new_state
    removed_frac[t] <- mean(state == 2)
    # Optional: Breaking if all infected are gone
    if (sum(state == 1) == 0) break
  }
  # Filling remaining with final value if ended early
  if (t < steps) removed_frac[(t+1):steps] <- removed_frac[t]
  return(removed_frac)
}

# Running and Plotting for All Parameters
betas <- 0.2
mus <- c(0.01, 0.02, 0.04)
steps <- 400
n_runs <- 10 # For averaging

par(mfrow=c(2,1))
set.seed(42)

# For each network
for (net_idx in 1:2) {
  g <- if (net_idx == 1) g1 else g2
  netname <- if (net_idx == 1) "Network 1" else "Network 2"
  
  plot(NULL, xlim=c(1, steps), ylim=c(0, 1), type="n",
       xlab="Time step", ylab="Fraction Removed",
       main=paste0(netname, ": SIR, beta=0.2"))
  
  cols <- c("blue", "red", "green")
  legend_labels <- character()
  
  for (i in seq_along(mus)) {
    mu <- mus[i]
    removed_mat <- matrix(NA, nrow=n_runs, ncol=steps)
    for (r in 1:n_runs) {
      removed_mat[r,] <- SIR_simulation(g, beta=betas, mu=mu, steps=steps)
    }
    avg_removed <- colMeans(removed_mat)
    lines(avg_removed, col=cols[i], lwd=2)
    legend_labels <- c(legend_labels, sprintf("mu=%.2f", mu))
  }
  legend("bottomright", legend=legend_labels, col=cols, lwd=2)
}

# Interpretation


# The plot shows, for each (\mu), how quickly the network approaches the full R 
# (Removed) state (i.e., everyone recovered).

# Faster convergence = steeper/faster rise in curve.

# Compare across (\mu): higher recovery ((\mu)) generally leads to fewer people 
# infected at the same time, but the R fraction still eventually reaches 1 if the 
# network is well connected.

# Time to full R: Look for when the curve first reaches 1 (or very close).

# You may find that the power-law network converges faster or slower depending 
# on its structure (hubs accelerate infections, but may also get depleted 
# quickly).
