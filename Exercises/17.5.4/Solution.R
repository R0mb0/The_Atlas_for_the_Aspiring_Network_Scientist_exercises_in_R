# Implement the copying model to grow the graph in http://www.
# networkatlas.eu/exercises/17/4/data.txt to 2, 000 nodes (for
# each incoming node, copy one edge from 2 nodes already present
# in the network). Compare the number of edges and the degree
# distribution exponent with networks generated with the strategies
# from the previous two questions.

library(here)
library(igraph)

# Reading and remapping edge list
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution 

# Growing with copying model
set.seed(42)
while (vcount(g) < 2000) {
  new_node <- vcount(g) + 1
  existing_nodes <- sample(1:(new_node-1), 2, replace=FALSE)
  targets <- c()
  for (v in existing_nodes) {
    neighbors_v <- neighbors(g, v)
    if (length(neighbors_v) > 0) {
      tgt <- sample(neighbors_v, 1)
      targets <- c(targets, tgt)
    } else {
      targets <- c(targets, sample(1:(new_node-1), 1))
    }
  }
  g <- add_vertices(g, 1)
  g <- add_edges(g, c(rbind(new_node, targets)))
}

# Preferential attachment
g_pa <- sample_pa(2000, m=1, directed=FALSE)

# Exponent estimation
estimate_exponent <- function(graph) {
  deg <- degree(graph)
  deg_tab <- table(deg)
  deg_vals <- as.numeric(names(deg_tab))
  deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
  ccdf <- rev(cumsum(rev(deg_prob)))
  sel <- deg_vals >= 1
  fit <- lm(log(ccdf[sel]) ~ log(deg_vals[sel]))
  gamma <- -coef(fit)[2] + 1
  list(gamma=gamma, deg_vals=deg_vals, ccdf=ccdf, fit=fit)
}

exp_copy <- estimate_exponent(g)
exp_pa <- estimate_exponent(g_pa)

# Printing the results 

cat("Copying model edges:", ecount(g), "\n")
cat(sprintf("Copying model degree exponent: %.2f\n", exp_copy$gamma))
cat("Pref. attach. model edges:", ecount(g_pa), "\n")
cat(sprintf("Pref. attach. model degree exponent: %.2f\n", exp_pa$gamma))

# Plotting the results
plot(exp_copy$deg_vals, exp_copy$ccdf, log="xy", col="blue", pch=19,
     xlab="Degree (k)", ylab="CCDF", main="Degree CCDF (log-log)",
     xlim=c(1, max(exp_copy$deg_vals, exp_pa$deg_vals)), ylim=c(1e-4, 1))
points(exp_pa$deg_vals, exp_pa$ccdf, col="red", pch=19)
legend("bottomleft", legend=c("Copying model", "Pref. Attach."),
       col=c("blue", "red"), pch=19)