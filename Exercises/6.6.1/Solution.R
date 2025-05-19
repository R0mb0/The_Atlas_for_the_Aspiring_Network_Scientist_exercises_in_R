# Calculate |V | and | E| for the graph in Figure 6.1(c).

library(here)
library(igraph)

# Defining the graph

# Let's label the nodes as 1, 2, 3, 4, 5
# Creating edges
edges <- c(1,2, 1,3, 2,4, 3,4, 4,5)

# Creating the graph
g <- graph(edges=edges, n=5, directed=FALSE)

# Solution

# Calculate |V| and |E|
num_vertices <- vcount(g)
num_edges <- ecount(g)

# Printing the results
cat("|V| (number of nodes):", num_vertices, "\n")
cat("|E| (number of edges):", num_edges, "\n")

# Drawing the graph's plot (optional)
plot(g, 
     vertex.size=30, 
     vertex.color="red", 
     vertex.label=V(g),
     edge.width=3,
     main="Graph from Figure 6.1(c)",
     layout=layout_in_circle)