# Generate a configuration model with the same degree distribution
# as the network in http://www.networkatlas.eu/exercises/18/1/
# data.txt. Perform the Kolmogorov-Smirnov test between the two
# degree distributions.

library(here)
library(igraph)

# Reading edge list and remapping node IDs
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution

# Creating configuration model with the same degree distribution
deg_seq <- degree(g)
g_conf <- sample_degseq(deg_seq, method="simple")

# Kolmogorov-Smirnov test
deg_g <- degree(g)
deg_conf <- degree(g_conf)
ks <- ks.test(deg_g, deg_conf)
print(ks)

################################################################################
# OptionaL
# Plotting the graph
hist(deg_g, breaks=50, col=rgb(0,0,1,0.5), xlim=range(c(deg_g, deg_conf)), 
     xlab="Degree", main="Degree Distributions")
hist(deg_conf, breaks=50, col=rgb(1,0,0,0.5), add=TRUE)
legend("topright", legend=c("Original", "Config Model"), fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
################################################################################