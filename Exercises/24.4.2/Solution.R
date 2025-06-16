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

# Solution 

# Finding reciprocal edges
reciprocals <- merge(edges, edges, by.x=c("from","to"), by.y=c("to","from"),
                     suffixes=c("_fwd","_rev"))
# Removing self-loops if any
reciprocals <- reciprocals[reciprocals$from != reciprocals$to, ]
# To avoid double-counting, keep only pairs where from_fwd < to_fwd lexicographically
reciprocals <- reciprocals[as.character(reciprocals$from) < as.character(reciprocals$to), ]

# Counting types
n_same_sign <- sum(reciprocals$sign_fwd == reciprocals$sign_rev)
n_opp_sign <- sum(reciprocals$sign_fwd == -reciprocals$sign_rev)
n_total <- nrow(reciprocals)
n_neither <- n_total - n_same_sign - n_opp_sign

# Printig the results

cat(sprintf("Total reciprocal pairs: %d\n", n_total))
cat(sprintf("Same sign (social balance): %d (%.1f%%)\n", n_same_sign, 100*n_same_sign/n_total))
cat(sprintf("Opposite sign (social status): %d (%.1f%%)\n", n_opp_sign, 100*n_opp_sign/n_total))
cat(sprintf("Neither: %d (%.1f%%)\n", n_neither, 100*n_neither/n_total))

# Simple conclusion
if (n_same_sign > n_opp_sign) {
  cat("Conclusion: The network is more consistent with **social balance**.\n")
} else if (n_opp_sign > n_same_sign) {
  cat("Conclusion: The network is more consistent with **social status**.\n")
} else {
  cat("Conclusion: The network is equally consistent with both or neither.\n")
}