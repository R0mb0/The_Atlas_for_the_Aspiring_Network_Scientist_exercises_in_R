# Consider the network at http://www.networkatlas.eu/exercises/
# 28/1/data.txt. This is an undirected probabilistic network with
# four columns: the two connected nodes, the probability of the edge
# existing and the probability of the edge non existing. Generate all
# of its possible worlds, together with their probability of existing.
# (Note, you can ignore the fourth column for this exercise)

library(here)
library(igraph)

#Reading the data
edges <- read.table("data.txt", header=FALSE)
colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
edges$p_exist <- as.numeric(edges$p_exist)

n_edges <- nrow(edges)
n_worlds <- 2^n_edges

# Solution 

# Generating all possible worlds
worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
colnames(worlds) <- paste0("edge", 1:n_edges)

# Computing probabilities and pretty print
cat("Possible worlds (edges present = 1, absent = 0) and their probabilities:\n\n")

for(i in 1:nrow(worlds)) {
  world <- as.numeric(worlds[i,])
  # For each edge, use p if present, (1-p) if absent
  probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
  prob_world <- prod(probs)
  present_edges <- paste0("[", edges$node1[world==1], "-", edges$node2[world==1], "]", collapse=" ")
  absent_edges <- paste0("[", edges$node1[world==0], "-", edges$node2[world==0], "]", collapse=" ")
  cat(sprintf(
    "World %2d: Present: %-20s  Absent: %-20s  P=%.4f\n",
    i, ifelse(present_edges=="", "(none)", present_edges),
    ifelse(absent_edges=="", "(none)", absent_edges),
    prob_world
  ))
}

################################################################################
# Optional

# Plotting the probabilistic network with edge widths proportional to probability
g <- graph_from_data_frame(edges[,1:2], directed=FALSE)
E(g)$weight <- edges$p_exist
E(g)$label <- round(edges$p_exist, 2)

set.seed(1)
plot(
  g,
  edge.width = 3 + 7*E(g)$weight,
  edge.label = E(g)$label,
  edge.color = "darkgray",
  vertex.size = 30,
  vertex.label.color = "black",
  vertex.color = "skyblue",
  main = "Probabilistic Network (edge label = probability, width ∝ probability)"
)
################################################################################