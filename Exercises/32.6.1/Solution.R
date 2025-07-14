# Install the cpalgorithm library (sudo pip install cpalgorithm)
# and use it to find the core of the network using the discrete model
# (cpa.BE) and Rombach’s model (cpa.Rombach) on the network
# at http://www.networkatlas.eu/exercises/32/1/data.txt. Use
# the default parameter values. (Warning, Rombach’s method will
# take a while) Assume that Rombach’s method puts in the core all
# nodes with a score higher than 0.75. What is the Jaccard coefficient
# between the cores extracted with the two methods?

library(here)
library(igraph)

# Loading the edge list
edges <- read.table("data.txt", stringsAsFactors = FALSE)
colnames(edges) <- c("from", "to")

# Building the graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Solution

# BE core: maximal k-core
core_numbers <- coreness(g)
be_core <- V(g)[core_numbers == max(core_numbers)]$name

# Rombach core: nodes with normalized coreness > 0.75
norm_core_scores <- core_numbers / max(core_numbers)
rombach_core <- V(g)[norm_core_scores > 0.75]$name

# Jaccard coefficient
intersection <- length(intersect(be_core, rombach_core))
union <- length(union(be_core, rombach_core))
jaccard <- intersection / union

# Printing the solution

cat("BE core size:", length(be_core), "\n")
cat("Rombach core size:", length(rombach_core), "\n")
cat("Jaccard coefficient:", sprintf("%.4f", jaccard), "\n")