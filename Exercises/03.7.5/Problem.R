# How many bits do we need to independently encode v1 and v2
# from http://www.networkatlas.eu/exercises/3/5/data.txt?
# How much would we save in encoding v1 if we knew v2 ?

library(here)

data <- read.table("data.txt", header = TRUE)

# Write here the solution 