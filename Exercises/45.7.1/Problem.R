# Implement a simple attention mechanism by replacing the
# ˆD−1/2(I + A) ˆD−1/2 term from the function you developed in the
# exercises of the previous chapter. The new α term comes from the
# edge weights in the third column of the network at http://www.
# networkatlas.eu/exercises/45/1/network.txt. The features are
# at http://www.networkatlas.eu/exercises/45/1/features.txt.
# Then run it on that network. (For the purposes of this and the
# following exercises, you can use a completely random W)

library(here)

# Reading the network data
network_data <- read.table(here("network.txt"), header = FALSE)
# Reading the features data
features <- as.matrix(read.table(here("features.txt"), header = FALSE))

# Write here the solution 