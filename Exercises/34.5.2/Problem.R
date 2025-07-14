# Run an SI model with simple contagion on the simplicial complex
# rom the previous exercise. The seed node is node 0. Run it for all
# possible combinations of β 1 from 0.1 to 0.9 (in 0.1 increments) and
# for β 2 = {0.0, 0.25, 0.5}. Make 100 independent runs and average
# the results. Visualize the ratio of infected nodes after 3 steps for
# each process – like in Figure 34.7.

library(here)

# Loading the edge list
edges <- read.table("data.txt")
nodes <- unique(c(edges$V1, edges$V2))

# Write here the solution 