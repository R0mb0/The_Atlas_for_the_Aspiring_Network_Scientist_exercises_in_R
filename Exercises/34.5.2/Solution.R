# Run an SI model with simple contagion on the simplicial complex
# rom the previous exercise. The seed node is node 0. Run it for all
# possible combinations of β 1 from 0.1 to 0.9 (in 0.1 increments) and
# for β 2 = {0.0, 0.25, 0.5}. Make 100 independent runs and average
# the results. Visualize the ratio of infected nodes after 3 steps for
# each process – like in Figure 34.7.

library(here)

# Loading the edge list
edges <- read.table("data.txt")
nodes <- unique(c(edges$V1, edges$V2))

# Solution

# Building adjacency list and triangle list
adj <- lapply(nodes, function(n) unique(c(edges$V2[edges$V1==n], edges$V1[edges$V2==n])))
names(adj) <- nodes

# Finding all triangles in the graph
triangles <- list()
for (i in 1:nrow(edges)) {
  a <- edges[i, 1]; b <- edges[i, 2]
  inter <- intersect(adj[[as.character(a)]], adj[[as.character(b)]])
  if (length(inter) > 0) {
    for (c in inter) {
      tri <- sort(c(a, b, c))
      triangles[[paste(tri, collapse = "-")]] <- tri
    }
  }
}
tri_list <- unique(triangles)

# SI simulation function
si_run <- function(beta1, beta2) {
  infected <- rep(FALSE, length(nodes))
  names(infected) <- nodes
  infected["0"] <- TRUE
  for (step in 1:3) {
    new_inf <- infected
    # Edge infection
    for (i in nodes[infected]) {
      for (j in adj[[as.character(i)]]) {
        if (!infected[as.character(j)] && runif(1) < beta1) {
          new_inf[as.character(j)] <- TRUE
        }
      }
    }
    # Triangle infection
    for (tri in tri_list) {
      tri_infected <- infected[as.character(tri)]
      if (sum(tri_infected) == 2) {
        target <- tri[!tri_infected]
        if (!infected[as.character(target)] && runif(1) < beta2) {
          new_inf[as.character(target)] <- TRUE
        }
      }
    }
    infected <- new_inf
  }
  mean(infected)
}

beta1_vals <- seq(0.1, 0.9, by=0.1)
beta2_vals <- c(0.0, 0.25, 0.5)
results <- matrix(0, nrow=length(beta1_vals), ncol=length(beta2_vals))
rownames(results) <- beta1_vals
colnames(results) <- beta2_vals

# Running the simulations
set.seed(42)
for (i in seq_along(beta1_vals)) {
  for (j in seq_along(beta2_vals)) {
    vals <- replicate(100, si_run(beta1_vals[i], beta2_vals[j]))
    results[i, j] <- mean(vals)
  }
}

# Visualizing the results
library(ggplot2)
df <- expand.grid(beta1=beta1_vals, beta2=beta2_vals)
df$infected_ratio <- as.vector(results)
ggplot(df, aes(x=beta1, y=beta2, fill=infected_ratio)) +
  geom_tile() +
  scale_fill_viridis_c() +
  labs(x = expression(beta[1]), y = expression(beta[2]), fill="Infected ratio") +
  ggtitle("Fraction of infected nodes after 3 steps (SI model)")