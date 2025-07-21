# Import the network at http://www.networkatlas.eu/exercises/
# 49/1/data.txt, calculate the nodes’ degrees and use them to set
# the node size. Make sure you scale it logarithmically. This can be
# performed entirely via Cytoscape. (The solution will be provided
# as a Cytoscape session file)

library(here)
library(igraph)

# Reading the edge list from the local file
edges <- read.table(here("data.txt"), header = FALSE)

# Building the network graph from the edge list
g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)

# Solution 

# Calculating the degree of each node
deg <- degree(g)

# Scaling the node size logarithmically
node_size <- log(deg + 1)

# Plotting the network with node sizes based on the log-scaled degrees
plot(g, vertex.size = node_size, vertex.label = NA)

# Saving the plot for visual inspection
png(filename = here("network_degree_plot.png"))
plot(g, vertex.size = node_size, vertex.label = NA)
dev.off()

# Exporting the graph in a format compatible with Cytoscape
write_graph(g, file = here("network_for_cytoscape.graphml"), format = "graphml")