# Extend your SI model to an SIS. With β = 0.2, run the model
# with µ values of 0.05, 0.1, and 0.2 on both networks used in the
# previous questions. Run the SIS model, with a random node as a
# starting Infected set, for 100 steps and plot the share of nodes in
# the Infected state. For which of these values and networks do you
# have an endemic state? How big is the set of nodes in state I com-
# pared to the number of nodes in the network? (Note, randomness
# might affect your results. Run the experiment multiple times)

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

# Creating SI Model Function
SIS_simulation <- function(g, beta, mu, steps=100) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  # Start with one random infected node
  infected[sample(1:N, 1)] <- TRUE
  infected_fraction <- numeric(steps)
  
  for (t in 1:steps) {
    new_infected <- infected
    for (node in 1:N) {
      if (infected[node]) {
        # Recovery
        if (runif(1) < mu) {
          new_infected[node] <- FALSE
        }
      } else {
        # Infection from infected neighbors
        nbrs <- neighbors(g, node)
        infected_nbrs <- sum(infected[as.integer(nbrs)])
        if (infected_nbrs > 0) {
          prob_infection <- 1 - (1 - beta)^infected_nbrs
          if (runif(1) < prob_infection) {
            new_infected[node] <- TRUE
          }
        }
      }
    }
    infected <- new_infected
    infected_fraction[t] <- mean(infected)
  }
  return(infected_fraction)
}

# Running and Plotting for All Parameters
betas <- 0.2
mus <- c(0.05, 0.1, 0.2)
steps <- 100
n_runs <- 10 # For averaging

results <- list()
set.seed(42)

for (net_idx in 1:2) {
  g <- if (net_idx==1) g1 else g2
  netname <- if (net_idx==1) "Network 1" else "Network 2"
  for (mu in mus) {
    infected_mat <- matrix(NA, nrow=n_runs, ncol=steps)
    for (r in 1:n_runs) {
      infected_mat[r,] <- SIS_simulation(g, beta=betas, mu=mu, steps=steps)
    }
    avg_infected <- colMeans(infected_mat)
    results[[paste0(netname, "_mu_", mu)]] <- avg_infected
    
    # Plotting 
    plot(avg_infected, type="l", ylim=c(0,1), lwd=2,
         main=sprintf("%s SIS: beta=%.2f, mu=%.2f", netname, betas, mu),
         xlab="Time step", ylab="Fraction infected")
    abline(h=0.8, col="red", lty=2)
    legend("topright", legend=sprintf("mu=%.2f", mu), lwd=2)
  }
}

# Analysing (Endemic State)
for (nm in names(results)) {
  frac <- results[[nm]][steps]
  cat(sprintf("%s: End fraction infected = %.2f (%d nodes out of %d)\n",
              nm, frac, round(frac * ifelse(grepl("Network 1", nm), vcount(g1), vcount(g2))),
              ifelse(grepl("Network 1", nm), vcount(g1), vcount(g2))))
}