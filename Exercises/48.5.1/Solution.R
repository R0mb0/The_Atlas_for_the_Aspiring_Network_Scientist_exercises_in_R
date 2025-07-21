# Estimate the similarity between the networks at http://www.
# networkatlas.eu/exercises/48/1/data1.txt, http://www.networkatlas.
# eu/exercises/48/1/data2.txt, and http://www.networkatlas.
# eu/exercises/48/1/data3.txt, by comparing their average degree,
# average clustering coefficient, and density (average their absolute
# differences). Which pair of networks are more similar to each
# other?

library(here)
library(igraph)

# Loading the edge list and building the graph for data1.txt
g1 <- read.table(here("data1.txt"))
g1 <- as.matrix(g1)
# Converting to character to avoid negative/invalid vertex ids
g1_char <- apply(g1, 2, as.character)
graph1 <- graph_from_edgelist(g1_char, directed = FALSE)

# Loading the edge list and building the graph for data2.txt
g2 <- read.table(here("data2.txt"))
g2 <- as.matrix(g2)
g2_char <- apply(g2, 2, as.character)
graph2 <- graph_from_edgelist(g2_char, directed = FALSE)

# Loading the edge list and building the graph for data3.txt
g3 <- read.table(here("data3.txt"))
g3 <- as.matrix(g3)
g3_char <- apply(g3, 2, as.character)
graph3 <- graph_from_edgelist(g3_char, directed = FALSE)

# Solution 

# Calculating the average degree for each network
avg_deg1 <- mean(degree(graph1))
avg_deg2 <- mean(degree(graph2))
avg_deg3 <- mean(degree(graph3))

# Calculating the average clustering coefficient for each network
clustering1 <- transitivity(graph1, type = "average")
clustering2 <- transitivity(graph2, type = "average")
clustering3 <- transitivity(graph3, type = "average")

# Calculating the density for each network
density1 <- edge_density(graph1)
density2 <- edge_density(graph2)
density3 <- edge_density(graph3)

# Calculating the absolute differences for each pair
diff12 <- mean(abs(c(avg_deg1 - avg_deg2, clustering1 - clustering2, density1 - density2)))
diff13 <- mean(abs(c(avg_deg1 - avg_deg3, clustering1 - clustering3, density1 - density3)))
diff23 <- mean(abs(c(avg_deg2 - avg_deg3, clustering2 - clustering3, density2 - density3)))

# Printing the similarity results
print(paste("Average absolute difference between Network 1 and 2:", diff12))
print(paste("Average absolute difference between Network 1 and 3:", diff13))
print(paste("Average absolute difference between Network 2 and 3:", diff23))

# Indicating the most similar pair
if(diff12 <= diff13 & diff12 <= diff23){
  print("Network 1 and Network 2 are the most similar.")
} else if(diff13 <= diff12 & diff13 <= diff23){
  print("Network 1 and Network 3 are the most similar.")
} else{
  print("Network 2 and Network 3 are the most similar.")
}