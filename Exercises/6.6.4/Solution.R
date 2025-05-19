# Draw a correlation network for the vectors in http://www.networkatlas.
# eu/exercises/6/4/data.txt, by only drawing edges with positive
# weights, ignoring self loops.

library(here)
library(igraph)

# reading the data
dat <- read.table("data.txt", header=TRUE)

# Computing the correlation matrix
corr <- cor(dat)

# Getting indices for upper triangle (to prevent duplicates and ignore self-loops)
edge_list <- which(corr > 0 & upper.tri(corr), arr.ind = TRUE)

# Extracting the edge pairs and weights
edges <- data.frame(
  from = colnames(corr)[edge_list[,1]],
  to   = colnames(corr)[edge_list[,2]],
  weight = corr[edge_list]
)

# Creating the graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Drawing the graph's plot
plot(
  g,
  edge.width = edges$weight * 5,      # Make edge width proportional, tweak multiplier for visibility
  edge.label = round(edges$weight,2), # Show rounded correlation values as labels
  vertex.label.cex = 1.2,
  vertex.size = 30,
  vertex.color = "red",
  main = "Correlation Network (Positive Correlations Only)"
)