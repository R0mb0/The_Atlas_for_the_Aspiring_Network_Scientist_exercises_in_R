# You’re given the directed signed network at http://www.networkatlas.
# eu/exercises/24/2/data.txt. Does this network follow social bal-
# ance or social status? (Consider only reciprocal edges. For social
# balance, the reciprocal edges should have the same sign. For social
# status they should have opposite signs)

library(here)

# Reading the data
edges <- read.table("data.txt", header=FALSE, col.names=c("from", "to", "sign"))
edges[] <- lapply(edges, as.character)
edges$sign <- as.numeric(edges$sign)

# Write here the solution