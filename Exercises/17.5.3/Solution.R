# Implement the link selection model to grow the graph in http:
# //www.networkatlas.eu/exercises/17/3/data.txt to 2, 000 nodes
# (for each incoming node, copy 2 edges already present in the net-
# work). Compare the number of edges and the degree distribution
# exponent with a preferential attachment network with 2, 000 nodes
# and average degree of 2.

library(here)
library(igraph)

# Reading the edge list
edges <- read.table("data.txt", header=FALSE)
# Finding all unique node labels and create a mapping to 1:N
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)

# Remapping the edge list
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))

# Building the graph
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution

# Growing with link selection model
set.seed(42)
while (vcount(g) < 2000) {
  new_node <- vcount(g) + 1
  edge_indices <- sample(ecount(g), 2, replace=FALSE)
  ends_mat <- ends(g, edge_indices)
  targets <- apply(ends_mat, 1, function(x) sample(x, 1))
  g <- add_vertices(g, 1)
  g <- add_edges(g, c(rbind(new_node, targets)))
}

# Preferential attachment
g_pa <- sample_pa(n=2000, m=1, directed=FALSE)

# Compare edge counts
cat("Link selection graph edges:", ecount(g), "\n")
cat("Preferential attachment graph edges:", ecount(g_pa), "\n")

# Degree exponents
degree_exp <- function(g) {
  deg <- degree(g)
  tab <- table(deg)
  deg_vals <- as.numeric(names(tab))
  deg_prob <- as.numeric(tab) / sum(tab)
  ccdf <- rev(cumsum(rev(deg_prob)))
  sel <- deg_vals >= 1
  fit <- lm(log(ccdf[sel]) ~ log(deg_vals[sel]))
  gamma <- -coef(fit)[2] + 1
  list(gamma=gamma, deg_vals=deg_vals, ccdf=ccdf, fit=fit)
}
le <- degree_exp(g)
pa <- degree_exp(g_pa)

cat(sprintf("Link selection model degree exponent: %.2f\n", le$gamma))
cat(sprintf("Preferential attachment degree exponent: %.2f\n", pa$gamma))

# Plotting degree distributions
plot(le$deg_vals, le$ccdf, log="xy", col="blue", pch=19,
     xlab="Degree (k)", ylab="CCDF", main="Degree CCDF (log-log)",
     xlim=c(1, max(le$deg_vals, pa$deg_vals)), ylim=c(1e-4, 1))
points(pa$deg_vals, pa$ccdf, col="red", pch=19)
legend("bottomleft", legend=c("Link selection", "Pref. Attach."),
       col=c("blue", "red"), pch=19)