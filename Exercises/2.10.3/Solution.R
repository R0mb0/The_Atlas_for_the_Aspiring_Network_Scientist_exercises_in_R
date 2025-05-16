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

# Solution

# separating the char in the strings for text
text <- strsplit(text, "")[[1]]

# It is possible to ignore the data because the exercise tells that 
# every letter (from the international alphabet) is shifted 7 * 3 positions forward, 
# considering a circular alphabet.
# Given that the alphabet consists of 26 letters, and the total shift is 21, 
# we only need to shift 5 positions forward to interpret the text.

# creating the alphabet
alphabet <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", 
              "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")

# creating a function to decrypt from the alphabet
Decrypt <- function(letter){
  index <- which(alphabet == letter)
  newIndex <- index + 5
  if(newIndex > 26){
    return(alphabet[newIndex - 26])
  }else{
    return(alphabet[newIndex])
  }
}

# initialing the solution variable
solutionText <- ""

# Decryption 
for(l in text){
  if(l == " "){
    solutionText <- paste(solutionText, " ")
  }else{
    solutionText <- paste(solutionText, Decrypt(l))
  }
}

# print the solution 
print(solutionText)




