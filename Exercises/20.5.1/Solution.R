# Implement an SI model on the network at http://www.networkatlas.
# eu/exercises/20/1/data.txt. Run it 10 times with different β values:
# 0.05, 0.1, and 0.2. For each run (in this and all following
# questions) pick a random node and place it in the Infected state.
# What’s the average time step in which each of those β infects 80%
# of the network?

library(here)
library(igraph)

# Reading the data and build the graph 
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
N <- vcount(g)

# Solution 

# SI simulation function
SI_simulation <- function(g, beta, target_frac=0.8) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  # Random initial infected node
  patient_zero <- sample(1:N, 1)
  infected[patient_zero] <- TRUE
  t <- 0
  num_infected <- 1
  while (num_infected < target_frac * N) {
    t <- t + 1
    new_infected <- infected
    # For each infected node, infect susceptible neighbors with probability beta
    for (node in which(infected)) {
      nbrs <- neighbors(g, node)
      for (nbr in nbrs) {
        nbr_idx <- as.integer(nbr)
        if (!infected[nbr_idx] && runif(1) < beta) {
          new_infected[nbr_idx] <- TRUE
        }
      }
    }
    if (sum(new_infected) == num_infected) break # no more infections
    infected <- new_infected
    num_infected <- sum(infected)
  }
  return(t)
}

# Run simulations for each beta
betas <- c(0.05, 0.1, 0.2)
results <- data.frame(beta=numeric(), avg_time=numeric())
set.seed(123)

# Printing the results 

for (b in betas) {
  times <- numeric(10)
  for (i in 1:10) {
    times[i] <- SI_simulation(g, b, target_frac=0.8)
  }
  avg_t <- mean(times)
  cat(sprintf("Beta = %.2f: average time to 80%% infected = %.2f (over 10 runs)\n", b, avg_t))
  results <- rbind(results, data.frame(beta=b, avg_time=avg_t))
}

print(results)