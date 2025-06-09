# Generate a connected caveman graph with 10 cliques, each with
# 10 nodes. Generate a small world graph with 100 nodes, each
# connected to 8 of their neighbors. Add shortcuts for each edge
# with probability of .05. The two graphs have approximately the
# same number of edges. Compare their clustering coefficients and
# their average path lengths.

library(here)
library(igraph)

##################### Making graphs #####################
# g_cave <- make_connected_caveman(10, 10) # Error at this line, but 

# Parameters
num_cliques <- 10
clique_size <- 10

# Create empty graph
g_cave <- make_empty_graph(n = 0, directed = FALSE)

# Add cliques one by one
for (i in 0:(num_cliques-1)) {
  # Each clique's nodes
  nodes <- (i*clique_size + 1):((i+1)*clique_size)
  clique <- make_full_graph(clique_size)
  # Relabel the clique to correct node numbers
  clique <- set_vertex_attr(clique, "name", value=as.character(nodes))
  # Union with the main graph
  g_cave <- g_cave %u% clique
}

# Connect each clique to the next by rewiring one edge
for (i in 1:(num_cliques-1)) {
  g_cave <- add_edges(g_cave, c(i*clique_size, i*clique_size + 1))
}

# last graph 
g_sw <- sample_smallworld(dim=1, size=100, nei=4, p=0.05)

#####################               #####################

# Solution 

# Edge counting (for comparison)
cat("Caveman edges:", ecount(g_cave), "\n")
cat("Small world edges:", ecount(g_sw), "\n")

# Clustering coefficients
cc_cave <- transitivity(g_cave, type="global")
cc_sw   <- transitivity(g_sw, type="global")

# Average path lengths
apl_cave <- average.path.length(g_cave)
apl_sw   <- average.path.length(g_sw)

cat("Caveman clustering coefficient:", cc_cave, "\n")
cat("Small world clustering coefficient:", cc_sw, "\n")
cat("Caveman average path length:", apl_cave, "\n")
cat("Small world average path length:", apl_sw, "\n")

################################################################################
# Optional:
# Plotting both graphs side by side

par(mfrow=c(1,2), mar=c(1,1,2,1))
plot(g_cave,
     vertex.size=5,
     vertex.label=NA,
     edge.arrow.size=0.5,
     layout=layout_with_fr,
     main="Connected Caveman Graph")
plot(g_sw,
     vertex.size=5,
     vertex.label=NA,
     edge.arrow.size=0.5,
     layout=layout_with_fr,
     main="Small World Graph")
par(mfrow=c(1,1))
################################################################################