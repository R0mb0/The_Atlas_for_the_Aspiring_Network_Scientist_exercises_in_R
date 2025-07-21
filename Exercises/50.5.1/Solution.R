# Build on top of you visualization from exercise #2 in Chapter 49.
# Assign to edges a sequential color gradient and a transparency
# proportional to the logarithm of their edge betweenness (the
# higher the edge betweenness the more opaque the edge).

library(here)
library(igraph)

# Loading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Reading the community information
node_community <- read.table(here("nodes.txt"), header = FALSE)
communities <- node_community$V2
names(communities) <- as.character(node_community$V1)

# Assigning a community to each node in the graph
all_communities <- rep(NA, vcount(g))
names(all_communities) <- V(g)$name
for (i in V(g)$name) {
  if (!is.na(communities[i])) {
    all_communities[i] <- communities[i]
  } else {
    all_communities[i] <- 0
  }
}

# Setting the community attribute for all nodes
V(g)$community <- all_communities

# Solution 

# Generating a color palette for communities
unique_communities <- sort(unique(V(g)$community))
palette <- rainbow(length(unique_communities))
node_color <- palette[match(V(g)$community, unique_communities)]

# Calculating edge betweenness
eb <- edge_betweenness(g)

# Scaling edge betweenness logarithmically for transparency
edge_alpha <- log(eb + 1)
edge_alpha <- (edge_alpha - min(edge_alpha)) / (max(edge_alpha) - min(edge_alpha))
edge_alpha <- 0.2 + edge_alpha * 0.8

# Creating a sequential color gradient for edges
num_edges <- ecount(g)
edge_palette <- colorRampPalette(c("blue", "red"))(num_edges)

# Assigning colors and transparency to edges
edge_colors <- sapply(1:num_edges, function(i) {
  rgb_val <- col2rgb(edge_palette[i])
  rgb(rgb_val[1]/255, rgb_val[2]/255, rgb_val[3]/255, alpha = edge_alpha[i])
})

E(g)$color <- edge_colors

# Plotting the network with node colors and edge gradient/transparency
plot(g, vertex.color = node_color, vertex.label = NA, edge.width = 2, edge.color = E(g)$color)

# Saving the plot for visual inspection
png(filename = here("network_edge_betweenness_gradient.png"))
plot(g, vertex.color = node_color, vertex.label = NA, edge.width = 2, edge.color = E(g)$color)
dev.off()

# Exporting the graph in a format compatible with Cytoscape
write_graph(g, file = here("network_edge_gradient_for_cytoscape.graphml"), format = "graphml")