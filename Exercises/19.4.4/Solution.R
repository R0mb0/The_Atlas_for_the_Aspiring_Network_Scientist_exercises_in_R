# Repeat the experiment in the previous question, but now generate
# 50 Watts-Strogatz small world models, with the same number of
# nodes as the original network and setting k = 16 and p = 0.1.

library(here)
library(igraph)

# Reading the data and building the graph 
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

# Observed stats
obs_clustering <- transitivity(giant, type="global")
obs_path <- average.path.length(giant)

# Watts-Strogatz null models
ws_clustering <- numeric(50)
ws_path <- numeric(50)
set.seed(42)
for (i in 1:50) {
  ws_g <- sample_smallworld(dim=1, size=n, nei=8, p=0.1) # k=16 -> nei=8
  comps <- clusters(ws_g)
  largest <- induced_subgraph(ws_g, which(comps$membership == which.max(comps$csize)))
  ws_clustering[i] <- transitivity(largest, type="global")
  ws_path[i] <- average.path.length(largest)
}

# Z-scores
mean_clust <- mean(ws_clustering)
sd_clust <- sd(ws_clustering)
z_clust <- (obs_clustering - mean_clust) / sd_clust

mean_path <- mean(ws_path)
sd_path <- sd(ws_path)
z_path <- (obs_path - mean_path) / sd_path

cat(sprintf("Observed clustering: %.4f\n", obs_clustering))
cat(sprintf("WS mean clustering: %.4f, SD: %.4f, z-score: %.2f\n", mean_clust, sd_clust, z_clust))
cat(sprintf("Observed avg path: %.4f\n", obs_path))
cat(sprintf("WS mean avg path: %.4f, SD: %.4f, z-score: %.2f\n", mean_path, sd_path, z_path))

################################################################################
# Optional 
# Plotting the graph
plot(
  giant,
  vertex.size = 4,
  vertex.label = NA,
  edge.arrow.size = 0.3,
  main = "Largest Connected Component"
)
################################################################################