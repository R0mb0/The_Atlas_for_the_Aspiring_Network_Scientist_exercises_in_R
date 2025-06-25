# Draw the degree assortativity plots of the network at http://
# www.networkatlas.eu/exercises/31/1/data.txt using the first
# (edge-centric) and the second (node-centric) strategies explained
# in Section 31.1. For best results, use logarithmic axes and color the
# points proportionally to the logarithmic count of the observations
# with the same values.

library(here)
library(igraph)
library(ggplot2)
library(viridis)

# Loading edge list
edges <- read.table("data.txt")
colnames(edges) <- c("from", "to")

# Building graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Computing node degrees
deg <- degree(g)

# This should be the solution 

# ---------- Edge-centric strategy ----------
# For each edge, get the degrees of the two endpoints
edge_deg_df <- data.frame(
  k1 = deg[as.character(edges$from)],
  k2 = deg[as.character(edges$to)]
)
# Combining both (k1, k2) and (k2, k1) for symmetry
edge_deg_all <- rbind(edge_deg_df, data.frame(k1 = edge_deg_df$k2, k2 = edge_deg_df$k1))

# Counting occurrences for coloring
edge_deg_all$pair <- paste(edge_deg_all$k1, edge_deg_all$k2, sep="-")
edge_deg_all$count <- ave(edge_deg_all$pair, edge_deg_all$pair, FUN=length)

# Plotting the graph
ggplot(edge_deg_all, aes(x=k1, y=k2)) +
  geom_point(aes(color=log10(count)), alpha=0.7, size=2) +
  scale_color_viridis(option="plasma", name="log10(count)") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title="Degree Assortativity Plot (Edge-centric)",
    x="Degree of endpoint 1",
    y="Degree of endpoint 2"
  ) +
  theme_minimal()

# ---------- Node-centric strategy ----------
# For each node, compute k (degree) and k_nn (average neighbor degree)
node_ids <- V(g)$name
k <- deg[node_ids]
k_nn <- sapply(node_ids, function(v) {
  nbs <- neighbors(g, v)
  if (length(nbs) == 0) return(NA)
  mean(deg[nbs$name])
})

node_deg_df <- data.frame(k = k, k_nn = k_nn)
# Removing NA (isolated nodes if any)
node_deg_df <- node_deg_df[!is.na(node_deg_df$k_nn),]

# Counting occurrences for coloring
node_deg_df$pair <- paste(node_deg_df$k, round(node_deg_df$k_nn, 2), sep="-")
node_deg_df$count <- ave(node_deg_df$pair, node_deg_df$pair, FUN=length)

# Ploting the graph 
ggplot(node_deg_df, aes(x=k, y=k_nn)) +
  geom_point(aes(color=log10(count)), alpha=0.7, size=2) +
  scale_color_viridis(option="plasma", name="log10(count)") +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title="Degree Assortativity Plot (Node-centric)",
    x="Node degree (k)",
    y="Avg. neighbor degree (k_nn)"
  ) +
  theme_minimal()
