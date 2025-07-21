# Which network layout is more suitable to visualize the network at
# http://www.networkatlas.eu/exercises/51/1/data.txt? Choose
# between hierarchical, force directed, and circular. Visualize it using
# all three alternatives and motivate your answer based on the result
# and the characteristics of the network.

library(here)
library(igraph)

# Loading the edge list from the file
edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
colnames(edges) <- c("from", "to")

# Building the graph object
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution

# Plotting the network using hierarchical layout
# Using the Reingold-Tilford tree layout for hierarchical visualization
layout_hierarchical <- layout_as_tree(g)
plot(g, layout=layout_hierarchical, main="Hierarchical Layout")

# Plotting the network using force-directed layout
# Applying the Fruchterman-Reingold algorithm
layout_force <- layout_with_fr(g)
plot(g, layout=layout_force, main="Force-directed Layout")

# Plotting the network using circular layout
layout_circular <- layout_in_circle(g)
plot(g, layout=layout_circular, main="Circular Layout")

# Motivating the choice of layout
# Hierarchical layouts are best for networks with clear parent-child or layered structures, which is not apparent here.
# Circular layouts are good for showing cycles and equal importance, but may clutter when there are many edges or hubs.
# Force-directed layouts are usually most suitable for general networks, as they help reveal clusters and hubs. 
# In this network, the presence of nodes with many connections (like node 26 and 27) is better highlighted with the force-directed layout,
# making it easier to see central nodes and overall structure.