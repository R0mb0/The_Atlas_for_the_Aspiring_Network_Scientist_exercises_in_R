#You’re given the string: “OCZ XJMMZXO VINRZM”. Each letter
#follows a stochastic Markov process with the rules expressed by
#the table at http://www.networkatlas.eu/exercises/2/3/data.
#txt. Follow the process for three steps and reconstruct the correct
#answer. (Note, this is a Caesar cipher12 with shift 7 applied three
#times, because the Caesar cipher is a Markov process).

library(here)

text <- "OCZ XJMMZXO VINRZM"
data <- readLines(here("data.txt"))

# removing the first line
data <- data[-1]

# removing "/t"
data <- sapply(data, function(line) gsub("\t", "", line))

# Write here the solution 


