# Generate 50 Gn,m null versions of the network in http://www.
# networkatlas.eu/exercises/19/3/data.txt, respecting the number
# of nodes and edges. Derive the number of standard deviations
# between the observed values and the null average of clustering
# and average path length. (Consider only the largest connected
# component) Which of these two is statistically significant?

library(here)
library(igraph)

# Reading the data and creating the graph 
edges <- read.table("data.txt", header=FALSE)
nodes <- unique(c(edges$V1, edges$V2))
node_map <- setNames(seq_along(nodes), nodes)
edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)

# Solution 

# Largest component
cl <- clusters(g)
giant <- induced_subgraph(g, which(cl$membership == which.max(cl$csize)))
n <- vcount(giant)
m <- ecount(giant)

# Observed stats
obs_clustering <- transitivity(giant, type="global")
obs_path <- average.path.length(giant)

# Null models
null_clustering <- numeric(50)
null_path <- numeric(50)
set.seed(42)
for (i in 1:50) {
  null_g <- erdos.renyi.game(n, m, type="gnm", directed=FALSE)
  comps <- clusters(null_g)
  largest <- induced_subgraph(null_g, which(comps$membership == which.max(comps$csize)))
  null_clustering[i] <- transitivity(largest, type="global")
  null_path[i] <- average.path.length(largest)
}

# Z-scores
mean_clust <- mean(null_clustering)
sd_clust <- sd(null_clustering)
z_clust <- (obs_clustering - mean_clust) / sd_clust

mean_path <- mean(null_path)
sd_path <- sd(null_path)
z_path <- (obs_path - mean_path) / sd_path

cat(sprintf("Observed clustering: %.4f\n", obs_clustering))
cat(sprintf("Null mean clustering: %.4f, SD: %.4f, z-score: %.2f\n", mean_clust, sd_clust, z_clust))
cat(sprintf("Observed avg path: %.4f\n", obs_path))
cat(sprintf("Null mean avg path: %.4f, SD: %.4f, z-score: %.2f\n", mean_path, sd_path, z_path))

################################################################################
# Optional 
# printing a plot of the network 
plot(
  giant,
  vertex.size = 4,
  vertex.label = NA,
  edge.arrow.size = 0.3,
  main = "Largest Connected Component"
)
################################################################################
