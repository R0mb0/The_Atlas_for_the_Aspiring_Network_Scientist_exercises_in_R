# 60% of the emails hitting my inbox is spam. You design a phenomenal
#spam filter which is able to tell me, with 98% accuracy,
#whether an email is spam or not: if an email is not spam, the system
#has a 98% probability of saying so. The filter knows 60% of
#emails are spam and so it will flag 60% of my emails. Suppose
#that, at the end of the week, I look in my spam box and see 963
#emails. Use Bayes’ Theorem to calculate how many of those 963
#emails in my spam box I should suspect to be non-spam.

library(here)

percent <- function(percentValue, value) {
  return((percentValue / 100) * value)
}

totMails <- 963
spamPercent <- 60
filterAccuracyPercent <- 98

# Write here the solution 
