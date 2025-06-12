# Do you get larger KS distances if you perform 2, 000 swaps? Do
# you get smaller KS distances if you perform 500?

library(here)
library(igraph)

# Reading data and Creating the graph
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution 

# Function to perform swaps and return KS statistic
ks_for_swaps <- function(g, n_swaps) {
  set.seed(42)
  g_null <- rewire(g, with = keeping_degseq(niter = n_swaps))
  deg_orig <- degree(g)
  deg_null <- degree(g_null)
  ks <- ks.test(deg_orig, deg_null)
  return(ks$statistic)
}

ks_500 <- ks_for_swaps(g, 500)
ks_1000 <- ks_for_swaps(g, 1000)
ks_2000 <- ks_for_swaps(g, 2000)

cat("KS statistic for 500 swaps: ", ks_500, "\n")
cat("KS statistic for 1000 swaps:", ks_1000, "\n")
cat("KS statistic for 2000 swaps:", ks_2000, "\n")