# Run the same SI model on the network at http://www.networkatlas.
# eu/exercises/20/2/data.txt as well. One of the two networks is
# a Gn,p graph while the other has a power law degree distribution.
# Can you tell which is which by how much the disease takes to
# infect 80% of the network for the same starting conditions used in
# the previous question?

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

# Solution 

# Creating SI Model Function
SI_simulation <- function(g, beta, target_frac=0.8) {
  N <- vcount(g)
  infected <- rep(FALSE, N)
  patient_zero <- sample(1:N, 1)
  infected[patient_zero] <- TRUE
  t <- 0
  num_infected <- 1
  while (num_infected < target_frac * N) {
    t <- t + 1
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
    if (sum(new_infected) == num_infected) break
    infected <- new_infected
    num_infected <- sum(infected)
  }
  return(t)
}

# Running SI Simulations on Both Networks
set.seed(42)
betas <- c(0.05, 0.1, 0.2)
results1 <- data.frame(beta=betas, avg_time=NA)
results2 <- data.frame(beta=betas, avg_time=NA)

for (j in seq_along(betas)) {
  b <- betas[j]
  times1 <- times2 <- numeric(10)
  for (i in 1:10) {
    times1[i] <- SI_simulation(g1, b, target_frac=0.8)
    times2[i] <- SI_simulation(g2, b, target_frac=0.8)
  }
  results1$avg_time[j] <- mean(times1)
  results2$avg_time[j] <- mean(times2)
}

# Printing the results
print("Network 1 (data1.txt) - avg time to 80% infected:")
print(results1)
print("Network 2 (data2.txt) - avg time to 80% infected:")
print(results2)

# How do you tell which network is which?
  
# _Gn,p (Erdős–Rényi random graph):_
#  More homogeneous degree distribution.
#  SI infection spreads moderately fast.

# _Power law (scale-free) network:_
# Some nodes (hubs) have very high degree.
# SI infection spreads much faster (especially for larger β), as hubs accelerate the process.

# So:

# The network where the disease spreads faster (lower average time to 80% infected) is the power law (scale-free) network.
# The network where it takes longer is the random (Gn,p) network.
