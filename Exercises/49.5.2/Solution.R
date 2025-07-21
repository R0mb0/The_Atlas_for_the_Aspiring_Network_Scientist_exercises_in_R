# Import the community information from http://www.networkatlas.
# eu/exercises/49/2/nodes.txt and use it to set the node color.
# (The solution will be provided as a Cytoscape session file)

library(here)
library(igraph)

# Reading the edge list and building the graph
edges <- read.table(here("data.txt"), header = FALSE)
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Reading the community information
node_community <- read.table(here("nodes.txt"), header = FALSE)
communities <- node_community$V2
names(communities) <- node_community$V1

# Assigning community info to nodes
V(g)$community <- communities[as.character(V(g)$name)]

# Solution 

# Generating a color palette based on the number of unique communities
unique_communities <- sort(unique(communities))
palette <- rainbow(length(unique_communities))

# Mapping the communities to colors
node_color <- palette[match(V(g)$community, unique_communities)]

# Plotting the network with node colors based on community
plot(g, vertex.color = node_color, vertex.label = NA)

# Saving the plot for visual inspection
png(filename = here("network_community_plot.png"))
plot(g, vertex.color = node_color, vertex.label = NA)
dev.off()

# Exporting the graph in a format compatible with Cytoscape
write_graph(g, file = here("network_community_for_cytoscape.graphml"), format = "graphml")