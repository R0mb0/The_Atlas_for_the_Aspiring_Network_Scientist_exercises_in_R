# Calculate the flow hierarchy of the network at http://www.
# networkatlas.eu/exercises/33/1/data.txt. Generate 25 ver-
# sions of the network with the same degree distributions of the
# observed one (use the directed configuration model) and calculate
# how many standard deviations the observed value is above or
# below the average value you obtain from the null model.

library(here)
library(igraph)

# Loading the directed edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = TRUE)

# Solution

# Calculating flow hierarchy
scc <- components(g, mode = "strong")
in_cycle <- unlist(lapply(which(scc$csize > 1), function(i) {
  which(scc$membership == i)
}))
edges_in_cycle <- which(ends(g, E(g))[,1] %in% in_cycle & ends(g, E(g))[,2] %in% in_cycle)
flow_hierarchy <- 1 - length(edges_in_cycle) / gsize(g)
cat(sprintf("Observed flow hierarchy: %.4f\n", flow_hierarchy))

# Null model (directed configuration model)
in_deg <- degree(g, mode = "in")
out_deg <- degree(g, mode = "out")
null_flow_hierarchy <- numeric(25)
for(i in 1:25) {
  g_null <- sample_degseq(out_deg, in_deg, method = "simple.no.multiple")
  scc_null <- components(g_null, mode = "strong")
  in_cycle_null <- unlist(lapply(which(scc_null$csize > 1), function(j) {
    which(scc_null$membership == j)
  }))
  edges_in_cycle_null <- which(ends(g_null, E(g_null))[,1] %in% in_cycle_null &
                                 ends(g_null, E(g_null))[,2] %in% in_cycle_null)
  null_flow_hierarchy[i] <- 1 - length(edges_in_cycle_null) / gsize(g_null)
}

# Z-score calculation
mean_null <- mean(null_flow_hierarchy)
sd_null <- sd(null_flow_hierarchy)
z_score <- (flow_hierarchy - mean_null) / sd_null


# Printing the results
cat(sprintf("Mean null flow hierarchy: %.4f\n", mean_null))
cat(sprintf("Standard deviation of null: %.4f\n", sd_null))
cat(sprintf("Z-score of observed value: %.4f\n", z_score))