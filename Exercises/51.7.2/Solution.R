# Which network layout is more suitable to visualize the network at
# http://www.networkatlas.eu/exercises/51/2/data.txt? Choose
# between hierarchical, force directed, and circular. You might
# want to use the node attributes at http://www.networkatlas.
# eu/exercises/51/2/nodes.txt to enhance your visualization.
# Visualize it using all three alternatives and motivate your answer
# based on the result and the characteristics of the network.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
colnames(edges) <- c("from", "to")

# Loading the node attributes
nodes <- read.table(here("nodes.txt"), sep="\t", header=FALSE)
colnames(nodes) <- c("name", "region")

# Building the graph
g <- graph_from_data_frame(edges, vertices=nodes, directed=FALSE)

# Solution 

# Assigning colors to regions for visualization
regions <- unique(nodes$region)
region_colors <- setNames(rainbow(length(regions)), regions)
V(g)$color <- region_colors[V(g)$region]

# Plotting the network using hierarchical layout
# Using a tree layout for hierarchical visualization
layout_hierarchical <- layout_as_tree(g)
plot(g, layout=layout_hierarchical, main="Hierarchical Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)

# Plotting the network using force-directed layout
layout_force <- layout_with_fr(g)
plot(g, layout=layout_force, main="Force-directed Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)

# Plotting the network using circular layout
layout_circular <- layout_in_circle(g)
plot(g, layout=layout_circular, main="Circular Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)

# Motivating the choice of layout
# Using the hierarchical layout shows a branching structure, but this network is not a clear hierarchy.
# Using the circular layout helps display all nodes around a circle but makes it harder to see clusters or central nodes.
# Using the force-directed layout reveals the hub structure and clusters by region, especially with node colors.
# Concluding that the force-directed layout is the most suitable for showing central nodes and regional groupings in this network.