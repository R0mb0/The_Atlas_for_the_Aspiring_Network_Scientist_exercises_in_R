# Remove the self-loops and parallel edges from the synthetic
# network you generated in the previous question. Note the % of
# edges you lost. Re-perform the Kolmogorov-Smirnov test with the
# original network’s degree distribution.

library(here)
library(igraph)

# Reading edge list and remapping node IDs
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Creating configuration model with the same degree distribution
deg_seq <- degree(g)
g_conf <- sample_degseq(deg_seq, method="simple")

# Solution 

# Removing self-loops and parallel edges
g_conf_simple <- simplify(g_conf, remove.multiple=TRUE, remove.loops=TRUE)

# Calculating % of edges lost
edges_before <- ecount(g_conf)
edges_after <- ecount(g_conf_simple)
percent_lost <- 100 * (edges_before - edges_after) / edges_before
cat(sprintf("Percentage of edges lost: %.2f%%\n", percent_lost))

# KS test again
deg_g <- degree(g)
deg_conf_simple <- degree(g_conf_simple)
ks2 <- ks.test(deg_g, deg_conf_simple)
print(ks2)

################################################################################
# OptionaL
# Plotting the result
hist(deg_g, breaks=50, col=rgb(0,0,1,0.5), xlim=range(c(deg_g, deg_conf_simple)), 
     xlab="Degree", main="Degree Distributions (Simple)")
hist(deg_conf_simple, breaks=50, col=rgb(1,0,0,0.5), add=TRUE)
legend("topright", legend=c("Original", "Config Model (simple)"), 
       fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
################################################################################