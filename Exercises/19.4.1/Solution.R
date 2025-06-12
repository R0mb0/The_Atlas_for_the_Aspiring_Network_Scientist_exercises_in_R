# Perform 1, 000 edge swaps, creating a null version of the network
# in http://www.networkatlas.eu/exercises/19/1/data.txt. Make
# sure you don’t create parallel edges. Calculate the Kolmogorov-
# Smirnov distance between the two degree distributions. Can you
# tell the difference?

library(here)
library(igraph)

# Reading data and create the graph
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution 

# Performing 1,000 edge swaps (null model)
set.seed(42)
g_null <- rewire(g, with = keeping_degseq(niter = 1000))

# Kolmogorov-Smirnov test
deg_orig <- degree(g)
deg_null <- degree(g_null)
ks <- ks.test(deg_orig, deg_null)
cat("Kolmogorov-Smirnov D-statistic:", ks$statistic, "\n")
cat("p-value:", ks$p.value, "\n")

################################################################################
# Optional 
# Creating a graph

hist(deg_orig, breaks=30, col=rgb(0,0,1,0.5), xlim=range(c(deg_orig, deg_null)), 
     main="Degree Distributions", xlab="Degree")
hist(deg_null, breaks=30, col=rgb(1,0,0,0.5), add=TRUE)
legend("topright", legend=c("Original", "Null (1000 swaps)"), 
       fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
################################################################################