# Implement a MPGNN as a series of matrix operations, imple-
# 
# menting H l = σ D̂ −1/2 ( I + A) D̂ −1/2 H l −1 , with σ being
# softmax. Apply it to the network at http://www.networkatlas.
# eu/exercises/44/3/network.txt, with node features at http:
# //www.networkatlas.eu/exercises/44/3/features.txt. Compare
# its running time with the MPGNN you implemented in the first ex-
# ercise, running each for 20 layers and making several runs noting
# down the average running time.

library(here)
library(Matrix)
library(microbenchmark)

# Loading the node features
features <- as.matrix(read.table(here("features.txt")))

# Loading the edge list
edges <- as.matrix(read.table(here("network.txt")))

# Write here the solution 