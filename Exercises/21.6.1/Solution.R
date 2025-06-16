# Modify the SI model developed in the exercises of the previous
# chapter so that it works with a threshold trigger. Set κ = 2 and run
# the threshold trigger on the network at http://www.networkatlas.
# eu/exercises/21/1/data.txt. Show the curves of the size of
# the I state for it (average over 10 runs, each run of 50 steps) and
# compare it with a simple (no reinforcement) SI model with β =
# 0.2.

library(here)
library(igraph)

# Reading the data and remapping the edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# This should be the Solution 

# Threshold SI Model (κ = 2)
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

# Classic SI Model (β = 0.2)
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

# Running simulations and plotting results
steps <- 50
runs <- 10
set.seed(42)

# Threshold SI
thr_mat <- replicate(runs, threshold_SI(g, kappa=2, steps=steps))
thr_mean <- rowMeans(thr_mat)

# Classic SI
si_mat <- replicate(runs, classic_SI(g, beta=0.2, steps=steps))
si_mean <- rowMeans(si_mat)

# Plot
plot(thr_mean, type="l", col="red", lwd=2, ylim=c(0,1),
     ylab="Fraction Infected (I)", xlab="Step", main="Threshold SI vs Classic SI (mean of 10 runs)")
lines(si_mean, col="blue", lwd=2)
legend("bottomright", legend=c("Threshold SI (κ=2)", "Classic SI (β=0.2)"),
       col=c("red", "blue"), lwd=2)

# Interpretation

# Threshold SI (κ = 2): Nodes only become infected if at least 2 neighbors are 
# infected. This usually slows the spread and can sometimes prevent a full 
# outbreak if the initial conditions or the network structure do not allow cascades.

# Classic SI: Any infected neighbor can transmit, so the epidemic grows faster.



# _Comparing the curves:_


# The blue curve (classic SI) typically rises faster and reaches full infection 
# sooner.

# The red curve (threshold SI) often rises more slowly, and sometimes may not 
# reach full infection depending on the network's connectivity.
