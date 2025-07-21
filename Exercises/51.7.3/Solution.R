# Which network layout is more suitable to visualize the network at
# http://www.networkatlas.eu/exercises/51/3/data.txt? Choose
# between hierarchical, force directed, and circular. Visualize it using
# all three alternatives and motivate your answer based on the result
# and the characteristics of the network.

library(here)
library(igraph)

# Loading the edge list
edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed=FALSE)

# Solution 

# Plotting using hierarchical layout
layout_hierarchical <- layout_as_tree(g)
plot(g, layout=layout_hierarchical, main="Hierarchical Layout")

# Plotting using force-directed layout
layout_force <- layout_with_fr(g)
plot(g, layout=layout_force, main="Force-directed Layout")

# Plotting using circular layout
layout_circular <- layout_in_circle(g)
plot(g, layout=layout_circular, main="Circular Layout")

# Motivating the choice of layout
# Looking at the result, the hierarchical layout does not clearly show the structure because the network is not tree-like.
# Observing the circular layout, it is less effective in highlighting central nodes or clusters in this network.
# Viewing the force-directed layout, it best reveals the overall structure and shows the central connections and clusters, making it the most suitable for this network.