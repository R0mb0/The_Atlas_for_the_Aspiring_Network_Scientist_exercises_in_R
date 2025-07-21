
<details>
<summary>

## 02.10.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Suppose you’re tossing two coins at the same time. They’re loaded
    # in different ways, according to the table below. Calculate the
    # probability of getting all possible outcomes:
    
    #p1(H)  p2(H) | H-H  H-T  T-H  T-T
    #---------------------------------
    # 0.5    0.5  |
    # 0.6    0.7  |
    # 0.4    0.8  |
    # 0.1    0.2  |
    # 0.3    0.4  |
    
    library(here)
    
    # Matrix creation
    
    mat <- matrix(NA, nrow = 5, ncol = 6, 
                  dimnames = list(NULL, c("p1(H)", "p2(H)", "H-H", "H-T", "T-H", "T-T")))
    
    mat[1, ] <- c(0.5, 0.5, NA, NA, NA, NA)
    mat[2, ] <- c(0.6, 0.7, NA, NA, NA, NA)
    mat[3, ] <- c(0.4, 0.8, NA, NA, NA, NA)
    mat[4, ] <- c(0.1, 0.2, NA, NA, NA, NA)
    mat[5, ] <- c(0.3, 0.4, NA, NA, NA, NA)
    
    # Write here the solution 
    
    print(mat)
    
    

```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Suppose you’re tossing two coins at the same time. They’re loaded
    # in different ways, according to the table below. Calculate the
    # probability of getting all possible outcomes:
    
    #p1(H)  p2(H) | H-H  H-T  T-H  T-T
    #---------------------------------
    # 0.5    0.5  |
    # 0.6    0.7  |
    # 0.4    0.8  |
    # 0.1    0.2  |
    # 0.3    0.4  |
    
    library(here)
    
    # Matrix creation
    
    mat <- matrix(NA, nrow = 5, ncol = 6, 
                  dimnames = list(NULL, c("p1(H)", "p2(H)", "H-H", "H-T", "T-H", "T-T")))
    
    mat[1, ] <- c(0.5, 0.5, NA, NA, NA, NA)
    mat[2, ] <- c(0.6, 0.7, NA, NA, NA, NA)
    mat[3, ] <- c(0.4, 0.8, NA, NA, NA, NA)
    mat[4, ] <- c(0.1, 0.2, NA, NA, NA, NA)
    mat[5, ] <- c(0.3, 0.4, NA, NA, NA, NA)
    
    # Solution -> Using the formula:  P ( A ∩ B ) = P ( A ) ⋅ P ( B ) 
    
    for (r in 1:nrow(mat)) {
      mat[r,3] <- mat[r,1] * mat[r,2]
      mat[r,4] <- mat[r,2] * (1 - mat[r,2])
      mat[r,5] <- (1 - mat[r,1]) * mat[r,2]
      mat[r,6] <- (1 - mat[r,1]) * (1 - mat[r,2])
    }
    
    print(mat)
    
    

```

</details>

</details>

<details>
<summary>

## 02.10.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

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

```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
    spamPercent <- 60 / 100
    filterAccuracyPercent <- 98 / 100
    
    # Solution applying Bayes’ Theorem 
    
    # P(A|B) = P(B|A) * P(A)
    #          -------------
    #               P(B)
    
    # Where P(B|A)
    PBA <- 1 - (98 / 100)
    
    # Where P(A)
    PA <- 40 / 100
    
    # Where P(B) (applying the law of total probability)
    PB <- (((60 / 100) * (98 / 100)) + ((1 - (98 / 100)) * (1 - (60 / 100))))
    
    # Total probability
    TB <- PBA * PA / PB
    
    legitMailsInSpam <- signif((963 * TB), 2)
    
    print(legitMailsInSpam)

```

</details>

</details>

<details>
<summary>

## 02.10.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

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
    
    

```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
    
    
    
    

```

</details>

</details>

<details>
<summary>

## 02.10.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Suppose that we are examining a painting and we’re trying to
    # date it with the century when it was produced. Find out the Belief
    # and Plausibility values for all hypotheses given the following Mass
    # estimation (note that, by definition Ω = {XIV, XV, XVI} must have
    # Belief and Plausibility equal to one):
    #
    # Hypothesis  |  Mass    Belief    Plausibility
    # ---------------------------------------------
    #     ∅       |  0.00
    #    XIV      |  0.16 
    #    XV       |  0.04
    #    XVI      |  0.21
    # {XIV, XV}   |  0.34
    # {XV, XVI}   |  0.16
    # {XIV, XVI}  |  0.08
    #     Ω       |  0.01     1            1 
    
    library(here)
    
    
    # Matrix creation
    
    mat <- matrix(NA, nrow = 8, ncol = 4, 
                  dimnames = list(NULL, c("Hypothesis", "Mass", "Belief", "Plausibility")))
    
    mat[1, ] <- c("∅", 0.00, NA, NA)
    mat[2, ] <- c("XIV", 0.16, NA, NA)
    mat[3, ] <- c("XV", 0.04, NA, NA)
    mat[4, ] <- c("XVI", 0.21, NA, NA)
    mat[5, ] <- c("{XIV, XV}", 0.34, NA, NA)
    mat[6, ] <- c("{XV, XVI}", 0.16, NA, NA)
    mat[7, ] <- c("{XIV, XVI}", 0.08, NA, NA)
    mat[8, ] <- c("Ω", 0.01, 1, 1)
    
    
    # write here the solution 
    
    print(mat)
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Suppose that we are examining a painting and we’re trying to
    # date it with the century when it was produced. Find out the Belief
    # and Plausibility values for all hypotheses given the following Mass
    # estimation (note that, by definition Ω = {XIV, XV, XVI} must have
    # Belief and Plausibility equal to one):
    #
    # Hypothesis  |  Mass    Belief    Plausibility
    # ---------------------------------------------
    #     ∅       |  0.00
    #    XIV      |  0.16 
    #    XV       |  0.04
    #    XVI      |  0.21
    # {XIV, XV}   |  0.34
    # {XV, XVI}   |  0.16
    # {XIV, XVI}  |  0.08
    #     Ω       |  0.01     1            1 
    
    library(here)
    
    
    # Matrix creation
    
    mat <- matrix(NA, nrow = 8, ncol = 4, 
                  dimnames = list(NULL, c("Hypothesis", "Mass", "Belief", "Plausibility")))
    
    mat[1, ] <- c("∅", 0.00, NA, NA)
    mat[2, ] <- c("XIV", 0.16, NA, NA)
    mat[3, ] <- c("XV", 0.04, NA, NA)
    mat[4, ] <- c("XVI", 0.21, NA, NA)
    mat[5, ] <- c("{XIV, XV}", 0.34, NA, NA)
    mat[6, ] <- c("{XV, XVI}", 0.16, NA, NA)
    mat[7, ] <- c("{XIV, XVI}", 0.08, NA, NA)
    mat[8, ] <- c("Ω", 0.01, 1, 1)
    
    
    # To calculate the Belief is necessary sum all masses of subsets contained in 
    #the hypothesis.
    
    # To calculate the Plausibility is necessary sum all masses of subsets that have 
    # a non-empty intersection with the hypothesis.
    
    # Calculating the Belief
    
    mat[1,3] <- mat[1,2]
    mat[2,3] <- mat[2,2]
    mat[3,3] <- mat[3,2]
    mat[4,3] <- mat[4,2]
    mat[5,3] <- as.numeric(mat[2,2]) + as.numeric(mat[3,2]) + as.numeric(mat[5,2])
    mat[6,3] <- as.numeric(mat[3,2]) + as.numeric(mat[4,2]) + as.numeric(mat[6,2])
    mat[7,3] <- as.numeric(mat[2,2]) + as.numeric(mat[4,2]) + as.numeric(mat[7,2])
    
    # Calculating the Plausibility
    
    mat[1,4] <- mat[1,3]
    mat[2,4] <- as.numeric(mat[2,2]) + as.numeric(mat[5,2]) + as.numeric(mat[7,2]) + as.numeric(mat[8,2])
    mat[3,4] <- as.numeric(mat[3,2]) + as.numeric(mat[5,2]) + as.numeric(mat[6,2]) + as.numeric(mat[8,2])
    mat[4,4] <- as.numeric(mat[4,2]) + as.numeric(mat[6,2]) + as.numeric(mat[7,2]) + as.numeric(mat[8,2])
    mat[5,4] <- as.numeric(mat[2,2]) + as.numeric(mat[3,2]) + as.numeric(mat[5,2]) +  as.numeric(mat[6,2]) + as.numeric(mat[7,2]) + as.numeric(mat[8,2])
    mat[6,4] <- as.numeric(mat[3,2]) + as.numeric(mat[4,2]) + as.numeric(mat[5,2]) +  as.numeric(mat[6,2]) + as.numeric(mat[7,2]) + as.numeric(mat[8,2])
    mat[7,4] <- as.numeric(mat[2,2]) + as.numeric(mat[4,2]) + as.numeric(mat[5,2]) +  as.numeric(mat[6,2]) + as.numeric(mat[7,2]) + as.numeric(mat[8,2])
    
    print(mat)
```

</details>

</details>

<details>
<summary>

## 03.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    #Calculate the mean, median, and standard deviation of the two
    #variables at http://www.networkatlas.eu/exercises/3/1/data.
    #txt (one variable per column).
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    #Calculate the mean, median, and standard deviation of the two
    #variables at http://www.networkatlas.eu/exercises/3/1/data.
    #txt (one variable per column).
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Calculating the mean
    meanX <- mean(data$x)
    meanY <- mean(data$y)
    
    # Calculating the median 
    medianX <- median(data$x)
    medianY <- median(data$y)
    
    # Calculating the standard deviation
    SDX <- sd(data$x)
    SDY <- sd(data$y)
    
    # Print the results
    
    print(meanX)
    print(meanY)
    print(medianX)
    print(medianY)
    print(SDX)
    print(SDY)
```

</details>

</details>

<details>
<summary>

## 03.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Make a scatter plot of the variables used in the previous exercise
    # – with one variable on the x axis and the other on the y axis. Do
    # you think that they are skewed or not? Calculate their skewness to
    # motivate your answer.
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Make a scatter plot of the variables used in the previous exercise
    # – with one variable on the x axis and the other on the y axis. Do
    # you think that they are skewed or not? Calculate their skewness to
    # motivate your answer.
    
    library(here)
    library(e1071)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Solution
    
    # writing the plot 
    plot(data$x, data$y, 
         main = "Scatter Plot", 
         xlab = "X Values", 
         ylab = "Y Values", 
         pch = 19,      # Solid circle points
         col = "blue")  # Point color
    
    # Calculating the skewness
    skewX <- skewness(data$x)
    skewY <- skewness(data$y)
    
    print(skewX)
    print(skewY)
    
    # skewX = 1.817525
    # skewY = 3.984962
    # The variables are skewed because their distribution is is right-skewed

```

</details>

</details>

<details>
<summary>

## 03.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    #Draw the mass function and the cumulative distribution of the
    #following outcome probabilities:
    
    #  Outcome  |    p
    #  ----------------
    #    1      |    0.1
    #    2      |    0.15
    #    3      |    0.2
    #    4      |    0.21
    #    5      |    0.17
    #    6      |    0.09
    #    7      |    0.06
    #    8      |    0.02
    
    Outcome <- 1:8
    p <- c(0.1, 0.15, 0.2, 0.21, 0.17, 0.09, 0.06, 0.02)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    #Draw the mass function and the cumulative distribution of the
    #following outcome probabilities:
    
    #  Outcome  |    P
    #  ----------------
    #    1      |    0.1
    #    2      |    0.15
    #    3      |    0.2
    #    4      |    0.21
    #    5      |    0.17
    #    6      |    0.09
    #    7      |    0.06
    #    8      |    0.02
    
    Outcome <- 1:8
    P <- c(0.1, 0.15, 0.2, 0.21, 0.17, 0.09, 0.06, 0.02)
    
    # Solution
    
    # Drawing the mass function 
    barplot(P, names.arg = Outcome, 
            xlab = "Outcome", 
            ylab = "Probability", 
            main = "Mass Function",
            col = "blue")
    
    # Drawing the cumulative distribution
    
    # Calculate the cumulative distribution 
    cum_p <- cumsum(p)
    
    # Draw the graph
    plot(Outcome, cum_p, type = "s", 
         xlab = "Outcome", 
         ylab = "Cumulative Probability", 
         main = "Cumulative Distribution Function",
         col = "blue", lwd = 2)
    points(Outcome, cum_p, pch = 19, col = "red")
```

</details>

</details>

<details>
<summary>

## 03.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Which correlation coefficient should you use to calculate the corre-
    # lation between the variables used in the exercise 2? Motivate your
    # answer by calculating covariance, and the Pearson and Spearman
    #correlation coefficients (and their p-values). Does the Spearman
    # correlation coefficient agree with the Pearson correlation calculated
    # on log-transformed values?
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Which correlation coefficient should you use to calculate the corre-
    # lation between the variables used in the exercise 2? Motivate your
    # answer by calculating covariance, and the Pearson and Spearman
    #correlation coefficients (and their p-values). Does the Spearman
    # correlation coefficient agree with the Pearson correlation calculated
    # on log-transformed values?
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Solution
    
    # Calculating the covariance
    covariance <- cov(data$x, data$y)
    cat("Covariance: ", covariance, "\n") # 673232178181
    
    # Calculating the Pearson correlation
    pearson <- cor.test(data$x, data$y, method = "pearson")
    cat("Pearson's correlation coefficient: ", pearson$estimate, "\n") # 0.4437232
    cat("Pearson's p-value: ", pearson$p.value, "\n") # 0.003246258
    
    # Calculating the Spearman correlation
    spearman <- cor.test(data$x, data$y, method = "spearman")
    cat("Spearman's correlation coefficient: ", spearman$estimate, "\n")# 0.7392432
    cat("Spearman's p-value: ", spearman$p.value, "\n")# 1.723284e-07 
    
    # Pearson is not preferable because the data is highly skewed so the Spearman is 
    # best the correlation coefficient
    
    # Pearson on log-transformed values
    log_x <- log(data$x)
    log_y <- log(data$y)
    
    pearson_log <- cor.test(log_x, log_y, method = "pearson")
    cat("Pearson's correlation on log-transformed values:", pearson_log$estimate, "p-value:", pearson_log$p.value, "\n")# 0.8280876 - 1.323059e-11
    
    # The Spearman correlation coefficient agree with the Pearson correlation because the values are close
```

</details>

</details>

<details>
<summary>

## 03.7.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # How many bits do we need to independently encode v1 and v2
    # from http://www.networkatlas.eu/exercises/3/5/data.txt?
    # How much would we save in encoding v1 if we knew v2 ?
    
    library(here)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # How many bits do we need to independently encode v1 and v2
    # from http://www.networkatlas.eu/exercises/3/5/data.txt?
    # How much would we save in encoding v1 if we knew v2 ?
    
    library(here)
    library(entropy)
    
    data <- read.table("data.txt", header = TRUE)
    
    # Solution
    
    # Calculating the entropy of v1 & v2 
    
    # Function to compute entropy for a vector
    get_entropy <- function(vec) {
      tab <- table(vec)
      probs <- tab / sum(tab)
      entropy.empirical(probs, unit = "log2")
    }
    
    H_v1 <- get_entropy(data$v1)
    
    cat("Entropy of v1:", H_v1, "bits\n")
    
    # Calculating the conditional entropy of v1 & v2 
    get_conditional_entropy <- function(x, y) {
      tab <- table(x, y)
      joint_probs <- tab / sum(tab)
      cond_entropy <- 0
      for (j in 1:ncol(tab)) {
        p_y <- sum(joint_probs[, j])
        if (p_y > 0) {
          cond_entropy <- cond_entropy + p_y * entropy.empirical(joint_probs[, j] / p_y, unit = "log2")
        }
      }
      return(cond_entropy)
    }
    
    H_v1_given_v2 <- get_conditional_entropy(data$v1, data$v2)
    cat("Conditional entropy H(v1|v2):", H_v1_given_v2, "bits\n")
    
    # Calculating the bits saved
    bits_saved <- H_v1 - H_v1_given_v2
    cat("Bits saved in encoding v1 if v2 is known:", bits_saved, "bits\n")
```

</details>

</details>

<details>
<summary>

## 04.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Imple-
    # ment the softmax function. Plot the result with the original vector
    # on the x axis and the softmax output on the y axis.
    
    library(here)
    set.seed(42)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Imple-
    # ment the softmax function. Plot the result with the original vector
    # on the x axis and the softmax output on the y axis.
    
    library(here)
    set.seed(42)
    
    # Solution
    
    # Generating the vector 
    x <- rnorm(100, mean = 0, sd = 1)
    
    # Implementing softmax function
    softmax <- function(z) {
      exp_z <- exp(z - max(z)) # For numerical stability
      exp_z / sum(exp_z)
    }
    
    y <- softmax(x)
    
    # Drawing the results.
    plot(x, y, 
         main = "Softmax Output vs Original Vector", 
         xlab = "Original Values", 
         ylab = "Softmax Output", 
         pch = 19, col = "blue")
```

</details>

</details>

<details>
<summary>

## 04.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Imple-
    # ment the ReLU function. Plot the result with the original vector on
    # the x axis and the ReLU output on the y axis.
    
    library(here)
    set.seed(42)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Imple-
    # ment the ReLU function. Plot the result with the original vector on
    # the x axis and the ReLU output on the y axis.
    
    library(here)
    set.seed(42)
    
    # Solution
    
    # Generating the vector 
    x <- rnorm(100, mean = 0, sd = 1)
    
    # Implementing the ReLu function
    relu <- function(z) {
      pmax(0, z)
    }
    
    y <- relu(x)
    
    # Drawing the result 
    plot(x, y,
         main = "ReLU Output vs Original Vector",
         xlab = "Original Values",
         ylab = "ReLU Output",
         pch = 19, col = "blue")
```

</details>

</details>

<details>
<summary>

## 04.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Implement the MAE and 
    # MSE functions and compare their outputs when applied to the vector, by plotting 
    # each of them.
    
    library(here)
    set.seed(42)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a random vector with 100 normally distributed random
    # values (with zero average and standard deviation of one). Implement the MAE and 
    # MSE functions and compare their outputs when applied to the vector, by plotting 
    # each of them.
    
    library(here)
    set.seed(42)
    
    # Solution
    
    # Generating the vector
    x <- rnorm(100, mean = 0, sd = 1)
    
    # Implementing MAE function 
    mae <- function(vec) {
      mean(abs(vec))
    }
    
    # Implementing MSE function 
    mse <- function(vec) {
      mean(vec^2)
    }
    
    # Calculating the result
    maey <- mae(x)
    msey <- mse(x)
    
    # Drawing the plots
    barplot(
      c(MAE = maey, MSE = msey),
      main = "Confronto tra MAE e MSE",
      ylab = "Valore dell'errore",
      col = c("blue", "red")
    )
```

</details>

</details>

<details>
<summary>

## 04.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Plot the likelihood function for p H and p T for the events { H, H, T, H, T }.
    
    library(here)
    
    seq <- c("H", "H", "T", "H", "T")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Plot the likelihood function for p H and p T for the events { H, H, T, H, T }.
    
    library(here)
    
    seqEvents <- c("H", "H", "T", "H", "T")
    
    # Solution
    
    # Counting the number of two kind of events
    numberH <- sum(seqEvents == "H")
    numberT <- sum(seqEvents == "T")
    
    # Defining a sequence of probabilities for H
    probabilityH <- seq(0, 1, length.out = 100)
    
    # Likelihood function (ignoring constant binomial coefficient)
    likelihood <- probabilityH^numberH * (1 - probabilityH)^numberT
    
    # Writing the plot
    plot(probabilityH, likelihood, type = "l", lwd = 2, col = "blue",
         xlab = "probabilityH (probability of heads)",
         ylab = "Likelihood",
         main = "Likelihood Function for p_H")
    abline(v = numberH / (numberH + numberT), col = "red", lty = 2) # Maximum Likelihood Estimate
    legend("topright", legend = "MLE", lty = 2, col = "red")

```

</details>

</details>

<details>
<summary>

## 05.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the length of the vector you obtain by summing [0, 4] to
    # [5, 1]?
    
    library(here)
    
    a <- c(0, 4)
    b <- c(5, 1)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the length of the vector you obtain by summing [0, 4] to
    # [5, 1]?
    
    library(here)
    
    a <- c(0, 4)
    b <- c(5, 1)
    
    # Solution
    
    result <- a + b
    print(length(result))
```

</details>

</details>

<details>
<summary>

## 05.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Suppose:
    #
    #  A=(1 0)
    #     0 2
    #
    #  B=(3 0)
    #     0 -1
    #
    #  Are these two transformations commutative? Does applying A
    #  first and B second lead to the same transformation as applying B
    #  first and A second?
    
    library(here)
    
    # Defining the matrices
    A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
    B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Suppose:
    #
    #  A=(1 0)
    #     0 2
    #
    #  B=(3 0)
    #     0 -1
    #
    #  Are these two transformations commutative? Does applying A
    #  first and B second lead to the same transformation as applying B
    #  first and A second?
    
    library(here)
    
    # Defining the matrices
    A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
    B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)
    
    # Solution
    
    # Computing A * B and B * A (matrix multiplication)
    AB <- A %*% B
    BA <- B %*% A
    
    # Print the results
    cat("A %*% B = ", AB, "\n")
    cat("B %*% A = ", BA, "\n")
    
    # Are they equal?
    cat("Are A and B commutative? ", all(AB == BA), "\n")
```

</details>

</details>

<details>
<summary>

## 05.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the eigenvalues and the right and left eigenvectors of
    # the matrix from http://www.networkatlas.eu/exercises/5/3/
    # data.txt. Make sure to sort the eigenvalues in descending order
    # (and sort the eigenvectors accordingly). Only take the real part of
    # eigenvalues and eigenvectors, ignoring the imaginary part.
    
    library(here)
    
    mat <- as.matrix(read.table("data.txt"))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the eigenvalues and the right and left eigenvectors of
    # the matrix from http://www.networkatlas.eu/exercises/5/3/
    # data.txt. Make sure to sort the eigenvalues in descending order
    # (and sort the eigenvectors accordingly). Only take the real part of
    # eigenvalues and eigenvectors, ignoring the imaginary part.
    
    library(here)
    
    mat <- as.matrix(read.table("data.txt"))
    
    # Solution
    
    # Calculating eigenvalues and right eigenvectors (Right eigenvectors are in eig$vectors)
    eig_right <- eigen(mat)
    
    # Calculating left eigenvectors: eigenvectors of the transposed matrix (Left eigenvectors are in eig_left$vectors)
    eig_left <- eigen(t(mat))
    
    # Taking only the real parts
    eigvals <- Re(eig_right$values)
    eigvecs_right <- Re(eig_right$vectors)
    eigvecs_left  <- Re(eig_left$vectors)
    
    # Getting sorting order
    ord <- order(eigvals, decreasing = TRUE)
    eigvals_sorted <- eigvals[ord]
    eigvecs_right_sorted <- eigvecs_right[, ord]
    eigvecs_left_sorted  <- eigvecs_left[, ord]
    
    # printing the results 
    cat("Eigenvalues (sorted):\n")
    print(eigvals_sorted)
    
    cat("\nRight eigenvectors (columns):\n")
    print(eigvecs_right_sorted)
    
    cat("\nLeft eigenvectors (columns):\n")
    print(eigvecs_left_sorted)
```

</details>

</details>

<details>
<summary>

## 05.8.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform the eigendecompositions of the matrices from exercise 2,
    # showing that you can reconstruct the originals from their eigenval-
    # ues and eigenvectors.
    
    # Matrices:
    #
    #  A=(1 0)
    #     0 2
    #
    #  B=(3 0)
    #     0 -1
    
    library(here) 
    
    # Defining the matrices
    A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
    B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform the eigendecompositions of the matrices from exercise 2,
    # showing that you can reconstruct the originals from their eigenval-
    # ues and eigenvectors.
    
    # Matrices:
    #
    #  A=(1 0)
    #     0 2
    #
    #  B=(3 0)
    #     0 -1
    
    library(here) 
    
    # Defining the matrices
    A <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
    B <- matrix(c(3, 0, 0, -1), nrow = 2, byrow = TRUE)
    
    # Solution
    
    # Eigendecomposition for A
    eig_A <- eigen(A)
    V_A <- eig_A$vectors        # Eigenvectors matrix
    D_A <- diag(eig_A$values)   # Diagonal matrix of eigenvalues
    
    # Reconstructing A
    A_reconstructed <- V_A %*% D_A %*% solve(V_A)
    
    # Eigendecomposition for B
    eig_B <- eigen(B)
    V_B <- eig_B$vectors
    D_B <- diag(eig_B$values)
    
    # Reconstructing B
    B_reconstructed <- V_B %*% D_B %*% solve(V_B)
    
    # Printing results
    cat("Original A:\n") print(A)
    cat("Reconstructed A:\n"); print(A_reconstructed)
    
    cat("\nOriginal B:\n"); print(B)
    cat("Reconstructed B:\n"); print(B_reconstructed)
```

</details>

</details>

<details>
<summary>

## 06.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate |V | and | E| for the graph in Figure 6.1(c).
    
    library(here)
    library(igraph)
    
    # Defining the graph
    
    # Let's label the nodes as 1, 2, 3, 4, 5
    # Creating edges
    edges <- c(1,2, 1,3, 1,4, 2,3, 3,4, 3,5)
    
    # Creating the graph
    g <- graph(edges=edges, n=5, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate |V | and | E| for the graph in Figure 6.1(c).
    
    library(here)
    library(igraph)
    
    # Solution
    
    # Defining the graph
    
    # Let's label the nodes as 1, 2, 3, 4, 5
    # Creating edges
    edges <- c(1,2, 1,3, 2,4, 3,4, 4,5)
    
    # Creating the graph
    g <- graph(edges=edges, n=5, directed=FALSE)
    
    # Solution
    
    # Calculate |V| and |E|
    num_vertices <- vcount(g)
    num_edges <- ecount(g)
    
    # Printing the results
    cat("|V| (number of nodes):", num_vertices, "\n")
    cat("|E| (number of edges):", num_edges, "\n")
    
    # Drawing the graph's plot (optional)
    plot(g, 
         vertex.size=30, 
         vertex.color="red", 
         vertex.label=V(g),
         edge.width=3,
         main="Graph from Figure 6.1(c)",
         layout=layout_in_circle)
```

</details>

</details>

<details>
<summary>

## 06.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Mr. A considers Ms. B a friend, but she doesn’t like him back. She
    # has a reciprocal friendship with both C and D, but only C con-
    # siders D a friend. D has also sent friend requests to E, F, G, and
    # H but, so far, only G replied. G also has a reciprocal relationship
    # with A. Draw the corresponding directed graph.
    
    library(here)
    library(igraph)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Mr. A considers Ms. B a friend, but she doesn’t like him back. She
    # has a reciprocal friendship with both C and D, but only C con-
    # siders D a friend. D has also sent friend requests to E, F, G, and
    # H but, so far, only G replied. G also has a reciprocal relationship
    # with A. Draw the corresponding directed graph.
    
    library(here)
    library(igraph)
    
    # Solution
    
    # Creating edges
    edges <- c(
      "A", "B",
      "A", "G",
      "B", "C",
      "B", "D",
      "C", "B",
      "C", "D",
      "D", "B",
      "D", "E",
      "D", "F",
      "D", "G",
      "D", "H",
      "G", "D",
      "G", "A"
    )
    
    # Creating the directed graph
    g <- make_graph(edges = edges, directed = TRUE)
    
    # Drawing the graph's plot
    plot(
      g,
      vertex.size = 35,
      vertex.color = "red",
      vertex.label.cex = 1.2,
      edge.arrow.size = 0.7,
      main = "Friendship Directed Graph"
    )
```

</details>

</details>

<details>
<summary>

## 06.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw the previous graph as undirected and weighted, with the
    # weight being 2 if the connection is reciprocal, 1 otherwise.
    
    library(here)
    library(igraph)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Draw the previous graph as undirected and weighted, with the
    # weight being 2 if the connection is reciprocal, 1 otherwise.
    
    library(here)
    library(igraph)
    
    # Solution 
    
    # Defining the edges
    edges <- c(
      "A", "B",
      "A", "G",
      "B", "C",
      "B", "D",
      "C", "D",
      "D", "E",
      "D", "F",
      "D", "G",
      "D", "H"
    )
    
    # Defining the weights
    weights <- c(
      1,  # A-B
      2,  # A-G
      2,  # B-C
      2,  # B-D
      1,  # C-D
      1,  # D-E
      1,  # D-F
      2,  # D-G
      1   # D-H
    )
    
    # Creating the undirected graph with weights
    g <- graph(edges=edges, directed=FALSE)
    E(g)$weight <- weights
    
    # Drawing the graph's plot
    plot(
      g,
      vertex.size = 35,
      vertex.color = "red",
      vertex.label.cex = 1.2,
      edge.width = E(g)$weight*1.5,
      edge.label = E(g)$weight,
      edge.label.cex = 1.2,
      main = "Friendship Network (undirected, weighted)"
    )
```

</details>

</details>

<details>
<summary>

## 06.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw a correlation network for the vectors in http://www.networkatlas.
    # eu/exercises/6/4/data.txt, by only drawing edges with positive
    # weights, ignoring self loops.
    
    library(here)
    library(igraph)
    
    # reading the data
    dat <- read.table("data.txt", header=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
```

</details>

</details>

<details>
<summary>

## 07.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/1/
    # data.txt is bipartite. Identify the nodes in either type and find the
    # nodes, in either type, with the most neighbors.
    
    library(here)
    library(igraph)
    
    # Reading data 
    edges <- read.table("data.txt", header=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/1/
    # data.txt is bipartite. Identify the nodes in either type and find the
    # nodes, in either type, with the most neighbors.
    
    library(here)
    library(igraph)
    
    # Reading data 
    edges <- read.table("data.txt", header=FALSE)
    
    # Solution
    
    # Generating the graph 
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Identifying bipartite types
    # Simple approach: nodes in the first column are one type, second column are the other type.
    type1 <- unique(edges$V1)
    type2 <- unique(edges$V2)
    
    #Finding degree (number of neighbors)
    deg <- degree(g)
    
    # Finding nodes with maximum degree
    max_deg <- max(deg)
    most_connected_nodes <- names(deg)[deg == max_deg]
    
    # Printing the results
    cat("Type 1 nodes:\n")
    print(type1)
    cat("\nType 2 nodes:\n")
    print(type2)
    cat("\nNode(s) with most neighbors:\n")
    print(most_connected_nodes)
    cat("Number of neighbors:", max_deg, "\n")
    
    # Seeing which type the most connected node(s) belong to
    for (node in most_connected_nodes) {
      if (node %in% type1) {
        cat(node, "is Type 1\n")
      } else if (node %in% type2) {
        cat(node, "is Type 2\n")
      }
    }
```

</details>

</details>

<details>
<summary>

## 07.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/2/
    # data.txt is multilayer. The data has three columns: source and
    # target node, and edge type. The edge type is either the numerical
    # id of the layer, or “C” for an inter-layer coupling. Given that this is
    # a one-to-one multilayer network, determine whether this network
    # has a star, clique or chain coupling.
    
    library(here)
    
    # Reading the data
    data <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
    colnames(data) <- c("source", "target", "type")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/2/
    # data.txt is multilayer. The data has three columns: source and
    # target node, and edge type. The edge type is either the numerical
    # id of the layer, or “C” for an inter-layer coupling. Given that this is
    # a one-to-one multilayer network, determine whether this network
    # has a star, clique or chain coupling.
    
    library(here)
    
    # Reading the data
    data <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
    colnames(data) <- c("source", "target", "type")
    
    # Solution
    
    # Creating the graph
    g <- graph_from_data_frame(data[,c("source","target")], directed=FALSE)
    
    E(g)$color <- ifelse(data$type == "C", "red", "grey")
    E(g)$lty <- ifelse(data$type == "C", 2, 1)
    
    sources_inter <- unique(inter_layer$source)
    targets_inter <- unique(inter_layer$target)
    V(g)$color <- ifelse(V(g)$name %in% sources_inter, "skyblue",
                         ifelse(V(g)$name %in% targets_inter, "palegreen", "white"))
    
    # Plotting with legend below
    
    
    # Plotting the graph, leaving space at the bottom
    plot(
      g,
      vertex.size=30,
      vertex.label.cex=1.2,
      vertex.label.color="black",
      edge.width=2,
      main=sprintf("Multilayer network (%s coupling)", coupling_type),
      margin=0.2
    )
    
    # Addding the legend below the plot
    legend(
      x = "bottom",
      inset = -0.32, # negative inset puts legend below plot, adjust as needed
      legend = c("Intra-layer edge", "Inter-layer coupling", "Source node", "Target node"),
      col = c("grey", "red", "skyblue", "palegreen"),
      pt.cex = c(NA, NA, 2, 2),
      pch = c(NA, NA, 21, 21),
      lty = c(1, 2, NA, NA),
      lwd = c(2, 2, NA, NA),
      bty = "n",
      horiz = TRUE,
      xpd = TRUE # allowing drawing outside plot region
    )

```

</details>

</details>

<details>
<summary>

## 07.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/3/
    # data.txt is a hypergraph, with a hyperedge per line. Transform it
    # in a unipartite network in which each hyperedge is split in edges
    # connecting all nodes in the hyperedge. Then transform it into a
    # bipartite network in which each hyperedge is a node of one type
    # and its nodes connect to it.
    
    library(here)
    #library(igraph)
    
    # Reading the hypergraph data (each line is a hyperedge)
    lines <- readLines("data.txt")
    hyperedges <- lapply(lines, function(x) strsplit(x, "\\s+")[[1]])
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/3/
    # data.txt is a hypergraph, with a hyperedge per line. Transform it
    # in a unipartite network in which each hyperedge is split in edges
    # connecting all nodes in the hyperedge. Then transform it into a
    # bipartite network in which each hyperedge is a node of one type
    # and its nodes connect to it.
    
    library(here)
    library(igraph)
    
    # Reading the hypergraph data (each line is a hyperedge)
    lines <- readLines("data.txt")
    hyperedges <- lapply(lines, function(x) strsplit(x, "\\s+")[[1]])
    
    # Solution
    
    # Unipartiting network: clique expansion
    get_pairs <- function(nodes) {
      nodes <- as.character(nodes)
      if(length(nodes) < 2) return(NULL)
      t(combn(nodes, 2))
    }
    all_pairs <- do.call(rbind, lapply(hyperedges, get_pairs))
    all_pairs <- unique(all_pairs)
    
    ################################################################################
    # Optional: creating a plot
    
    g_unipartite <- graph_from_edgelist(all_pairs, directed = FALSE)
    
    set.seed(42)
    plot(
      g_unipartite,
      layout = layout_with_fr,
      vertex.size = 25,
      vertex.color = "orange",
      vertex.label.cex = 1.1,
      main = " Hypergraph as Unipartite Network"
    )
    
    ################################################################################
    
    # Building bipartite edge list: hyperedge node -> member node
    bipartite_edges <- data.frame(
      from = rep(paste0("H", seq_along(hyperedges)), sapply(hyperedges, length)),
      to = as.character(unlist(hyperedges))
    )
    
    ################################################################################
    # Optional: creating a plot
    
    g_bipartite <- graph_from_data_frame(bipartite_edges, directed = FALSE)
    V(g_bipartite)$type <- grepl("^H", V(g_bipartite)$name)
    V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "orange")
    
    # Arranging bipartite layout: hyperedges (H nodes) on top row, other nodes on bottom row
    hyper_nodes <- V(g_bipartite)$name[V(g_bipartite)$type]
    elem_nodes <- V(g_bipartite)$name[!V(g_bipartite)$type]
    
    layout_bipartite <- matrix(NA, nrow = vcount(g_bipartite), ncol = 2)
    layout_bipartite[V(g_bipartite)$type, 1] <- seq_along(hyper_nodes)
    layout_bipartite[V(g_bipartite)$type, 2] <- 1
    layout_bipartite[!V(g_bipartite)$type, 1] <- match(elem_nodes, sort(elem_nodes))
    layout_bipartite[!V(g_bipartite)$type, 2] <- 0
    
    plot(
      g_bipartite,
      layout = layout_bipartite,
      vertex.size = 22,
      vertex.label.cex = 1,
      vertex.color = V(g_bipartite)$color,
      main = "Hypergraph as Bipartite Network"
    )
    legend(
      "topright",
      legend = c("Hyperedge", "Node"),
      col = c("skyblue", "orange"),
      pch = 19,
      pt.cex = 2,
      bty = "n"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 07.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/4/
    # data.txt is dynamic, the third and fourth columns of the edge
    # list tell you the first and last snapshot in which the edge was
    # continuously present. An edge can reappear if the edge was
    # present in two discontinuous time periods. Aggregate it using a
    # disjoint window of size 3.
    
    library(here)
    #library(igraph)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE)
    colnames(dat) <- c("source", "target", "start", "end")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network in http://www.networkatlas.eu/exercises/7/4/
    # data.txt is dynamic, the third and fourth columns of the edge
    # list tell you the first and last snapshot in which the edge was
    # continuously present. An edge can reappear if the edge was
    # present in two discontinuous time periods. Aggregate it using a
    # disjoint window of size 3.
    
    library(here)
    library(igraph)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE)
    colnames(dat) <- c("source", "target", "start", "end")
    
    # Solution 
    
    # Window settings to aggregate edges
    window_size <- 3
    max_snapshot <- max(dat$end)
    windows <- split(1:max_snapshot, ceiling((1:max_snapshot) / window_size))
    
    # For each window, aggregating the network and plot
    if (!require(igraph)) install.packages("igraph")
    library(igraph)
    
    for (i in seq_along(windows)) {
      wsnap <- windows[[i]]
      wname <- paste0("Snapshots ", min(wsnap), "-", max(wsnap))
      # Selecting edges that are present in at least one snapshot in this window
      present <- dat[
        (dat$start <= max(wsnap)) & (dat$end >= min(wsnap)),
      ]
      cat("\nWindow", i, "(", wname, "):\n")
      print(present[,1:2])
      
    ################################################################################
    # Optional: creating a plot 
      
      if (nrow(present) > 0) {
        g <- graph_from_data_frame(present[,1:2], directed=FALSE)
        plot(g, main=paste("Aggregated network:", wname))
      }
    ################################################################################
    }
```

</details>

</details>

<details>
<summary>

## 08.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the adjacency matrix, the stochastic adjacency matrix,
    # and the graph Laplacian for the network in http://www.
    # networkatlas.eu/exercises/8/1/data.txt.
    
    library(here)
    library(igraph)
    
    # Loading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Generating a plot (optional)
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the adjacency matrix, the stochastic adjacency matrix,
    # and the graph Laplacian for the network in http://www.
    # networkatlas.eu/exercises/8/1/data.txt.
    
    library(here)
    library(igraph)
    
    # Loading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Generating a plot (optional)
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Calculating the Adjacency matrix
    A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
    
    # Calculating the Stochastic adjacency matrix (row-normalized)
    row_sums <- rowSums(A)
    # Avoid division by zero
    row_sums[row_sums == 0] <- 1
    A_stochastic <- A / row_sums
    
    # Calculating the Laplacian Graph: L = D - A
    D <- diag(row_sums)
    L <- D - A
    
    # Printing the results
    cat("Adjacency Matrix:\n")
    print(A)
    
    cat("\nStochastic Adjacency Matrix:\n")
    print(round(A_stochastic, 3))
    
    cat("\nLaplacian Graph (L = D - A):\n")
    print(L)
```

</details>

</details>

<details>
<summary>

## 08.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Given the bipartite network in http://www.networkatlas.eu/
    # exercises/8/2/data.txt, calculate the stochastic adjacency matrix
    # of its projection. Project along the axis of size 248. (Note: don’t
    # ignore the weights)
    
    library(here)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(dat) <- c("from", "to", "weight")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Given the bipartite network in http://www.networkatlas.eu/
    # exercises/8/2/data.txt, calculate the stochastic adjacency matrix
    # of its projection. Project along the axis of size 248. (Note: don’t
    # ignore the weights)
    
    library(here)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(dat) <- c("from", "to", "weight")
    
    # Solution 
    
    # Identifying the bipartite sets,
    # counting how many unique nodes for each "axis"
    nodes1 <- unique(dat$from)
    nodes2 <- unique(dat$to)
    if (length(nodes1) == 248) {
      axis_nodes <- nodes1
      axis_label <- "from"
      other_label <- "to"
    } else if (length(nodes2) == 248) {
      axis_nodes <- nodes2
      axis_label <- "to"
      other_label <- "from"
    } else {
      stop("Neither axis has 248 unique nodes!")
    }
    
    # Building the incidence matrix (rows: axis_nodes, columns: other nodes)
    all_nodes_A <- sort(unique(dat[[axis_label]]))
    all_nodes_B <- sort(unique(dat[[other_label]]))
    incidence <- matrix(0, nrow=length(all_nodes_A), ncol=length(all_nodes_B),
                        dimnames=list(all_nodes_A, all_nodes_B))
    
    for (i in 1:nrow(dat)) {
      a <- as.character(dat[i, axis_label])
      b <- as.character(dat[i, other_label])
      w <- dat[i, "weight"]
      incidence[a, b] <- w
    }
    
    # Weighted projection along axis_nodes
    # For weighted bipartite projection: P = M %*% t(M) (if projecting rows)
    projection <- incidence %*% t(incidence)
    diag(projection) <- 0 # removing self-loops
    
    # Stochastic adjacency matrix (row-normalized)
    row_sums <- rowSums(projection)
    row_sums[row_sums == 0] <- 1 # avoiding division by zero
    stochastic <- projection / row_sums
    
    # Printing the outputs 
    cat("Stochastic adjacency matrix of the projected network:\n")
    print(round(stochastic[1:10, 1:10], 3))
```

</details>

</details>

<details>
<summary>

## 08.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the eigenvalues and the right and left eigenvectors of the
    # stochastic adjacency of the network at http://www.networkatlas.
    # eu/exercises/8/2/data.txt, using the same procedure applied
    # in the previous exercise. Make sure to sort the eigenvalues in
    # descending order (and sort the eigenvectors accordingly). Only
    # take the real part of eigenvalues and eigenvectors, ignoring the
    # imaginary part.
    
    library(here)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(dat) <- c("from", "to", "weight")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the eigenvalues and the right and left eigenvectors of the
    # stochastic adjacency of the network at http://www.networkatlas.
    # eu/exercises/8/2/data.txt, using the same procedure applied
    # in the previous exercise. Make sure to sort the eigenvalues in
    # descending order (and sort the eigenvectors accordingly). Only
    # take the real part of eigenvalues and eigenvectors, ignoring the
    # imaginary part.
    
    library(here)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(dat) <- c("from", "to", "weight")
    
    # Solution
    
    # Identifying the bipartite sets
    nodes1 <- unique(dat$from)
    nodes2 <- unique(dat$to)
    if (length(nodes1) == 248) {
      axis_nodes <- nodes1
      axis_label <- "from"
      other_label <- "to"
    } else if (length(nodes2) == 248) {
      axis_nodes <- nodes2
      axis_label <- "to"
      other_label <- "from"
    } else {
      stop("Neither axis has 248 unique nodes.")
    }
    
    # Building weighted incidence matrix (rows: axis_nodes)
    all_nodes_A <- sort(unique(dat[[axis_label]]))
    all_nodes_B <- sort(unique(dat[[other_label]]))
    incidence <- matrix(0, nrow=length(all_nodes_A), ncol=length(all_nodes_B),
                        dimnames=list(all_nodes_A, all_nodes_B))
    for (i in 1:nrow(dat)) {
      a <- as.character(dat[i, axis_label])
      b <- as.character(dat[i, other_label])
      w <- as.numeric(dat[i, "weight"])
      incidence[a, b] <- w
    }
    
    # Weighted projection along axis_nodes
    projection <- incidence %*% t(incidence)
    diag(projection) <- 0 # remove self-loops
    
    # Stochastic adjacency matrix (row-normalized)
    row_sums <- rowSums(projection)
    row_sums[row_sums == 0] <- 1
    stochastic <- projection / row_sums
    
    # Eigenvalues & eigenvectors
    eig <- eigen(stochastic)
    values <- Re(eig$values)
    right_vecs <- Re(eig$vectors)
    # For left eigenvectors -> t(stochastic) (since left eigvecs of A are right eigvecs of t(A))
    eig_left <- eigen(t(stochastic))
    left_vecs <- Re(eig_left$vectors)
    
    # Sorting eigenvalues and vectors in descending order
    idx <- order(values, decreasing=TRUE)
    values_sorted <- values[idx]
    right_vecs_sorted <- right_vecs[, idx, drop=FALSE]
    left_vecs_sorted <- left_vecs[, idx, drop=FALSE]
    
    # Printing the result
    cat("Eigenvalues (sorted, real part):\n")
    print(values_sorted)
    
    cat("\nFirst 5 right eigenvectors (columns, real part):\n")
    print(round(right_vecs_sorted[, 1:5, drop=FALSE], 4))
    
    cat("\nFirst 5 left eigenvectors (columns, real part):\n")
    print(round(left_vecs_sorted[, 1:5, drop=FALSE], 4))
```

</details>

</details>

<details>
<summary>

## 08.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate the indegree and outdegree Laplacians of the directed
    # graph at http://www.networkatlas.eu/exercises/8/4/data.
    # txt. Calculate their eigenvalues as well as the eigenvalue of the
    # undirected version of the graph.
    
    library(here)
    #library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate the indegree and outdegree Laplacians of the directed
    # graph at http://www.networkatlas.eu/exercises/8/4/data.
    # txt. Calculate their eigenvalues as well as the eigenvalue of the
    # undirected version of the graph.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Solution
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Adjacency matrix
    A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
    
    # Node order (for consistent matrix construction)
    nodes <- V(g)$name
    n <- length(nodes)
    
    # Out-degree Laplacian: L_out = D_out - A
    d_out <- rowSums(A)
    L_out <- diag(d_out) - A
    
    # In-degree Laplacian: L_in = D_in - A^T = diag(colSums(A)) - t(A)
    d_in <- colSums(A)
    L_in <- diag(d_in) - t(A)
    
    # Eigenvalues (real part, sorted decreasing)
    eig_out <- eigen(L_out, only.values=FALSE)
    eigvals_out <- sort(Re(eig_out$values), decreasing=TRUE)
    
    eig_in <- eigen(L_in, only.values=FALSE)
    eigvals_in <- sort(Re(eig_in$values), decreasing=TRUE)
    
    # Undirected version
    g_undir <- as.undirected(g, mode="collapse")
    A_undir <- as.matrix(as_adjacency_matrix(g_undir, sparse=FALSE))
    d_undir <- rowSums(A_undir)
    L_undir <- diag(d_undir) - A_undir
    
    eig_undir <- eigen(L_undir, only.values=FALSE)
    eigvals_undir <- sort(Re(eig_undir$values), decreasing=TRUE)
    
    # Printing the results
    cat("Eigenvalues of OUT-degree Laplacian (L_out):\n")
    print(eigvals_out)
    
    cat("\nEigenvalues of IN-degree Laplacian (L_in):\n")
    print(eigvals_in)
    
    cat("\nEigenvalues of undirected Laplacian:\n")
    print(eigvals_undir)

```

</details>

</details>

<details>
<summary>

## 08.6.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate the signed and unsigned Laplacians of the signed graph
    # at http://www.networkatlas.eu/exercises/8/5/data.txt – the
    # third column contains the sign. Calculate their eigenvalues as well
    # as the eigenvalue of the version of the graph ignoring edge signs.
    
    library(here)
    library(igraph)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE)
    colnames(dat) <- c("from", "to", "sign")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate the signed and unsigned Laplacians of the signed graph
    # at http://www.networkatlas.eu/exercises/8/5/data.txt – the
    # third column contains the sign. Calculate their eigenvalues as well
    # as the eigenvalue of the version of the graph ignoring edge signs.
    
    library(here)
    library(igraph)
    
    # Reading the data
    dat <- read.table("data.txt", header=FALSE)
    colnames(dat) <- c("from", "to", "sign")
    
    # Solution
    
    # Building signed adjacency matrix
    nodes <- sort(unique(c(dat$from, dat$to)))
    n <- length(nodes)
    A_signed <- matrix(0, nrow=n, ncol=n, dimnames=list(nodes, nodes))
    
    for(i in 1:nrow(dat)){
      a <- as.character(dat$from[i])
      b <- as.character(dat$to[i])
      s <- as.numeric(dat$sign[i])
      A_signed[a, b] <- s
      A_signed[b, a] <- s # undirected
    }
    
    # Degree matrix for signed graph: sum of absolute values of row/col
    D_signed <- diag(rowSums(abs(A_signed)))
    
    # Signed Laplacian: L_signed = D_signed - A_signed
    L_signed <- D_signed - A_signed
    
    # Eigenvalues of signed Laplacian
    eig_signed <- eigen(L_signed)
    eigvals_signed <- sort(Re(eig_signed$values), decreasing=TRUE)
    
    # Unsigned adjacency (absolute values)
    A_unsigned <- abs(A_signed)
    D_unsigned <- diag(rowSums(A_unsigned))
    L_unsigned <- D_unsigned - A_unsigned
    
    # Eigenvalues of unsigned Laplacian
    eig_unsigned <- eigen(L_unsigned)
    eigvals_unsigned <- sort(Re(eig_unsigned$values), decreasing=TRUE)
    
    # Laplacian ignoring signs (as a normal undirected graph)
    # Optional working using a plot 
    g_undir <- graph_from_data_frame(dat[,1:2], directed=FALSE)
    A_undir <- as.matrix(as_adjacency_matrix(g_undir, sparse=FALSE))
    D_undir <- diag(rowSums(A_undir))
    L_undir <- D_undir - A_undir
    eig_undir <- eigen(L_undir)
    eigvals_undir <- sort(Re(eig_undir$values), decreasing=TRUE)
    
    # Printing the results
    cat("Eigenvalues of SIGNED Laplacian:\n")
    print(eigvals_signed)
    
    cat("\nEigenvalues of UNSIGNED Laplacian (use |sign| for edge weights):\n")
    print(eigvals_unsigned)
    
    cat("\nEigenvalues of Laplacian ignoring edge signs (normal graph):\n")
    print(eigvals_undir)
```

</details>

</details>

<details>
<summary>

## 09.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Write the in- and out-degree sequence for the graph in Figure
    # 9.3(a). Are there isolated nodes? Why? Why not?
    
    library(igraph)
    
    # Adjacency list based on the graph (naming nodes: E, C, D, B, A)
    edges <- data.frame(
      from = c("E", "E", "C", "D", "B"),
      to   = c("C", "D", "B", "B", "A")
    )
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Write the in- and out-degree sequence for the graph in Figure
    # 9.3(a). Are there isolated nodes? Why? Why not?
    
    library(igraph)
    
    # Adjacency list based on the image (let's name nodes: E, C, D, B, A)
    edges <- data.frame(
      from = c("E", "E", "C", "D", "B"),
      to   = c("C", "D", "B", "B", "A")
    )
    
    # Solution
    
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # In- and out-degree sequences
    indegree <- degree(g, mode="in")
    outdegree <- degree(g, mode="out")
    
    cat("In-degree sequence:\n")
    print(indegree)
    cat("\nOut-degree sequence:\n")
    print(outdegree)
    
    # So there aren't isolated nodes because every node has at least one edge.
```

</details>

</details>

<details>
<summary>

## 09.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the degree of the nodes for both node types in the
    # bipartite adjacency matrix from Figure 9.5(a). Find the isolated
    # node(s).
    
    #library(igraph)
    
    # Bipartite adjacency matrix
    A <- matrix(c(
      0,0,1,0,0,0,0,1,
      0,0,0,0,1,1,0,0,
      0,1,1,0,1,0,0,0,
      0,0,0,1,0,0,1,0,
      1,0,0,0,0,0,0,1,
      0,0,0,1,1,0,0,0,
      0,0,1,1,0,0,1,0,
      0,0,0,0,0,0,1,0
    ), nrow=8, byrow=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the degree of the nodes for both node types in the
    # bipartite adjacency matrix from Figure 9.5(a). Find the isolated
    # node(s).
    
    library(igraph)
    
    # Bipartite adjacency matrix
    A <- matrix(c(
      0,0,1,0,0,0,0,1,
      0,0,0,0,1,1,0,0,
      0,1,1,0,1,0,0,0,
      0,0,0,1,0,0,1,0,
      1,0,0,0,0,0,0,1,
      0,0,0,1,1,0,0,0,
      0,0,1,1,0,0,1,0,
      0,0,0,0,0,0,1,0
    ), nrow=8, byrow=TRUE)
    
    # Solution 
    
    # Degree for type 1 nodes (rows)
    degree_type1 <- rowSums(A)
    
    # Degree for type 2 nodes (columns)
    degree_type2 <- colSums(A)
    
    cat("Degree of type 1 nodes (rows):\n")
    print(degree_type1)
    
    cat("\nDegree of type 2 nodes (columns):\n")
    print(degree_type2)
    
    # Finding isolated nodes
    isolated_type1 <- which(degree_type1 == 0)
    isolated_type2 <- which(degree_type2 == 0)
    
    cat("\nIsolated type 1 nodes (rows):", if(length(isolated_type1) == 0) "none" else isolated_type1, "\n")
    cat("Isolated type 2 nodes (columns):", if(length(isolated_type2) == 0) "none" else isolated_type2, "\n")
    
    ################################################################################
    # Optional generating a graph
    
    g <- graph_from_incidence_matrix(A)
    
    V(g)$color <- ifelse(V(g)$type, "skyblue", "orange")
    
    plot(
      g,
      vertex.label=NA,
      vertex.size=25,
      layout=layout_as_bipartite,
      main="Bipartite Graph from Figure 9.5(a)"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 09.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Write the degree sequence of the graph in Figure 9.7. First consid-
    # ering all layers at once, then separately for each layer.
    
    library(igraph)
    
    nodes <- as.character(1:9)
    
    # Edge lists for each layer/color (example, adapt if you see differences!)
    edges_brown <- matrix(c(1,3, 3,2, 2,4, 3,4, 6,8, 6,9), ncol=2, byrow=TRUE)
    edges_green <- matrix(c(1,4, 4,5, 5,8, 4,7, 8,9), ncol=2, byrow=TRUE)
    edges_blue  <- matrix(c(2,5, 5,7, 6,9), ncol=2, byrow=TRUE)
    edges_orange<- matrix(c(1,2, 2,5, 7,8, 7,6, 6,9), ncol=2, byrow=TRUE)
    edges_purple<- matrix(c(2,5, 5,7, 5,6, 6,8), ncol=2, byrow=TRUE)
    edges_red   <- matrix(c(1,3, 4,5), ncol=2, byrow=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Write the degree sequence of the graph in Figure 9.7. First consid-
    # ering all layers at once, then separately for each layer.
    
    library(igraph)
    
    nodes <- as.character(1:9)
    
    # Edge lists for each layer/color (example, adapt if you see differences!)
    edges_brown <- matrix(c(1,3, 3,2, 2,4, 3,4, 6,8, 6,9), ncol=2, byrow=TRUE)
    edges_green <- matrix(c(1,4, 4,5, 5,8, 4,7, 8,9), ncol=2, byrow=TRUE)
    edges_blue  <- matrix(c(2,5, 5,7, 6,9), ncol=2, byrow=TRUE)
    edges_orange<- matrix(c(1,2, 2,5, 7,8, 7,6, 6,9), ncol=2, byrow=TRUE)
    edges_purple<- matrix(c(2,5, 5,7, 5,6, 6,8), ncol=2, byrow=TRUE)
    edges_red   <- matrix(c(1,3, 4,5), ncol=2, byrow=TRUE)
    
    # Solution 
    
    # Combine all layers for total degree sequence
    all_edges <- rbind(
      edges_brown,
      edges_green,
      edges_blue,
      edges_orange,
      edges_purple,
      edges_red
    )
    
    g_all <- graph_from_edgelist(all_edges, directed=FALSE)
    deg_all <- degree(g_all, v=nodes)
    cat("Degree sequence considering all layers at once:\n")
    print(deg_all)
    
    # Calculate degree for each layer separately
    layers <- list(
      brown=edges_brown,
      green=edges_green,
      blue=edges_blue,
      orange=edges_orange,
      purple=edges_purple,
      red=edges_red
    )
    
    cat("\nDegree sequences for each layer:\n")
    for(layer in names(layers)) {
      # Convert edges to data frame for compatibility
      edge_df <- as.data.frame(layers[[layer]])
      names(edge_df) <- c("from", "to")
      g_layer <- graph_from_data_frame(edge_df, directed=FALSE, vertices=data.frame(name=nodes))
      deg_layer <- degree(g_layer, v=nodes)
      cat(sprintf("%s: %s\n", layer, paste(deg_layer, collapse=" ")))
    }

```

</details>

</details>

<details>
<summary>

## 09.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Plot the degree distribution of the network at http://www.networkatlas.
    # eu/exercises/9/4/data.txt. Start from a plain degree distribu-
    # tion, then in log-log scale, finally plot the complement of the
    # cumulative distribution.
    
    library(here)
    library(igraph)
    
    # Read the edge list
    edges <- read.table("data.txt", header=FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Compute degree for each node
    deg <- degree(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Plot the degree distribution of the network at http://www.networkatlas.
    # eu/exercises/9/4/data.txt. Start from a plain degree distribu-
    # tion, then in log-log scale, finally plot the complement of the
    # cumulative distribution.
    
    library(here)
    library(igraph)
    
    # Read the edge list
    edges <- read.table("data.txt", header=FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Compute degree for each node
    deg <- degree(g)
    
    # Solution
    
    # Frequency table of degrees
    deg_dist <- table(deg)
    
    # Plain degree distribution plot
    plot(as.numeric(names(deg_dist)), as.numeric(deg_dist), type="h",
         xlab="Degree", ylab="Frequency", main="Degree Distribution")
    
    # Avoiding log(0) by removing zero frequencies
    nonzero <- deg_dist > 0
    plot(log10(as.numeric(names(deg_dist[nonzero]))),
         log10(as.numeric(deg_dist[nonzero])),
         xlab="log10(Degree)", ylab="log10(Frequency)", main="Degree Distribution (log-log)",
         pch=20)
    
    # Computing the cumulative distribution
    deg_values <- as.numeric(names(deg_dist))
    cum_dist <- cumsum(rev(as.numeric(deg_dist)))  # cumulative from high degree down
    ccdf <- rev(cum_dist) / sum(deg_dist)  # normalize
    
    # Plotting the CCDF in log-log
    plot(log10(deg_values), log10(ccdf), type="b", pch=20,
         xlab="log10(Degree)", ylab="log10(CCDF)", main="Complementary Cumulative Degree Distribution")
```

</details>

</details>

<details>
<summary>

## 09.6.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Estimate the power law exponent of the CCDF degree distribution
    # from the previous exercise. First by a linear regression on the log-
    # log plane, then by using the powerlaw package. Do they agree? Is
    # this a shifted power law? If so, what’s k min ? (Hint: powerlaw can
    # calculate this for you)
    
    library(here)
    library(igraph)
    library(poweRlaw)
    
    # Read the edge list
    edges <- read.table("data.txt", header=FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    deg <- degree(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Estimate the power law exponent of the CCDF degree distribution
    # from the previous exercise. First by a linear regression on the log-
    # log plane, then by using the powerlaw package. Do they agree? Is
    # this a shifted power law? If so, what’s k min ? (Hint: powerlaw can
    # calculate this for you)
    
    library(here)
    library(igraph)
    library(poweRlaw)
    
    # Read the edge list
    edges <- read.table("data.txt", header=FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    deg <- degree(g)
    
    # Solution
    
    # Linear Regression on the Log-Log CCDF
    # Degree distribution
    deg_dist <- table(deg)
    deg_vals <- as.numeric(names(deg_dist))
    deg_freq <- as.numeric(deg_dist)
    deg_ccdf <- rev(cumsum(rev(deg_freq))) / sum(deg_freq)
    
    # Removing degrees with zero frequency
    nonzero <- deg_ccdf > 0
    
    # Preparing log-log data
    log_deg <- log10(deg_vals[nonzero])
    log_ccdf <- log10(deg_ccdf[nonzero])
    
    # Linear regression (excluding degree=0)
    fit <- lm(log_ccdf ~ log_deg)
    
    cat("Estimated exponent (linear regression):", -coef(fit)[2], "\n")
    summary(fit)
    
    # Create a discrete power law object
    pl_model <- displ$new(deg)
    
    # Estimate xmin and alpha automatically
    est <- estimate_xmin(pl_model)
    pl_model$setXmin(est)
    
    cat("poweRlaw estimated xmin (k_min):", pl_model$getXmin(), "\n")
    cat("poweRlaw estimated exponent (alpha):", pl_model$pars, "\n")
    
    if (pl_model$getXmin() > 1) {
      cat("This is a shifted power law, starting from k_min =", pl_model$getXmin(), "\n")
    } else {
      cat("This is not a shifted power law (k_min = 1).\n")
    }
    
    # So they agreeing because is a shit powerlaw!

```

</details>

</details>

<details>
<summary>

## 09.6.6

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Find a way to fit the truncated power law of the network at http:
    #  //www.networkatlas.eu/exercises/9/6/data.net. Hint: use the
    # scipy.optimize.curve_fit to fit an arbitrary function and use the
    # functional form I provide in the text.
    
    library(here)
    library(igraph)
    # library(poweRlaw)
    
    # Read the Pajek network
    g <- read_graph("data.net", format="pajek")
    
    # Get degree sequence
    deg <- degree(g)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Find a way to fit the truncated power law of the network at http:
    #  //www.networkatlas.eu/exercises/9/6/data.net. Hint: use the
    # scipy.optimize.curve_fit to fit an arbitrary function and use the
    # functional form I provide in the text.
    
    library(here)
    library(igraph)
    library(poweRlaw)
    
    # Read the Pajek network
    g <- read_graph("data.net", format="pajek")
    
    # Get degree sequence
    deg <- degree(g)
    
    # Solution 
    
    # Preparing the Degree Distribution
    deg_tab <- table(deg)
    deg_vals <- as.numeric(names(deg_tab))
    deg_freq <- as.numeric(deg_tab)
    
    # Fitting a Truncated Power Law
    
    # Creating data for fitting (exclude zeros)
    fit_idx <- deg_vals > 0
    x <- deg_vals[fit_idx]
    y <- deg_freq[fit_idx]
    
    # Normalizing y for probability (optional, but better for fit)
    y <- y / sum(y)
    
    # Nonlinear fit: y ~ C * x^(-alpha) * exp(-lambda * x)
    tplaw <- nls(y ~ C * x^(-alpha) * exp(-lambda * x),
                 start=list(C=1, alpha=2, lambda=0.1),
                 control = nls.control(maxiter = 100))
    
    summary(tplaw)
    
    # Plotting the fit
    
    plot(x, y, log="xy", pch=20, xlab="Degree", ylab="P(k)", main="Truncated Power Law Fit")
    lines(x, predict(tplaw), col="red", lwd=2)
    legend("topright", legend="TPL fit", col="red", lwd=2)
    
    ################################################################################
    # Optional: Using poweRlaw for Comparison
    
    # Suppose deg is the degree vector
    m <- displ$new(deg)
    
    # Estimating xmin and exponent (alpha)
    est <- estimate_xmin(m)
    m$setXmin(est)
    est_pars <- estimate_pars(m)
    m$setPars(est_pars$pars)
    
    # Plotting the data and the fit
    plot(m, main="Using poweRlaw for Comparison")
    lines(m, col="red")
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 10.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Write the code to perform a random walk of arbitrary length on
    # the network in http://www.networkatlas.eu/exercises/10/1/
    # data.txt.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # For printing all node's name
    #print(V(g)$name)
    
    ################################################################################
    # Optional: plotting the graph
    
    plot(g,
         vertex.size=3,
         vertex.label=NA,
         edge.arrow.size=0.3,
         main="Network Graph from data.txt")
    
    ################################################################################
    
    # Parameters for the random walk
    walk_length <- 100 # Setting walk length
    start_node_name <- "100" # Setting start node name
    
    # Checking if the node's name exist 
    start_node <- which(V(g)$name == start_node_name)
    
    if (length(start_node) == 0) {
      stop(paste("Node", start_node_name, "not found in the network!"))
    }
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Write the code to perform a random walk of arbitrary length on
    # the network in http://www.networkatlas.eu/exercises/10/1/
    # data.txt.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # For printing all node's name
    #print(V(g)$name)
    
    ################################################################################
    # Optional: plotting the graph
    
    plot(g,
         vertex.size=3,
         vertex.label=NA,
         edge.arrow.size=0.3,
         main="Network Graph from data.txt")
    
    ################################################################################
    
    # Parameters for the random walk
    walk_length <- 100 # Setting walk length
    start_node_name <- "100" # Setting start node name
    
    # Checking if the node's name exist 
    start_node <- which(V(g)$name == start_node_name)
    
    if (length(start_node) == 0) {
      stop(paste("Node", start_node_name, "not found in the network!"))
    }
    
    # Solution 
    
    # Performing the random walk
    walk <- random_walk(g, start=start_node, steps=walk_length, mode="all")
    
    # Printing the sequence of visited nodes
    cat("Random walk:\n")
    print(V(g)[walk]$name)
```

</details>

</details>

<details>
<summary>

## 10.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Find all cycles in the network in http://www.networkatlas.eu/
    # exercises/10/2/data.txt. Note: the network is directed.
    
    library(here)
    library(RBGL)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Find all cycles in the network in http://www.networkatlas.eu/
    # exercises/10/2/data.txt. Note: the network is directed.
    
    library(here)
    library(RBGL)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header = FALSE, stringsAsFactors = FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    
    # Solution (this should be the solution, but I have problems to compile RBGL)
    
    # Creating a directed graphNEL object
    gNEL <- new("graphNEL", nodes = as.character(nodes), edgemode = "directed")
    for(i in 1:nrow(edges)) {
      gNEL <- addEdge(as.character(edges$V1[i]), as.character(edges$V2[i]), gNEL)
    }
    
    # Finding all cycles
    cycles <- johnson.all.cycles(gNEL)
    
    # Printing cycles
    cat("All cycles found:\n")
    for (cyc in cycles) {
      cat(paste(cyc, collapse = " -> "), "\n")
    }
```

</details>

</details>

<details>
<summary>

## 10.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the average reciprocity in the network used in the previous
    # question? How many nodes have a reciprocity of zero?
    
    library(here)
    library(igraph)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the average reciprocity in the network used in the previous
    # question? How many nodes have a reciprocity of zero?
    
    library(here)
    library(igraph)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)
    
    # Solution
    
    # Calculating the Average reciprocity
    avg_reciprocity <- reciprocity(g)
    cat(sprintf("Average reciprocity of the network: %.3f\n", avg_reciprocity))
    
    # Calculating the Reciprocity per node
    node_recip <- reciprocity(g, mode="ratio") # returning a vector, one per node
    
    # Calculating How many nodes have a reciprocity of zero?
    num_zero_recip_nodes <- sum(node_recip == 0)
    cat(sprintf("Number of nodes with reciprocity zero: %d\n", num_zero_recip_nodes))
    
    ################################################################################
    # Optional - printing those nodes:
    
    zero_recip_nodes <- V(g)$name[node_recip == 0]
    cat("Nodes with reciprocity zero:\n")
    print(zero_recip_nodes)
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 10.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # How many weakly and strongly connected component does the
    # network used in the previous question have? Compare their sizes,
    # in number of nodes, with the entire network. Which nodes are in
    # these two components?
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # How many weakly and strongly connected component does the
    # network used in the previous question have? Compare their sizes,
    # in number of nodes, with the entire network. Which nodes are in
    # these two components?
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=TRUE)
    
    # Solution
    
    # Calculating the Strongly Connected Components
    scc <- components(g, mode="strong")
    num_scc <- scc$no
    sizes_scc <- scc$csize
    
    # Calculating the Weakly Connected Components
    wcc <- components(g, mode="weak")
    num_wcc <- wcc$no
    sizes_wcc <- wcc$csize
    
    # Printing the result
    num_nodes <- vcount(g)
    cat(sprintf("Total nodes: %d\n", num_nodes))
    cat(sprintf("Number of strongly connected components: %d\n", num_scc))
    cat(sprintf("Sizes of SCCs: %s\n", paste(sizes_scc, collapse=", ")))
    cat(sprintf("Number of weakly connected components: %d\n", num_wcc))
    cat(sprintf("Sizes of WCCs: %s\n", paste(sizes_wcc, collapse=", ")))
    
    ################################################################################
    # Optional
    
    # List the nodes in each SCC
    cat("\nStrongly connected components:\n")
    for(i in seq_len(num_scc)) {
      nodes_in_scc <- V(g)$name[which(scc$membership == i)]
      cat(sprintf("SCC %d (%d nodes): %s\n", i, length(nodes_in_scc), paste(nodes_in_scc, collapse=", ")))
    }
    
    # List the nodes in each WCC
    cat("\nWeakly connected components:\n")
    for(i in seq_len(num_wcc)) {
      nodes_in_wcc <- V(g)$name[which(wcc$membership == i)]
      cat(sprintf("WCC %d (%d nodes): %s\n", i, length(nodes_in_wcc), paste(nodes_in_wcc, collapse=", ")))
    }
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 11.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the stationary distribution of the network at http://
    # www.networkatlas.eu/exercises/11/1/data.txt in three ways: by
    # raising the stochastic adjacency to a high power, by looking at the
    # leading left eigenvector, and by normalizing the degree. Verify that
    # they are all equivalent.
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the stationary distribution of the network at http://
    # www.networkatlas.eu/exercises/11/1/data.txt in three ways: by
    # raising the stochastic adjacency to a high power, by looking at the
    # leading left eigenvector, and by normalizing the degree. Verify that
    # they are all equivalent.
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution 
    
    # Building adjacency matrix
    N <- length(nodes)
    adj <- matrix(0, nrow=N, ncol=N)
    for(i in 1:nrow(edges)) {
      from <- match(edges$V1[i], nodes)
      to   <- match(edges$V2[i], nodes)
      adj[from, to] <- 1
    }
    row_sums <- rowSums(adj)
    
    # Building the stochastic matrix with fix for dangling nodes
    P <- adj
    for (i in 1:N) {
      if (row_sums[i] == 0) {
        P[i, ] <- 1/N
      } else {
        P[i, ] <- adj[i, ] / row_sums[i]
      }
    }
    
    # Stationary by power
    Pn <- P
    for(i in 1:100) Pn <- Pn %*% P
    stat1 <- Pn[1,]; stat1 <- stat1 / sum(stat1)
    
    # Stationary by left eigenvector
    eig <- eigen(t(P))
    stat2 <- Re(eig$vectors[,which.max(Re(eig$values))])
    stat2 <- stat2 / sum(stat2)
    
    # Stationary by degree
    deg <- row_sums
    # assigning 1 to dangling nodes as well (for consistency)
    deg[deg == 0] <- 1
    stat3 <- deg / sum(deg)
    
    # 6. Comparing
    cat("By matrix power:\n"); print(round(stat1, 5))
    cat("By eigenvector:\n"); print(round(stat2, 5))
    cat("By degree normalization:\n"); print(round(stat3, 5))
    cat("Matrix power vs eigenvector: ", all.equal(stat1, stat2, tolerance=1e-6), "\n")
    cat("Matrix power vs degree: ", all.equal(stat1, stat3, tolerance=1e-6), "\n")
```

</details>

</details>

<details>
<summary>

## 11.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the non-backtracking matrix of the network used for the
    # previous question. (The network is undirected)
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the non-backtracking matrix of the network used for the
    # previous question. (The network is undirected)
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # This should be the solution...
    
    # Making sure all edges are unique and undirected
    edges <- unique(data.frame(from = pmin(edges$from, edges$to), to = pmax(edges$from, edges$to)))
    
    # Creating directed edges (both directions for each undirected edge)
    directed_edges <- rbind(
      data.frame(from = edges$from, to = edges$to),
      data.frame(from = edges$to, to = edges$from)
    )
    n_dir <- nrow(directed_edges)
    
    # Building the non-backtracking matrix
    B <- matrix(0, nrow = n_dir, ncol = n_dir)
    for (i in 1:n_dir) {
      for (j in 1:n_dir) {
        # edge i: a -> b
        # edge j: c -> d
        if (directed_edges$to[i] == directed_edges$from[j] &&
            directed_edges$from[i] != directed_edges$to[j]) {
          B[i, j] <- 1
        }
      }
    }
    
    # Assigning row/col names for clarity
    rownames(B) <- paste(directed_edges$from, "->", directed_edges$to)
    colnames(B) <- paste(directed_edges$from, "->", directed_edges$to)
    
    # Printing the result
    print(B)
```

</details>

</details>

<details>
<summary>

## 11.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the hitting time matrix of the network at http://www.
    # networkatlas.eu/exercises/11/3/data.txt. Note: for various
    # reasons, a naive implementation in python using numpy and scipy
    # might lead to the wrong result. I would advise to try and do this
    # in Octave (or Matlab).
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header = FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the hitting time matrix of the network at http://www.
    # networkatlas.eu/exercises/11/3/data.txt. Note: for various
    # reasons, a naive implementation in python using numpy and scipy
    # might lead to the wrong result. I would advise to try and do this
    # in Octave (or Matlab).
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header = FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution
    
    # Building adjacency matrix
    
    N <- length(nodes)
    adj <- matrix(0, nrow = N, ncol = N)
    for(i in 1:nrow(edges)) {
      from <- match(edges$V1[i], nodes)
      to   <- match(edges$V2[i], nodes)
      adj[from, to] <- 1
      adj[to, from] <- 1  # undirected
    }
    
    # Row-stochastic transition matrix
    row_sums <- rowSums(adj)
    P <- adj / row_sums
    
    # Hitting time matrix function
    hitting_time_matrix <- function(P) {
      N <- nrow(P)
      H <- matrix(0, nrow=N, ncol=N)
      for (target in 1:N) {
        A <- diag(N)
        b <- rep(1, N)
        A[target,] <- 0
        A[target, target] <- 1
        b[target] <- 0
        for (i in setdiff(1:N, target)) {
          A[i,] <- -P[i,]
          A[i,i] <- 1
        }
        h <- solve(A, b)
        H[,target] <- h
      }
      rownames(H) <- nodes
      colnames(H) <- nodes
      H
    }
    
    # 4. Computing and printing hitting times
    H <- hitting_time_matrix(P)
    print(round(H,2))

```

</details>

</details>

<details>
<summary>

## 11.8.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the effective resistance matrix of the network at http:
    # //www.networkatlas.eu/exercises/11/3/data.txt and prove it is
    # equal to the commute time divided by 2| E|. Note: differently from
    # above, the effective resistance matrix can be calculated in python
    # without an issue. But the second part of the exercise might fail if
    # not done in Octave (or Matlab).
    
    library(here)
    library(MASS)
    
    # Reading data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the effective resistance matrix of the network at http:
    # //www.networkatlas.eu/exercises/11/3/data.txt and prove it is
    # equal to the commute time divided by 2| E|. Note: differently from
    # above, the effective resistance matrix can be calculated in python
    # without an issue. But the second part of the exercise might fail if
    # not done in Octave (or Matlab).
    
    library(here)
    library(MASS)
    
    # Reading data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution 
    
    # Building the Laplacian
    N <- length(nodes)
    adj <- matrix(0, nrow=N, ncol=N)
    for(i in 1:nrow(edges)) {
      from <- match(edges$V1[i], nodes)
      to <- match(edges$V2[i], nodes)
      adj[from, to] <- 1
      adj[to, from] <- 1
    }
    deg <- rowSums(adj)
    L <- diag(deg) - adj
    
    # Computing the pseudoinverse of the Laplacian
    Lplus <- ginv(L)
    
    # Computing the effective resistance matrix
    R_eff <- matrix(0, N, N)
    for(i in 1:N) {
      for(j in 1:N) {
        R_eff[i,j] <- Lplus[i,i] + Lplus[j,j] - 2*Lplus[i,j]
      }
    }
    rownames(R_eff) <- nodes
    colnames(R_eff) <- nodes
    
    # Computing the commute time matrix
    n_edges <- nrow(edges)
    C <- 2 * n_edges * R_eff
    
    # Printing the values and Confirming the relation
    cat("Effective resistance\n")
    print(R_eff)
    cat("Commute time / (2*|E|)\n")
    print(C/(2*n_edges))
    cat("\nIs effective resistance == commute time / (2*|E|)?\n")
    print(all.equal(R_eff, C/(2*n_edges), tolerance=1e-8))
```

</details>

</details>

<details>
<summary>

## 11.8.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw the spectral plot of the network at http://www.networkatlas.
    # eu/exercises/11/5/data.txt, showing the relationship between
    # the second and third eigenvectors of its Laplacian. Can you find
    # clusters?
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Draw the spectral plot of the network at http://www.networkatlas.
    # eu/exercises/11/5/data.txt, showing the relationship between
    # the second and third eigenvectors of its Laplacian. Can you find
    # clusters?
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution 
    
    # Building the adjacency matrix
    N <- length(nodes)
    adj <- matrix(0, nrow=N, ncol=N)
    for (i in 1:nrow(edges)) {
      from <- match(edges$V1[i], nodes)
      to   <- match(edges$V2[i], nodes)
      adj[from, to] <- 1
      adj[to, from] <- 1  # undirected
    }
    
    # Compute the Laplacian matrix
    deg <- rowSums(adj)
    L <- diag(deg) - adj
    
    # Computing the eigenvalues/vectors of the Laplacian
    eig <- eigen(L)
    
    # Spectral plot: second (eig$vectors[,N-1]) and third (eig$vectors[,N-2]) smallest eigenvectors
    x <- eig$vectors[, N-1]
    y <- eig$vectors[, N-2]
    
    # Plotting
    plot(x, y, pch=19, col='blue', xlab="2nd eigenvector", ylab="3rd eigenvector", main="Spectral plot of the Laplacian")
    text(x, y, labels=nodes, pos=3, cex=0.7, col="darkred")
    
    # Trying basic clustering (e.g., k-means with k=3)
    km <- kmeans(cbind(x, y), 3)
    points(x, y, col=km$cluster, pch=19)
    print(data.frame(node=nodes, cluster=km$cluster))
```

</details>

</details>

<details>
<summary>

## 12.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the density of hypothetical undirected networks with
    # the following statistics: |V | = 26, | E| = 180; |V | = 44, | E| = 221;
    # |V | = 8, | E| = 201. Which of these networks is an impossible
    # topology (unless we allow it to be a multigraph)?
    
    # Defining the statistics
    networks <- data.frame(
      V = c(26, 44, 8),
      E = c(180, 221, 201)
    )
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the density of hypothetical undirected networks with
    # the following statistics: |V | = 26, | E| = 180; |V | = 44, | E| = 221;
    # |V | = 8, | E| = 201. Which of these networks is an impossible
    # topology (unless we allow it to be a multigraph)?
    
    # Defining the statistics
    networks <- data.frame(
      V = c(26, 44, 8),
      E = c(180, 221, 201)
    )
    
    # Solution 
    
    # Computing densities and checking if each network is a simple graph
    networks$density <- with(networks, 2 * E / (V * (V - 1)))
    networks$max_edges <- with(networks, V * (V - 1) / 2)
    networks$impossible <- networks$E > networks$max_edges
    
    # Printing the result 
    print(networks)

```

</details>

</details>

<details>
<summary>

## 12.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the density of hypothetical directed networks with the
    # following statistics: |V | = 15, | E| = 380; |V | = 77, | E| = 391;
    # |V | = 101, | E| = 566. Which of these networks is an impossible
    # topology (unless we allow it to be a multigraph)?
    
    # Defining network statistics
    networks <- data.frame(
      V = c(15, 77, 101),
      E = c(380, 391, 566)
    )
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the density of hypothetical directed networks with the
    # following statistics: |V | = 15, | E| = 380; |V | = 77, | E| = 391;
    # |V | = 101, | E| = 566. Which of these networks is an impossible
    # topology (unless we allow it to be a multigraph)?
    
    # Defining network statistics
    networks <- data.frame(
      V = c(15, 77, 101),
      E = c(380, 391, 566)
    )
    
    # Solution
    
    # Compute density and check feasibility
    networks$density <- with(networks, E / (V * (V - 1)))
    networks$max_edges <- with(networks, V * (V - 1))
    networks$impossible <- networks$E > networks$max_edges
    
    # Printing the result
    print(networks)
```

</details>

</details>

<details>
<summary>

## 12.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the global, average and local clustering coefficient for
    # the network in http://www.networkatlas.eu/exercises/12/3/
    # data.txt.
    
    library(here)
    #library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the global, average and local clustering coefficient for
    # the network in http://www.networkatlas.eu/exercises/12/3/
    # data.txt.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution 
    
    # Building the Adjacency Matrix
    N <- length(nodes)
    adj <- matrix(0, nrow=N, ncol=N)
    for (i in 1:nrow(edges)) {
      a <- match(edges$V1[i], nodes)
      b <- match(edges$V2[i], nodes)
      adj[a, b] <- 1
      adj[b, a] <- 1
    }
    
    # Computing Local Clustering Coefficients
    local_clustering <- function(adj) {
      N <- nrow(adj)
      c_vec <- numeric(N)
      for (i in 1:N) {
        neighbors <- which(adj[i, ] == 1)
        k <- length(neighbors)
        if (k < 2) {
          c_vec[i] <- 0
        } else {
          subgraph <- adj[neighbors, neighbors]
          edges_between_neighbors <- sum(subgraph) / 2
          c_vec[i] <- (2 * edges_between_neighbors) / (k * (k - 1))
        }
      }
      names(c_vec) <- nodes
      return(c_vec)
    }
    C_local <- local_clustering(adj)
    
    # Averaging Clustering Coefficient
    C_average <- mean(C_local)
    
    # Calculating the Global Clustering Coefficient
    g <- graph_from_adjacency_matrix(adj, mode="undirected")
    C_global <- transitivity(g, type="global")
    
    # Printing the results 
    cat("Global clustering coefficient:", C_global, "\n")
    cat("Average clustering coefficient:", C_average, "\n")
    cat("First few local clustering coefficients:\n")
    print(head(C_local))
```

</details>

</details>

<details>
<summary>

## 12.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the size in number of nodes of the largest maximal clique
    # of the network used in the previous question? Which nodes are
    # part of it?
    
    library(here)
    #library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the size in number of nodes of the largest maximal clique
    # of the network used in the previous question? Which nodes are
    # part of it?
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    nodes <- sort(unique(c(edges$V1, edges$V2)))
    
    # Solution
    
    # Building igraph object with explicit node names
    g <- graph_from_data_frame(edges, directed=FALSE, vertices=data.frame(name=nodes))
    
    # Finding all maximal cliques
    cliques <- maximal.cliques(g)
    
    # Finding the largest clique(s)
    max_size <- max(sapply(cliques, length))
    largest_cliques <- cliques[sapply(cliques, length) == max_size]
    
    # Printing the results
    cat("Size of the largest maximal clique:", max_size, "\n")
    cat("Nodes in the largest maximal clique(s):\n")
    for (i in seq_along(largest_cliques)) {
      clique_nodes <- V(g)$name[as.integer(largest_cliques[[i]])]
      cat("Clique", i, ":", sort(clique_nodes), "\n")
    }
```

</details>

</details>

<details>
<summary>

## 12.6.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the size in number of nodes of the largest independent
    # set of the network used in the previous question? (Approximate
    # answers are acceptable) Which nodes are part of it?
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the size in number of nodes of the largest independent
    # set of the network used in the previous question? (Approximate
    # answers are acceptable) Which nodes are part of it?
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, colClasses="character")
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Solution
    
    # Greedy algorithm: iteratively add lowest-degree vertex to the independent set
    independent_set <- c()
    remaining <- V(g)
    
    while(length(remaining) > 0) {
      degs <- degree(g, v=remaining)
      v <- remaining[which.min(degs)]
      independent_set <- c(independent_set, v)
      neighbors <- neighbors(g, v)
      to_remove <- union(v, neighbors)
      remaining <- setdiff(remaining, to_remove)
    }
    
    cat("Approximate size of large independent set found:", length(independent_set), "\n")
    cat("Nodes in the independent set:\n")
    print(V(g)$name[independent_set])
```

</details>

</details>

<details>
<summary>

## 13.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Label the nodes of the graph in Figure 13.12(a) in the order of
    # exploration of a BFS. Start from the node in the bottom right
    # corner.
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Label the nodes of the graph in Figure 13.12(a) in the order of
    # exploration of a BFS. Start from the node in the bottom right
    # corner.
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
    1,2,
    1,3,
    2,3,
    2,4,
    2,5,
    3,5,
    3,4,
    4,5,
    5,6,
    5,7,
    6,7,
    6,8,
    6,9,
    7,8,
    7,9,
    8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution
    
    # BFS from node 9 (bottom right)
    bfs_result <- bfs(g, root=9, order=TRUE)
    bfs_order <- bfs_result$order
    labels <- rep(NA, vcount(g))
    labels[bfs_order] <- seq_along(bfs_order)
    
    # Layout for nice visual match to figure
    layout_coords <- matrix(c(
      0.2, 1.0,   # node 1
      0.8, 1.0,   # node 2
      0.5, 0.8,   # node 3
      0.9, 0.5,   # node 4
      0.5, 0.6,   # node 5
      0.5, 0.4,   # node 6
      0.2, 0.3,   # node 7
      0.5, 0.2,   # node 8
      0.8, 0.2    # node 9 (start)
    ), byrow=TRUE, ncol=2)
    
    # Plot the graph
    plot(
      g, 
      layout=layout_coords, 
      vertex.color="red", 
      vertex.size=30, 
      vertex.label=labels, 
      vertex.label.color="white", 
      edge.width=4, 
      edge.color="darkgrey", 
      main="BFS Exploration Order (Start: Node 9)"
    )
    legend("bottomleft", legend="Node labels = BFS order", bty="n")
```

</details>

</details>

<details>
<summary>

## 13.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Label the nodes of the graph in Figure 13.12(a) in the order of
    # exploration of a DFS. Start from the node in the bottom right
    # corner.
    
    library(here)
    library(igraph)
    
    # Edge list for the undirected graph (no doubled links!)
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    
    # Build the undirected graph
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Label the nodes of the graph in Figure 13.12(a) in the order of
    # exploration of a DFS. Start from the node in the bottom right
    # corner.
    
    library(here)
    library(igraph)
    
    # Edge list for the undirected graph (no doubled links!)
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    
    # Build the undirected graph
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution
    
    # DFS from node 9 (bottom right)
    dfs_result <- dfs(g, root=9, order=TRUE)
    dfs_order <- dfs_result$order
    labels <- rep(NA, vcount(g))
    labels[dfs_order] <- seq_along(dfs_order)
    
    # Layout to match the "grid" visually
    layout_coords <- matrix(c(
      0.2, 1.0,   # node 1 (top left)
      0.8, 1.0,   # node 2 (top right)
      0.5, 0.8,   # node 3 (upper center)
      0.9, 0.5,   # node 4 (middle right)
      0.5, 0.6,   # node 5 (center)
      0.5, 0.4,   # node 6 (lower center)
      0.2, 0.3,   # node 7 (middle left)
      0.5, 0.2,   # node 8 (bottom center)
      0.8, 0.2    # node 9 (bottom right, START)
    ), byrow=TRUE, ncol=2)
    
    # Ploting the graph
    plot(
      g, 
      layout=layout_coords, 
      vertex.color="red", 
      vertex.size=30, 
      vertex.label=labels, 
      vertex.label.color="white", 
      edge.width=4, 
      edge.color="darkgrey", 
      main="DFS Exploration Order (Start: Node 9)"
    )
    legend("bottomleft", legend="Node labels = DFS order", bty="n")
```

</details>

</details>

<details>
<summary>

## 13.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate all shortest paths for the graph in Figure 13.12(a).
    
    library(here)
    library(igraph)
    
    # Create the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate all shortest paths for the graph in Figure 13.12(a).
    
    library(here)
    library(igraph)
    
    # Create the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution
    
    # Number of nodes
    n <- vcount(g)
    
    # Printing all shortest paths between every pair of nodes
    cat("All shortest paths between every pair of nodes:\n\n")
    for (from in 1:n) {
      for (to in 1:n) {
        if (from < to) { # Only print each pair once
          spaths <- all_shortest_paths(g, from=from, to=to)$res
          cat(sprintf("Shortest path(s) from %d to %d:\n", from, to))
          for (p in spaths) {
            cat("  ", paste(p, collapse = " -> "), "\n")
          }
          cat("\n")
        }
      }
    }
```

</details>

</details>

<details>
<summary>

## 13.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What’s the diameter of the graph in Figure 13.12(a)? What’s its
    # average path length?
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What’s the diameter of the graph in Figure 13.12(a)? What’s its
    # average path length?
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution 
    
    # Calculating the diameter (longest shortest path)
    graph_diameter <- diameter(g)
    cat("Diameter of the graph:", graph_diameter, "\n")
    
    # Calculating the average shortest path length
    avg_path_length <- average.path.length(g)
    cat("Average path length of the graph:", avg_path_length, "\n")
```

</details>

</details>

<details>
<summary>

## 14.10.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Based on the paths you calculated for your answer in the previous
    # chapter, calculate the closeness centrality of the nodes in Figure
    # 13.12(a).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Based on the paths you calculated for your answer in the previous
    # chapter, calculate the closeness centrality of the nodes in Figure
    # 13.12(a).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution
    
    # Computing closeness centrality for all nodes
    clo <- closeness(g, normalized=TRUE)
    
    # Printing closeness centrality
    cat("Closeness centrality for each node:\n")
    for(i in 1:vcount(g)) {
      cat(sprintf("Node %d: %.4f\n", i, clo[i]))
    }
```

</details>

</details>

<details>
<summary>

## 14.10.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the betweenness centrality of the nodes in Figure
    # 13.12(a). Use to your advantage the fact that there is a bottle-
    # neck node which makes the calculation of the shortest paths easier.
    # Don’t forget to discount paths with alternative routes.
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the betweenness centrality of the nodes in Figure
    # 13.12(a). Use to your advantage the fact that there is a bottle-
    # neck node which makes the calculation of the shortest paths easier.
    # Don’t forget to discount paths with alternative routes.
    
    library(here)
    library(igraph)
    
    # Building the undirected graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution 
    
    # Calculating betweenness centrality
    bc <- betweenness(g, normalized=FALSE)
    
    # Printing betweenness centrality for each node
    cat("Betweenness centrality for each node:\n")
    for (i in 1:vcount(g)) {
      cat(sprintf("Node %d: %.2f\n", i, bc[i]))
    }
```

</details>

</details>

<details>
<summary>

## 14.10.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the reach centrality for the network in http://www.
    # networkatlas.eu/exercises/14/3/data.txt. Keep in mind that
    # the network is directed and should be loaded as such. What’s the
    # most central node? How does its reach centrality compare with the
    # average reach centrality of all nodes in the network?
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Write here the solution 

```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the reach centrality for the network in http://www.
    # networkatlas.eu/exercises/14/3/data.txt. Keep in mind that
    # the network is directed and should be loaded as such. What’s the
    # most central node? How does its reach centrality compare with the
    # average reach centrality of all nodes in the network?
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Solution 
    
    # For each node, computing the number of reachable nodes (excluding itself)
    reach_centrality <- sapply(V(g), function(v) {
      # Use subcomponent to get all nodes reachable from v (mode = 'out')
      reachable <- subcomponent(g, v, mode = "out")
      # Exclude self
      length(reachable) - 1
    })
    
    # Find the most central nodes
    max_reach <- max(reach_centrality)
    most_central_nodes <- which(reach_centrality == max_reach)
    
    # Average reach centrality
    avg_reach <- mean(reach_centrality)
    
    cat("Reach centrality for each node:\n")
    for (i in 1:length(reach_centrality)) {
      cat(sprintf("Node %s: %d\n", V(g)[i]$name, reach_centrality[i]))
    }
    cat("\n")
    
    cat("Most central node(s):", paste(V(g)[most_central_nodes]$name, collapse=", "), "\n")
    cat("Their reach centrality:", max_reach, "\n")
    cat("Average reach centrality:", avg_reach, "\n")
    cat(sprintf("The most central node's reach centrality is %.2f times the average.\n",
                max_reach / avg_reach))
```

</details>

</details>

<details>
<summary>

## 14.10.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What’s the most central node in the network used for the previous
    # exercise according to PageRank? How does PageRank compares
    # with the in-degree? (for instance, you could calculate the Spear-
    # man and/or Pearson correlation between the two)
    
    library(here)
    library(igraph)
    
    # Building the graph (reusing your code)
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What’s the most central node in the network used for the previous
    # exercise according to PageRank? How does PageRank compares
    # with the in-degree? (for instance, you could calculate the Spear-
    # man and/or Pearson correlation between the two)
    
    library(here)
    library(igraph)
    
    # Building the graph (reusing your code)
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Solution 
    
    # Calculating PageRank for each node
    pr <- page.rank(g)$vector
    
    # Finding the most central node(s) by PageRank
    max_pr <- max(pr)
    most_central_pagerank_nodes <- which(pr == max_pr)
    
    # Calculating in-degree for each node
    in_deg <- degree(g, mode = "in")
    
    # Comparing PageRank with in-degree using correlations
    spearman_cor <- cor(pr, in_deg, method = "spearman")
    pearson_cor <- cor(pr, in_deg, method = "pearson")
    
    # Printing results
    cat("PageRank for each node:\n")
    for (i in 1:length(pr)) {
      cat(sprintf("Node %s: %.4f\n", V(g)[i]$name, pr[i]))
    }
    cat("\n")
    
    cat("Most central node(s) by PageRank:", paste(V(g)[most_central_pagerank_nodes]$name, collapse=", "), "\n")
    cat("Highest PageRank value:", max_pr, "\n")
    cat("\n")
    
    cat("In-degree for each node:\n")
    for (i in 1:length(in_deg)) {
      cat(sprintf("Node %s: %d\n", V(g)[i]$name, in_deg[i]))
    }
    cat("\n")
    
    cat(sprintf("Spearman correlation between PageRank and in-degree: %.4f\n", spearman_cor))
    cat(sprintf("Pearson correlation between PageRank and in-degree: %.4f\n", pearson_cor))
```

</details>

</details>

<details>
<summary>

## 14.10.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Which is the most authoritative node in the network used for
    # the previous question? Which one is the best hub? Use the HITS
    # algorithm to motivate your answer (if using networkx, use the
    # scipy version of the algorithm).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Which is the most authoritative node in the network used for
    # the previous question? Which one is the best hub? Use the HITS
    # algorithm to motivate your answer (if using networkx, use the
    # scipy version of the algorithm).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=TRUE)
    
    # Solution
    
    # Computing PageRank for each node
    pr <- page.rank(g)$vector
    
    # Computing in-degree for each node
    indeg <- degree(g, mode="in")
    
    # Finding the most central node(s) by PageRank
    max_pr <- max(pr)
    most_central_nodes <- which(pr == max_pr)
    cat("Most central node(s) by PageRank (numeric ID):", most_central_nodes, "\n")
    cat("Highest PageRank value:", max_pr, "\n\n")
    
    # Printing a table of
    cat("Node\tPageRank\tIn-degree\n")
    for (i in 1:vcount(g)) {
      cat(sprintf("%d\t%.4f\t\t%d\n", i, pr[i], indeg[i]))
    }
    
    cat("\n")
    
    # Calculating Spearman and Pearson correlation between PageRank and in-degree
    spearman_corr <- cor(pr, indeg, method="spearman")
    pearson_corr  <- cor(pr, indeg, method="pearson")
    cat(sprintf("Spearman correlation between PageRank and in-degree: %.4f\n", spearman_corr))
    cat(sprintf("Pearson correlation between PageRank and in-degree: %.4f\n", pearson_corr))
```

</details>

</details>

<details>
<summary>

## 14.10.6

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Based on the paths you calculated for your answer in the previous
    # chapter, calculate the harmonic centrality of the nodes in Figure
    # 13.12(a).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Based on the paths you calculated for your answer in the previous
    # chapter, calculate the harmonic centrality of the nodes in Figure
    # 13.12(a).
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- matrix(c(
      1,2,
      1,3,
      2,3,
      2,4,
      2,5,
      3,5,
      3,4,
      4,5,
      5,6,
      5,7,
      6,7,
      6,8,
      6,9,
      7,8,
      7,9,
      8,9
    ), byrow=TRUE, ncol=2)
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution 
    
    # Compute all-pairs shortest paths
    dists <- distances(g)
    
    # Harmonic centrality: sum of 1/distance (excluding self, and ignoring infinite)
    harmonic_centrality <- sapply(1:vcount(g), function(i) {
      di <- dists[i, ]
      # Exclude self, and handle Inf (disconnected, not needed here as graph is connected)
      sum(1/di[di != 0])
    })
    
    cat("Harmonic centrality for each node:\n")
    for (i in 1:length(harmonic_centrality)) {
      cat(sprintf("Node %d: %.4f\n", i, harmonic_centrality[i]))
    }
```

</details>

</details>

<details>
<summary>

## 14.10.7

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the k-core decomposition of the network in http://www.
    # networkatlas.eu/exercises/14/7/data.txt. What’s the highest
    # core number in the network? How many nodes are part of the
    # maximum core?
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the k-core decomposition of the network in http://www.
    # networkatlas.eu/exercises/14/7/data.txt. What’s the highest
    # core number in the network? How many nodes are part of the
    # maximum core?
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution 
    
    core_numbers <- coreness(g)
    max_core <- max(core_numbers)
    num_max_core_nodes <- sum(core_numbers == max_core)
    
    cat("Highest core number (max k):", max_core, "\n")
    cat("Number of nodes in the maximum core:", num_max_core_nodes, "\n")
    cat("Nodes in the maximum core:\n")
    print(V(g)[core_numbers == max_core])
```

</details>

</details>

<details>
<summary>

## 14.10.8

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What’s the degree of centralization of the network used in the
    # previous question? Compare the answer you’d get by using, as
    # your centrality measure, the degree, closeness, and betweenness
    # centrality.
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What’s the degree of centralization of the network used in the
    # previous question? Compare the answer you’d get by using, as
    # your centrality measure, the degree, closeness, and betweenness
    # centrality.
    
    library(here)
    library(igraph)
    
    # Building the graph
    edges <- as.matrix(read.table("data.txt"))
    g <- graph_from_edgelist(edges, directed=FALSE)
    
    # Solution
    
    # Calculating centralization measures
    deg_cent <- centr_degree(g, normalized=TRUE)$centralization
    clo_cent <- centr_clo(g, normalized=TRUE)$centralization
    bet_cent <- centr_betw(g, normalized=TRUE)$centralization
    
    cat(sprintf("Degree centralization:      %.4f\n", deg_cent))
    cat(sprintf("Closeness centralization:  %.4f\n", clo_cent))
    cat(sprintf("Betweenness centralization:%.4f\n", bet_cent))
```

</details>

</details>

<details>
<summary>

## 15.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # For the network at http://www.networkatlas.eu/exercises/15/
    # 1/data.txt, I precomputed communities (http://www.networkatlas.
    # eu/exercises/15/1/comms.txt). Use betweenness centrality to
    # distinguish between brokers (high centrality nodes equally con-
    # necting to different communities) and gatekeepers (high centrality
    # nodes connecting with different communities but preferring their
    # own).
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    V(g)$community <- comms$community[match(V(g)$name, comms$node)]
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # For the network at http://www.networkatlas.eu/exercises/15/
    # 1/data.txt, I precomputed communities (http://www.networkatlas.
    # eu/exercises/15/1/comms.txt). Use betweenness centrality to
    # distinguish between brokers (high centrality nodes equally con-
    # necting to different communities) and gatekeepers (high centrality
    # nodes connecting with different communities but preferring their
    # own).
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    V(g)$community <- comms$community[match(V(g)$name, comms$node)]
    
    # Solution 
    
    # Betweenness centrality
    V(g)$betweenness <- betweenness(g, normalized=TRUE)
    
    # Community mixing
    get_neighbor_comms <- function(graph, v) {
      neighbor_comm <- V(graph)$community[neighbors(graph, v)]
      table(neighbor_comm)
    }
    V(g)$own_comm_frac <- sapply(V(g), function(v) {
      neighbor_comms <- get_neighbor_comms(g, v)
      own_comm <- V(g)$community[v]
      own <- neighbor_comms[as.character(own_comm)]
      total <- sum(neighbor_comms)
      ifelse(is.na(own), 0, own/total)
    })
    
    # Identifying brokers and gatekeepers
    bet_threshold <- quantile(V(g)$betweenness, 0.9)
    V(g)$role <- "other"
    V(g)$role[V(g)$betweenness >= bet_threshold & V(g)$own_comm_frac <= 0.5] <- "broker"
    V(g)$role[V(g)$betweenness >= bet_threshold & V(g)$own_comm_frac > 0.5] <- "gatekeeper"
    
    # Printing the results 
    results <- data.frame(
      node = V(g)$name,
      community = V(g)$community,
      betweenness = V(g)$betweenness,
      own_comm_frac = V(g)$own_comm_frac,
      role = V(g)$role
    )
    print(results[order(-results$betweenness), ])
```

</details>

</details>

<details>
<summary>

## 15.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the network from the previous question to distinguish be-
    # tween core community nodes (high degree nodes with all their
    # connections going to members of their own community) and
    # peripheral community nodes (low degree nodes with all their
    # connections going to members of their own community).
    
    library(here)
    library(igraph)
    
    # Reading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    V(g)$community <- comms$community[match(V(g)$name, comms$node)]
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the network from the previous question to distinguish be-
    # tween core community nodes (high degree nodes with all their
    # connections going to members of their own community) and
    # peripheral community nodes (low degree nodes with all their
    # connections going to members of their own community).
    
    library(here)
    library(igraph)
    
    # Reading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    comms <- read.table("comms.txt", header=FALSE, col.names=c("node", "community"))
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    V(g)$community <- comms$community[match(V(g)$name, comms$node)]
    
    # Solution 
    
    # Computing degree and neighbor community fractions
    V(g)$degree <- degree(g)
    
    V(g)$own_comm_frac <- sapply(V(g), function(v) {
      neighbor_comms <- V(g)$community[neighbors(g, v)]
      own_comm <- V(g)$community[v]
      if (length(neighbor_comms) == 0) return(NA)
      sum(neighbor_comms == own_comm) / length(neighbor_comms)
    })
    
    # Classifying nodes
    high_degree_threshold <- quantile(V(g)$degree, 0.75)
    low_degree_threshold  <- quantile(V(g)$degree, 0.25)
    
    V(g)$comm_role <- NA
    V(g)$comm_role[V(g)$own_comm_frac == 1 & V(g)$degree >= high_degree_threshold] <- "core"
    V(g)$comm_role[V(g)$own_comm_frac == 1 & V(g)$degree <= low_degree_threshold]  <- "peripheral"
    V(g)$comm_role[is.na(V(g)$comm_role)] <- "other"
    
    # Printign the results
    results <- data.frame(
      node = V(g)$name,
      community = V(g)$community,
      degree = V(g)$degree,
      own_comm_frac = V(g)$own_comm_frac,
      comm_role = V(g)$comm_role
    )
    print(results[order(-results$degree), ])
```

</details>

</details>

<details>
<summary>

## 15.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the structural equivalence of all pairs of nodes from the
    # network used in the previous question. Which two nodes are the
    # most similar? (Note: there could be ties)
    # Calculate the structural equivalence of all pairs of nodes from the
    # network used in the previous question. Which two nodes are the
    # most similar? (Note: there could be ties)
    
    library(here)
    library(igraph)
    
    # Reading data and build the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the structural equivalence of all pairs of nodes from the
    # network used in the previous question. Which two nodes are the
    # most similar? (Note: there could be ties)
    # Calculate the structural equivalence of all pairs of nodes from the
    # network used in the previous question. Which two nodes are the
    # most similar? (Note: there could be ties)
    
    library(here)
    library(igraph)
    
    # Reading data and build the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Computing Jaccard similarity for all pairs (excluding self-similarities)
    jac <- similarity(g, mode="all", method="jaccard")
    diag(jac) <- NA
    
    # Finding the maximum similarity (excluding self-pairs)
    max_sim <- max(jac, na.rm=TRUE)
    
    # Getting all pairs with this maximum similarity
    max_pairs <- which(jac == max_sim, arr.ind=TRUE)
    node_names <- V(g)$name
    
    # Printing all most similar pairs
    cat("Most structurally equivalent pairs (Jaccard similarity =", max_sim, "):\n")
    for (i in 1:nrow(max_pairs)) {
      cat(node_names[max_pairs[i,1]], "<->", node_names[max_pairs[i,2]], "\n")
    }
```

</details>

</details>

<details>
<summary>

## 16.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Consider the network in http://www.networkatlas.eu/exercises/
    # 16/1/data.txt. Generate an Erdős-Rényi graph with the same
    # number of nodes and edges. Plot both networks’ degree CCDFs,
    # in log-log scale. Discuss the salient differences between these
    # istributions.
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Consider the network in http://www.networkatlas.eu/exercises/
    # 16/1/data.txt. Generate an Erdős-Rényi graph with the same
    # number of nodes and edges. Plot both networks’ degree CCDFs,
    # in log-log scale. Discuss the salient differences between these
    # istributions.
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Erdős-Rényi graph
    n_nodes <- vcount(g)
    n_edges <- ecount(g)
    set.seed(42)
    g_er <- sample_gnm(n=n_nodes, m=n_edges, directed=FALSE)
    
    # Degree CCDFs
    degree_ccdf <- function(degrees) {
      degs <- sort(unique(degrees))
      ccdf <- sapply(degs, function(k) mean(degrees >= k))
      data.frame(degree=degs, ccdf=ccdf)
    }
    
    deg_g   <- degree(g)
    deg_er  <- degree(g_er)
    ccdf_g  <- degree_ccdf(deg_g)
    ccdf_er <- degree_ccdf(deg_er)
    
    # printign the plot 
    plot(ccdf_g$degree, ccdf_g$ccdf, log="xy", type="b", col="blue", pch=19,
         xlab="Degree (log)", ylab="CCDF (log)", main="Degree CCDF (log-log)")
    points(ccdf_er$degree, ccdf_er$ccdf, col="red", pch=17, type="b")
    legend("bottomleft", legend=c("Original Network", "Erdős-Rényi"),
           col=c("blue", "red"), pch=c(19,17), lty=1)
    
    # Discussion: 
    
    # - Original Network: Often has a "heavy tail" (some nodes with much higher 
    # degree than the average), suggesting hubs or scale-free structure.
    
    # - Erdős-Rényi: Degree distribution is binomial/Poisson-like, so the CCDF 
    # drops off exponentially, with very small chance of high-degree nodes.

```

</details>

</details>

<details>
<summary>

## 16.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a series of Erdős-Rényi graphs with 1, 000 nodes and
    # n increasing p value, from .00025 to .0025, with increments of
    # .000025. Make a plot with the p value on the x axis and the size of
    # the largest connected component on the y axis. Can you find the
    # phase transition?
    
    library(here)
    library(igraph)
    
    # Setting up the parameters
    n <- 1000
    p_vals <- seq(0.00025, 0.0025, by=0.000025)
    largest_cc_sizes <- numeric(length(p_vals))
    set.seed(42) # For reproducibility
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a series of Erdős-Rényi graphs with 1, 000 nodes and
    # n increasing p value, from .00025 to .0025, with increments of
    # .000025. Make a plot with the p value on the x axis and the size of
    # the largest connected component on the y axis. Can you find the
    # phase transition?
    
    library(here)
    library(igraph)
    
    # Setting up the parameters
    n <- 1000
    p_vals <- seq(0.00025, 0.0025, by=0.000025)
    largest_cc_sizes <- numeric(length(p_vals))
    set.seed(42) # For reproducibility
    
    # Solution 
    
    # Generating Graphs and Computing largest component size
    for (i in seq_along(p_vals)) {
      g <- sample_gnp(n, p_vals[i], directed=FALSE)
      comps <- components(g)
      largest_cc_sizes[i] <- max(comps$csize)
    }
    
    # Plotting the results
    plot(p_vals, largest_cc_sizes, type="b", pch=19,
         xlab="p (edge probability)",
         ylab="Largest Connected Component Size",
         main="Phase Transition in Erdős-Rényi Graph (n = 1000)")
    
    # In the plot, should be visible that the real network’s degree CCDF decreases 
    # more slowly and exhibits a heavier tail than the Erdős-Rényi graph, indicating 
    # the presence of nodes with much higher degree (hubs), while the Erdős-Rényi 
    # graph’s CCDF drops off rapidly, reflecting its narrow, random degree 
    # distribution.
```

</details>

</details>

<details>
<summary>

## 16.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a series of Erdős-Rényi graphs with p = .02 and increas-
    # ing number of nodes, from 200 to 1, 400 with increments of 200.
    # Make a plot with the |V | value on the x axis and the average path
    # length on the y axis. Since the graph might not be connected, only
    # consider the largest connected component. How does the APL
    # scale with the number of nodes?
    
    library(here)
    library(igraph)
    
    # Setting parameters
    p <- 0.02
    v_vals <- seq(200, 1400, by=200)
    apl_vals <- numeric(length(v_vals))  # to store average path length
    set.seed(42)  # for reproducibility
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a series of Erdős-Rényi graphs with p = .02 and increas-
    # ing number of nodes, from 200 to 1, 400 with increments of 200.
    # Make a plot with the |V | value on the x axis and the average path
    # length on the y axis. Since the graph might not be connected, only
    # consider the largest connected component. How does the APL
    # scale with the number of nodes?
    
    library(here)
    library(igraph)
    
    # Setting parameters
    p <- 0.02
    v_vals <- seq(200, 1400, by=200)
    apl_vals <- numeric(length(v_vals))  # to store average path length
    set.seed(42)  # for reproducibility
    
    # Solution 
    
    # Generating Graphs and extracting the largest connected component
    for (i in seq_along(v_vals)) {
      n <- v_vals[i]
      g <- sample_gnp(n, p, directed=FALSE)
      
      # Extract the largest connected component
      comps <- components(g)
      giant <- which.max(comps$csize)
      v_giant <- V(g)[comps$membership == giant]
      g_giant <- induced_subgraph(g, v_giant)
      
      # Compute average path length
      apl_vals[i] <- average.path.length(g_giant)
    }
    
    # Plotting the result 
    plot(v_vals, apl_vals, type="b", pch=19, col="blue",
         xlab="Number of nodes (|V|)", ylab="Average Path Length (APL)",
         main="APL of Erdős-Rényi Graphs (p = 0.02)")
    
    # Interpretation
    
    # - The APL in Erdős-Rényi graphs typically grows like (\log(|V|)) for fixed (p)
    # (if the graph is connected or for the giant component).
    
    # - Your plot should show a slowly increasing curve, roughly resembling a 
    # logarithmic function
```

</details>

</details>

<details>
<summary>

## 16.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate an Erdős-Rényi graph with the same number of nodes
    # and edges as the network used for question 1. Calculate and
    # compare the networks’ clustering coefficients. Compare this with
    # the connection probability p of the random graph (which you
    # should derive from the number of edges and number of nodes
    # using the formula I show in this chapter).
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Number of nodes and edges
    n_nodes <- vcount(g)
    n_edges <- ecount(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate an Erdős-Rényi graph with the same number of nodes
    # and edges as the network used for question 1. Calculate and
    # compare the networks’ clustering coefficients. Compare this with
    # the connection probability p of the random graph (which you
    # should derive from the number of edges and number of nodes
    # using the formula I show in this chapter).
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Number of nodes and edges
    n_nodes <- vcount(g)
    n_edges <- ecount(g)
    
    # Solution 
    
    # ER connection probability
    p_er <- 2 * n_edges / (n_nodes * (n_nodes - 1))
    cat("Nodes:", n_nodes, "Edges:", n_edges, "\n")
    cat("Connection probability p (ER):", p_er, "\n")
    
    # Generating ER random graph
    set.seed(42)
    g_er <- sample_gnm(n_nodes, n_edges, directed=FALSE)
    
    # Clustering coefficients
    cc_real <- transitivity(g, type="global")
    cc_er   <- transitivity(g_er, type="global")
    cat("Clustering coefficient (real network):", cc_real, "\n")
    cat("Clustering coefficient (ER):", cc_er, "\n")
    
    ################################################################################
    # Optional
    # Plotting both graphs side by side
    par(mfrow=c(1,2), mar=c(1,1,2,1))
    plot(g,
         vertex.size=5,
         vertex.label=NA,
         edge.arrow.size=0.5,
         layout=layout_with_fr,
         main="Original Network")
    plot(g_er,
         vertex.size=5,
         vertex.label=NA,
         edge.arrow.size=0.5,
         layout=layout_with_fr,
         main="Erdős-Rényi Random Graph")
    par(mfrow=c(1,1))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 17.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a connected caveman graph with 10 cliques, each with
    # 10 nodes. Generate a small world graph with 100 nodes, each
    # connected to 8 of their neighbors. Add shortcuts for each edge
    # with probability of .05. The two graphs have approximately the
    # same number of edges. Compare their clustering coefficients and
    # their average path lengths.
    
    library(here)
    library(igraph)
    
    ##################### Making graphs #####################
    # g_cave <- make_connected_caveman(10, 10) # sostitute of this line
    
    # Parameters
    num_cliques <- 10
    clique_size <- 10
    
    # Create empty graph
    g_cave <- make_empty_graph(n = 0, directed = FALSE)
    
    # Add cliques one by one
    for (i in 0:(num_cliques-1)) {
      # Each clique's nodes
      nodes <- (i*clique_size + 1):((i+1)*clique_size)
      clique <- make_full_graph(clique_size)
      # Relabel the clique to correct node numbers
      clique <- set_vertex_attr(clique, "name", value=as.character(nodes))
      # Union with the main graph
      g_cave <- g_cave %u% clique
    }
    
    # Connect each clique to the next by rewiring one edge
    for (i in 1:(num_cliques-1)) {
      g_cave <- add_edges(g_cave, c(i*clique_size, i*clique_size + 1))
    }
    
    # Last graph 
    g_sw <- sample_smallworld(dim=1, size=100, nei=4, p=0.05)
    
    #####################               #####################
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a connected caveman graph with 10 cliques, each with
    # 10 nodes. Generate a small world graph with 100 nodes, each
    # connected to 8 of their neighbors. Add shortcuts for each edge
    # with probability of .05. The two graphs have approximately the
    # same number of edges. Compare their clustering coefficients and
    # their average path lengths.
    
    library(here)
    library(igraph)
    
    ##################### Making graphs #####################
    # g_cave <- make_connected_caveman(10, 10) # Error at this line, but 
    
    # Parameters
    num_cliques <- 10
    clique_size <- 10
    
    # Create empty graph
    g_cave <- make_empty_graph(n = 0, directed = FALSE)
    
    # Add cliques one by one
    for (i in 0:(num_cliques-1)) {
      # Each clique's nodes
      nodes <- (i*clique_size + 1):((i+1)*clique_size)
      clique <- make_full_graph(clique_size)
      # Relabel the clique to correct node numbers
      clique <- set_vertex_attr(clique, "name", value=as.character(nodes))
      # Union with the main graph
      g_cave <- g_cave %u% clique
    }
    
    # Connect each clique to the next by rewiring one edge
    for (i in 1:(num_cliques-1)) {
      g_cave <- add_edges(g_cave, c(i*clique_size, i*clique_size + 1))
    }
    
    # last graph 
    g_sw <- sample_smallworld(dim=1, size=100, nei=4, p=0.05)
    
    #####################               #####################
    
    # Solution 
    
    # Edge counting (for comparison)
    cat("Caveman edges:", ecount(g_cave), "\n")
    cat("Small world edges:", ecount(g_sw), "\n")
    
    # Clustering coefficients
    cc_cave <- transitivity(g_cave, type="global")
    cc_sw   <- transitivity(g_sw, type="global")
    
    # Average path lengths
    apl_cave <- average.path.length(g_cave)
    apl_sw   <- average.path.length(g_sw)
    
    cat("Caveman clustering coefficient:", cc_cave, "\n")
    cat("Small world clustering coefficient:", cc_sw, "\n")
    cat("Caveman average path length:", apl_cave, "\n")
    cat("Small world average path length:", apl_sw, "\n")
    
    ################################################################################
    # Optional:
    # Plotting both graphs side by side
    
    par(mfrow=c(1,2), mar=c(1,1,2,1))
    plot(g_cave,
         vertex.size=5,
         vertex.label=NA,
         edge.arrow.size=0.5,
         layout=layout_with_fr,
         main="Connected Caveman Graph")
    plot(g_sw,
         vertex.size=5,
         vertex.label=NA,
         edge.arrow.size=0.5,
         layout=layout_with_fr,
         main="Small World Graph")
    par(mfrow=c(1,1))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 17.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a preferential attachment network with 2, 000 nodes and
    # average degree of 2. Estimate its degree distribution exponent
    # (you can use either the powerlaw package, or do a simple log-log
    # regression of the CCDF).
    
    library(here)
    library(igraph)
    
    # Generate the network
    set.seed(42)
    g <- sample_pa(n = 2000, m = 1, directed = FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a preferential attachment network with 2, 000 nodes and
    # average degree of 2. Estimate its degree distribution exponent
    # (you can use either the powerlaw package, or do a simple log-log
    # regression of the CCDF).
    
    library(here)
    library(igraph)
    
    # Generate the network
    set.seed(42)
    g <- sample_pa(n = 2000, m = 1, directed = FALSE)
    
    # Solution 
    
    # Calculating the degree sequence
    deg <- degree(g)
    
    # Computing the CCDF (Complementary Cumulative Distribution Function)
    deg_tab <- table(deg)
    deg_vals <- as.numeric(names(deg_tab))
    deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
    ccdf <- rev(cumsum(rev(deg_prob)))
    
    # Log-log regression (excluding degree 0)
    min_deg <- 1
    sel <- deg_vals >= min_deg
    log_k <- log(deg_vals[sel])
    log_ccdf <- log(ccdf[sel])
    
    fit <- lm(log_ccdf ~ log_k)
    gamma_est <- -coef(fit)[2] + 1
    
    # Plotting the results
    plot(deg_vals, ccdf, log="xy", xlab="Degree (k)", ylab="CCDF", pch=19,
         main="Degree CCDF (log-log) for Preferential Attachment")
    abline(fit, col="red")
    legend("bottomleft", legend=paste("Estimated gamma =", round(gamma_est, 2)), bty="n")
    
    # Printing last elaboration
    cat("Estimated power-law exponent (gamma):", gamma_est, "\n")
```

</details>

</details>

<details>
<summary>

## 17.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement the link selection model to grow the graph in http:
    # //www.networkatlas.eu/exercises/17/3/data.txt to 2, 000 nodes
    # (for each incoming node, copy 2 edges already present in the net-
    # work). Compare the number of edges and the degree distribution
    # exponent with a preferential attachment network with 2, 000 nodes
    # and average degree of 2.
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE)
    # Finding all unique node labels and create a mapping to 1:N
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    
    # Remapping the edge list
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    
    # Building the graph
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement the link selection model to grow the graph in http:
    # //www.networkatlas.eu/exercises/17/3/data.txt to 2, 000 nodes
    # (for each incoming node, copy 2 edges already present in the net-
    # work). Compare the number of edges and the degree distribution
    # exponent with a preferential attachment network with 2, 000 nodes
    # and average degree of 2.
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE)
    # Finding all unique node labels and create a mapping to 1:N
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    
    # Remapping the edge list
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    
    # Building the graph
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution
    
    # Growing with link selection model
    set.seed(42)
    while (vcount(g) < 2000) {
      new_node <- vcount(g) + 1
      edge_indices <- sample(ecount(g), 2, replace=FALSE)
      ends_mat <- ends(g, edge_indices)
      targets <- apply(ends_mat, 1, function(x) sample(x, 1))
      g <- add_vertices(g, 1)
      g <- add_edges(g, c(rbind(new_node, targets)))
    }
    
    # Preferential attachment
    g_pa <- sample_pa(n=2000, m=1, directed=FALSE)
    
    # Compare edge counts
    cat("Link selection graph edges:", ecount(g), "\n")
    cat("Preferential attachment graph edges:", ecount(g_pa), "\n")
    
    # Degree exponents
    degree_exp <- function(g) {
      deg <- degree(g)
      tab <- table(deg)
      deg_vals <- as.numeric(names(tab))
      deg_prob <- as.numeric(tab) / sum(tab)
      ccdf <- rev(cumsum(rev(deg_prob)))
      sel <- deg_vals >= 1
      fit <- lm(log(ccdf[sel]) ~ log(deg_vals[sel]))
      gamma <- -coef(fit)[2] + 1
      list(gamma=gamma, deg_vals=deg_vals, ccdf=ccdf, fit=fit)
    }
    le <- degree_exp(g)
    pa <- degree_exp(g_pa)
    
    cat(sprintf("Link selection model degree exponent: %.2f\n", le$gamma))
    cat(sprintf("Preferential attachment degree exponent: %.2f\n", pa$gamma))
    
    # Plotting degree distributions
    plot(le$deg_vals, le$ccdf, log="xy", col="blue", pch=19,
         xlab="Degree (k)", ylab="CCDF", main="Degree CCDF (log-log)",
         xlim=c(1, max(le$deg_vals, pa$deg_vals)), ylim=c(1e-4, 1))
    points(pa$deg_vals, pa$ccdf, col="red", pch=19)
    legend("bottomleft", legend=c("Link selection", "Pref. Attach."),
           col=c("blue", "red"), pch=19)
```

</details>

</details>

<details>
<summary>

## 17.5.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement the copying model to grow the graph in http://www.
    # networkatlas.eu/exercises/17/4/data.txt to 2, 000 nodes (for
    # each incoming node, copy one edge from 2 nodes already present
    # in the network). Compare the number of edges and the degree
    # distribution exponent with networks generated with the strategies
    # from the previous two questions.
    
    library(here)
    library(igraph)
    
    # Reading and remapping edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement the copying model to grow the graph in http://www.
    # networkatlas.eu/exercises/17/4/data.txt to 2, 000 nodes (for
    # each incoming node, copy one edge from 2 nodes already present
    # in the network). Compare the number of edges and the degree
    # distribution exponent with networks generated with the strategies
    # from the previous two questions.
    
    library(here)
    library(igraph)
    
    # Reading and remapping edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution 
    
    # Growing with copying model
    set.seed(42)
    while (vcount(g) < 2000) {
      new_node <- vcount(g) + 1
      existing_nodes <- sample(1:(new_node-1), 2, replace=FALSE)
      targets <- c()
      for (v in existing_nodes) {
        neighbors_v <- neighbors(g, v)
        if (length(neighbors_v) > 0) {
          tgt <- sample(neighbors_v, 1)
          targets <- c(targets, tgt)
        } else {
          targets <- c(targets, sample(1:(new_node-1), 1))
        }
      }
      g <- add_vertices(g, 1)
      g <- add_edges(g, c(rbind(new_node, targets)))
    }
    
    # Preferential attachment
    g_pa <- sample_pa(2000, m=1, directed=FALSE)
    
    # Exponent estimation
    estimate_exponent <- function(graph) {
      deg <- degree(graph)
      deg_tab <- table(deg)
      deg_vals <- as.numeric(names(deg_tab))
      deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
      ccdf <- rev(cumsum(rev(deg_prob)))
      sel <- deg_vals >= 1
      fit <- lm(log(ccdf[sel]) ~ log(deg_vals[sel]))
      gamma <- -coef(fit)[2] + 1
      list(gamma=gamma, deg_vals=deg_vals, ccdf=ccdf, fit=fit)
    }
    
    exp_copy <- estimate_exponent(g)
    exp_pa <- estimate_exponent(g_pa)
    
    # Printing the results 
    
    cat("Copying model edges:", ecount(g), "\n")
    cat(sprintf("Copying model degree exponent: %.2f\n", exp_copy$gamma))
    cat("Pref. attach. model edges:", ecount(g_pa), "\n")
    cat(sprintf("Pref. attach. model degree exponent: %.2f\n", exp_pa$gamma))
    
    # Plotting the results
    plot(exp_copy$deg_vals, exp_copy$ccdf, log="xy", col="blue", pch=19,
         xlab="Degree (k)", ylab="CCDF", main="Degree CCDF (log-log)",
         xlim=c(1, max(exp_copy$deg_vals, exp_pa$deg_vals)), ylim=c(1e-4, 1))
    points(exp_pa$deg_vals, exp_pa$ccdf, col="red", pch=19)
    legend("bottomleft", legend=c("Copying model", "Pref. Attach."),
           col=c("blue", "red"), pch=19)
```

</details>

</details>

<details>
<summary>

## 18.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate a configuration model with the same degree distribution
    # as the network in http://www.networkatlas.eu/exercises/18/1/
    # data.txt. Perform the Kolmogorov-Smirnov test between the two
    # degree distributions.
    
    library(here)
    library(igraph)
    
    # Reading edge list and remapping node IDs
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate a configuration model with the same degree distribution
    # as the network in http://www.networkatlas.eu/exercises/18/1/
    # data.txt. Perform the Kolmogorov-Smirnov test between the two
    # degree distributions.
    
    library(here)
    library(igraph)
    
    # Reading edge list and remapping node IDs
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution
    
    # Creating configuration model with the same degree distribution
    deg_seq <- degree(g)
    g_conf <- sample_degseq(deg_seq, method="simple")
    
    # Kolmogorov-Smirnov test
    deg_g <- degree(g)
    deg_conf <- degree(g_conf)
    ks <- ks.test(deg_g, deg_conf)
    print(ks)
    
    ################################################################################
    # OptionaL
    # Plotting the graph
    hist(deg_g, breaks=50, col=rgb(0,0,1,0.5), xlim=range(c(deg_g, deg_conf)), 
         xlab="Degree", main="Degree Distributions")
    hist(deg_conf, breaks=50, col=rgb(1,0,0,0.5), add=TRUE)
    legend("topright", legend=c("Original", "Config Model"), fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 18.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Remove the self-loops and parallel edges from the synthetic
    # network you generated in the previous question. Note the % of
    # edges you lost. Re-perform the Kolmogorov-Smirnov test with the
    # original network’s degree distribution.
    
    library(here)
    library(igraph)
    
    # Reading edge list and remapping node IDs
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Creating configuration model with the same degree distribution
    deg_seq <- degree(g)
    g_conf <- sample_degseq(deg_seq, method="simple")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Remove the self-loops and parallel edges from the synthetic
    # network you generated in the previous question. Note the % of
    # edges you lost. Re-perform the Kolmogorov-Smirnov test with the
    # original network’s degree distribution.
    
    library(here)
    library(igraph)
    
    # Reading edge list and remapping node IDs
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Creating configuration model with the same degree distribution
    deg_seq <- degree(g)
    g_conf <- sample_degseq(deg_seq, method="simple")
    
    # Solution 
    
    # Removing self-loops and parallel edges
    g_conf_simple <- simplify(g_conf, remove.multiple=TRUE, remove.loops=TRUE)
    
    # Calculating % of edges lost
    edges_before <- ecount(g_conf)
    edges_after <- ecount(g_conf_simple)
    percent_lost <- 100 * (edges_before - edges_after) / edges_before
    cat(sprintf("Percentage of edges lost: %.2f%%\n", percent_lost))
    
    # KS test again
    deg_g <- degree(g)
    deg_conf_simple <- degree(g_conf_simple)
    ks2 <- ks.test(deg_g, deg_conf_simple)
    print(ks2)
    
    ################################################################################
    # OptionaL
    # Plotting the result
    hist(deg_g, breaks=50, col=rgb(0,0,1,0.5), xlim=range(c(deg_g, deg_conf_simple)), 
         xlab="Degree", main="Degree Distributions (Simple)")
    hist(deg_conf_simple, breaks=50, col=rgb(1,0,0,0.5), add=TRUE)
    legend("topright", legend=c("Original", "Config Model (simple)"), 
           fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 18.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate an LFR benchmark with 100, 000 nodes, a degree expo-
    # nent α = 3.13, a community exponent of 1.1, a mixing parameter
    # µ = 0.1, average degree of 10, and minimum community size of
    # 10, 000. (Note: there’s a networkx function to do this). Can you
    # recover the α value by fitting the degree distribution?
    
    library(here)
    library(igraph)
    
    # Solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate an LFR benchmark with 100, 000 nodes, a degree expo-
    # nent α = 3.13, a community exponent of 1.1, a mixing parameter
    # µ = 0.1, average degree of 10, and minimum community size of
    # 10, 000. (Note: there’s a networkx function to do this). Can you
    # recover the α value by fitting the degree distribution?
    
    library(here)
    library(igraph)
    
    # Solution 
    
    # Generating LFR benchmark
    set.seed(123)
    g_lfr <- sample_lfr(
      n = 100000,
      tau1 = 3.13,
      tau2 = 1.1,
      mu = 0.1,
      average_degree = 10,
      min_community = 10000
    )
    
    # Estimating alpha (degree exponent)
    deg <- degree(g_lfr)
    deg_tab <- table(deg)
    deg_vals <- as.numeric(names(deg_tab))
    deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
    ccdf <- rev(cumsum(rev(deg_prob)))
    
    sel <- deg_vals > 0
    log_k <- log(deg_vals[sel])
    log_ccdf <- log(ccdf[sel])
    
    fit <- lm(log_ccdf ~ log_k)
    alpha_est <- -coef(fit)[2] + 1
    
    cat(sprintf("Recovered degree exponent (alpha): %.2f\n", alpha_est))
    
    ################################################################################
    # Optional
    # Plotting the results
    plot(deg_vals, ccdf, log="xy", xlab="Degree (k)", ylab="CCDF", pch=19, main="LFR Degree Distribution")
    abline(fit, col="red")
    legend("bottomleft", legend=paste("α =", round(alpha_est, 2)), bty="n")
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 18.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use kron function from numpy to implement a Kronecker graph
    # generator. Plot the CCDF degree distribution of a Kronecker graph
    # with the following seed matrix multiplied 4 times (setting the main
    # diagonal to zero once you’re done):
    
    #     1 1 1 0
    # A = 1 1 1 0
    #     1 1 1 1 
    #     0 0 1 1 
    
    library(here)
    library(igraph)
    
    # Defining the seed matrix
    A <- matrix(c(
      1, 1, 1, 0,
      1, 1, 1, 0,
      1, 1, 1, 1,
      0, 0, 1, 1
    ), nrow=4, byrow=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use kron function from numpy to implement a Kronecker graph
    # generator. Plot the CCDF degree distribution of a Kronecker graph
    # with the following seed matrix multiplied 4 times (setting the main
    # diagonal to zero once you’re done):
    
    #     1 1 1 0
    # A = 1 1 1 0
    #     1 1 1 1 
    #     0 0 1 1 
    
    library(here)
    library(igraph)
    
    # Defining the seed matrix
    A <- matrix(c(
      1, 1, 1, 0,
      1, 1, 1, 0,
      1, 1, 1, 1,
      0, 0, 1, 1
    ), nrow=4, byrow=TRUE)
    
    # Solution 
    
    # Kronecker multiply 4 times
    K <- A
    for (i in 1:3) {
      K <- K %x% A
    }
    
    # Setting main diagonal to zero
    diag(K) <- 0
    
    # Creating the graph
    g <- graph_from_adjacency_matrix(K, mode="undirected", diag=FALSE)
    
    ################################################################################
    # Optional 
    # Plotting the CCDF of the degree distribution
    deg <- degree(g)
    deg_tab <- table(deg)
    deg_vals <- as.numeric(names(deg_tab))
    deg_prob <- as.numeric(deg_tab) / sum(deg_tab)
    ccdf <- rev(cumsum(rev(deg_prob)))
    plot(deg_vals, ccdf, log="xy", pch=19, xlab="Degree", ylab="CCDF", main="Kronecker Graph Degree CCDF")
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 19.4.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform 1, 000 edge swaps, creating a null version of the network
    # in http://www.networkatlas.eu/exercises/19/1/data.txt. Make
    # sure you don’t create parallel edges. Calculate the Kolmogorov-
    # Smirnov distance between the two degree distributions. Can you
    # tell the difference?
    
    library(here)
    library(igraph)
    
    # Reading data and create the graph
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform 1, 000 edge swaps, creating a null version of the network
    # in http://www.networkatlas.eu/exercises/19/1/data.txt. Make
    # sure you don’t create parallel edges. Calculate the Kolmogorov-
    # Smirnov distance between the two degree distributions. Can you
    # tell the difference?
    
    library(here)
    library(igraph)
    
    # Reading data and create the graph
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution 
    
    # Performing 1,000 edge swaps (null model)
    set.seed(42)
    g_null <- rewire(g, with = keeping_degseq(niter = 1000))
    
    # Kolmogorov-Smirnov test
    deg_orig <- degree(g)
    deg_null <- degree(g_null)
    ks <- ks.test(deg_orig, deg_null)
    cat("Kolmogorov-Smirnov D-statistic:", ks$statistic, "\n")
    cat("p-value:", ks$p.value, "\n")
    
    ################################################################################
    # Optional 
    # Creating a graph
    
    hist(deg_orig, breaks=30, col=rgb(0,0,1,0.5), xlim=range(c(deg_orig, deg_null)), 
         main="Degree Distributions", xlab="Degree")
    hist(deg_null, breaks=30, col=rgb(1,0,0,0.5), add=TRUE)
    legend("topright", legend=c("Original", "Null (1000 swaps)"), 
           fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 19.4.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Do you get larger KS distances if you perform 2, 000 swaps? Do
    # you get smaller KS distances if you perform 500?
    
    library(here)
    library(igraph)
    
    # Reading data and Creating the graph
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Do you get larger KS distances if you perform 2, 000 swaps? Do
    # you get smaller KS distances if you perform 500?
    
    library(here)
    library(igraph)
    
    # Reading data and Creating the graph
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution 
    
    # Function to perform swaps and return KS statistic
    ks_for_swaps <- function(g, n_swaps) {
      set.seed(42)
      g_null <- rewire(g, with = keeping_degseq(niter = n_swaps))
      deg_orig <- degree(g)
      deg_null <- degree(g_null)
      ks <- ks.test(deg_orig, deg_null)
      return(ks$statistic)
    }
    
    ks_500 <- ks_for_swaps(g, 500)
    ks_1000 <- ks_for_swaps(g, 1000)
    ks_2000 <- ks_for_swaps(g, 2000)
    
    cat("KS statistic for 500 swaps: ", ks_500, "\n")
    cat("KS statistic for 1000 swaps:", ks_1000, "\n")
    cat("KS statistic for 2000 swaps:", ks_2000, "\n")
```

</details>

</details>

<details>
<summary>

## 19.4.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate 50 Gn,m null versions of the network in http://www.
    # networkatlas.eu/exercises/19/3/data.txt, respecting the number
    # of nodes and edges. Derive the number of standard deviations
    # between the observed values and the null average of clustering
    # and average path length. (Consider only the largest connected
    # component) Which of these two is statistically significant?
    
    library(here)
    library(igraph)
    
    # Reading the data and creating the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate 50 Gn,m null versions of the network in http://www.
    # networkatlas.eu/exercises/19/3/data.txt, respecting the number
    # of nodes and edges. Derive the number of standard deviations
    # between the observed values and the null average of clustering
    # and average path length. (Consider only the largest connected
    # component) Which of these two is statistically significant?
    
    library(here)
    library(igraph)
    
    # Reading the data and creating the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution 
    
    # Largest component
    cl <- clusters(g)
    giant <- induced_subgraph(g, which(cl$membership == which.max(cl$csize)))
    n <- vcount(giant)
    m <- ecount(giant)
    
    # Observed stats
    obs_clustering <- transitivity(giant, type="global")
    obs_path <- average.path.length(giant)
    
    # Null models
    null_clustering <- numeric(50)
    null_path <- numeric(50)
    set.seed(42)
    for (i in 1:50) {
      null_g <- erdos.renyi.game(n, m, type="gnm", directed=FALSE)
      comps <- clusters(null_g)
      largest <- induced_subgraph(null_g, which(comps$membership == which.max(comps$csize)))
      null_clustering[i] <- transitivity(largest, type="global")
      null_path[i] <- average.path.length(largest)
    }
    
    # Z-scores
    mean_clust <- mean(null_clustering)
    sd_clust <- sd(null_clustering)
    z_clust <- (obs_clustering - mean_clust) / sd_clust
    
    mean_path <- mean(null_path)
    sd_path <- sd(null_path)
    z_path <- (obs_path - mean_path) / sd_path
    
    cat(sprintf("Observed clustering: %.4f\n", obs_clustering))
    cat(sprintf("Null mean clustering: %.4f, SD: %.4f, z-score: %.2f\n", mean_clust, sd_clust, z_clust))
    cat(sprintf("Observed avg path: %.4f\n", obs_path))
    cat(sprintf("Null mean avg path: %.4f, SD: %.4f, z-score: %.2f\n", mean_path, sd_path, z_path))
    
    ################################################################################
    # Optional 
    # printing a plot of the network 
    plot(
      giant,
      vertex.size = 4,
      vertex.label = NA,
      edge.arrow.size = 0.3,
      main = "Largest Connected Component"
    )
    ################################################################################

```

</details>

</details>

<details>
<summary>

## 19.4.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Repeat the experiment in the previous question, but now generate
    # 50 Watts-Strogatz small world models, with the same number of
    # nodes as the original network and setting k = 16 and p = 0.1.
    
    library(here)
    library(igraph)
    
    # Reading the data and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Repeat the experiment in the previous question, but now generate
    # 50 Watts-Strogatz small world models, with the same number of
    # nodes as the original network and setting k = 16 and p = 0.1.
    
    library(here)
    library(igraph)
    
    # Reading the data and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    
    # Solution 
    
    # Largest component
    cl <- clusters(g)
    giant <- induced_subgraph(g, which(cl$membership == which.max(cl$csize)))
    n <- vcount(giant)
    
    # Observed stats
    obs_clustering <- transitivity(giant, type="global")
    obs_path <- average.path.length(giant)
    
    # Watts-Strogatz null models
    ws_clustering <- numeric(50)
    ws_path <- numeric(50)
    set.seed(42)
    for (i in 1:50) {
      ws_g <- sample_smallworld(dim=1, size=n, nei=8, p=0.1) # k=16 -> nei=8
      comps <- clusters(ws_g)
      largest <- induced_subgraph(ws_g, which(comps$membership == which.max(comps$csize)))
      ws_clustering[i] <- transitivity(largest, type="global")
      ws_path[i] <- average.path.length(largest)
    }
    
    # Z-scores
    mean_clust <- mean(ws_clustering)
    sd_clust <- sd(ws_clustering)
    z_clust <- (obs_clustering - mean_clust) / sd_clust
    
    mean_path <- mean(ws_path)
    sd_path <- sd(ws_path)
    z_path <- (obs_path - mean_path) / sd_path
    
    cat(sprintf("Observed clustering: %.4f\n", obs_clustering))
    cat(sprintf("WS mean clustering: %.4f, SD: %.4f, z-score: %.2f\n", mean_clust, sd_clust, z_clust))
    cat(sprintf("Observed avg path: %.4f\n", obs_path))
    cat(sprintf("WS mean avg path: %.4f, SD: %.4f, z-score: %.2f\n", mean_path, sd_path, z_path))
    
    ################################################################################
    # Optional 
    # Plotting the graph
    plot(
      giant,
      vertex.size = 4,
      vertex.label = NA,
      edge.arrow.size = 0.3,
      main = "Largest Connected Component"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 20.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement an SI model on the network at http://www.networkatlas.
    # eu/exercises/20/1/data.txt. Run it 10 times with different β values:
    # 0.05, 0.1, and 0.2. For each run (in this and all following
    # questions) pick a random node and place it in the Infected state.
    # What’s the average time step in which each of those β infects 80%
    # of the network?
    
    library(here)
    library(igraph)
    
    # Reading the data and build the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement an SI model on the network at http://www.networkatlas.
    # eu/exercises/20/1/data.txt. Run it 10 times with different β values:
    # 0.05, 0.1, and 0.2. For each run (in this and all following
    # questions) pick a random node and place it in the Infected state.
    # What’s the average time step in which each of those β infects 80%
    # of the network?
    
    library(here)
    library(igraph)
    
    # Reading the data and build the graph 
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # Solution 
    
    # SI simulation function
    SI_simulation <- function(g, beta, target_frac=0.8) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      # Random initial infected node
      patient_zero <- sample(1:N, 1)
      infected[patient_zero] <- TRUE
      t <- 0
      num_infected <- 1
      while (num_infected < target_frac * N) {
        t <- t + 1
        new_infected <- infected
        # For each infected node, infect susceptible neighbors with probability beta
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && runif(1) < beta) {
              new_infected[nbr_idx] <- TRUE
            }
          }
        }
        if (sum(new_infected) == num_infected) break # no more infections
        infected <- new_infected
        num_infected <- sum(infected)
      }
      return(t)
    }
    
    # Run simulations for each beta
    betas <- c(0.05, 0.1, 0.2)
    results <- data.frame(beta=numeric(), avg_time=numeric())
    set.seed(123)
    
    # Printing the results 
    
    for (b in betas) {
      times <- numeric(10)
      for (i in 1:10) {
        times[i] <- SI_simulation(g, b, target_frac=0.8)
      }
      avg_t <- mean(times)
      cat(sprintf("Beta = %.2f: average time to 80%% infected = %.2f (over 10 runs)\n", b, avg_t))
      results <- rbind(results, data.frame(beta=b, avg_time=avg_t))
    }
    
    print(results)
```

</details>

</details>

<details>
<summary>

## 20.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Run the same SI model on the network at http://www.networkatlas.
    # eu/exercises/20/2/data.txt as well. One of the two networks is
    # a Gn,p graph while the other has a power law degree distribution.
    # Can you tell which is which by how much the disease takes to
    # infect 80% of the network for the same starting conditions used in
    # the previous question?
    
    library(here)
    library(igraph)
    
    # Loading data and remapping the first network 
    edges1 <- read.table("data1.txt", header=FALSE)
    nodes1 <- unique(c(edges1$V1, edges1$V2))
    map1 <- setNames(seq_along(nodes1), nodes1)
    edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
    g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)
    
    # Loading data and remapping the second network 
    edges2 <- read.table("data2.txt", header=FALSE)
    nodes2 <- unique(c(edges2$V1, edges2$V2))
    map2 <- setNames(seq_along(nodes2), nodes2)
    edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
    g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Run the same SI model on the network at http://www.networkatlas.
    # eu/exercises/20/2/data.txt as well. One of the two networks is
    # a Gn,p graph while the other has a power law degree distribution.
    # Can you tell which is which by how much the disease takes to
    # infect 80% of the network for the same starting conditions used in
    # the previous question?
    
    library(here)
    library(igraph)
    
    # Loading data and remapping the first network 
    edges1 <- read.table("data1.txt", header=FALSE)
    nodes1 <- unique(c(edges1$V1, edges1$V2))
    map1 <- setNames(seq_along(nodes1), nodes1)
    edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
    g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)
    
    # Loading data and remapping the second network 
    edges2 <- read.table("data2.txt", header=FALSE)
    nodes2 <- unique(c(edges2$V1, edges2$V2))
    map2 <- setNames(seq_along(nodes2), nodes2)
    edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
    g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)
    
    # Solution 
    
    # Creating SI Model Function
    SI_simulation <- function(g, beta, target_frac=0.8) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      patient_zero <- sample(1:N, 1)
      infected[patient_zero] <- TRUE
      t <- 0
      num_infected <- 1
      while (num_infected < target_frac * N) {
        t <- t + 1
        new_infected <- infected
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && runif(1) < beta) {
              new_infected[nbr_idx] <- TRUE
            }
          }
        }
        if (sum(new_infected) == num_infected) break
        infected <- new_infected
        num_infected <- sum(infected)
      }
      return(t)
    }
    
    # Running SI Simulations on Both Networks
    set.seed(42)
    betas <- c(0.05, 0.1, 0.2)
    results1 <- data.frame(beta=betas, avg_time=NA)
    results2 <- data.frame(beta=betas, avg_time=NA)
    
    for (j in seq_along(betas)) {
      b <- betas[j]
      times1 <- times2 <- numeric(10)
      for (i in 1:10) {
        times1[i] <- SI_simulation(g1, b, target_frac=0.8)
        times2[i] <- SI_simulation(g2, b, target_frac=0.8)
      }
      results1$avg_time[j] <- mean(times1)
      results2$avg_time[j] <- mean(times2)
    }
    
    # Printing the results
    print("Network 1 (data1.txt) - avg time to 80% infected:")
    print(results1)
    print("Network 2 (data2.txt) - avg time to 80% infected:")
    print(results2)
    
    # How do you tell which network is which?
    
    
      
    # _Gn,p (Erdős–Rényi random graph):_
    
    #  More homogeneous degree distribution.
    
    #  SI infection spreads moderately fast.
    
    
    
    # _Power law (scale-free) network:_
    
    # Some nodes (hubs) have very high degree.
    
    # SI infection spreads much faster (especially for larger β), as hubs accelerate t
    # he process.
    
    
    
    # So:
    
    
    
    # The network where the disease spreads faster (lower average time to 80% 
    # infected) is the power law (scale-free) network.
    
    # The network where it takes longer is the random (Gn,p) network.

```

</details>

</details>

<details>
<summary>

## 20.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Extend your SI model to an SIS. With β = 0.2, run the model
    # with µ values of 0.05, 0.1, and 0.2 on both networks used in the
    # previous questions. Run the SIS model, with a random node as a
    # starting Infected set, for 100 steps and plot the share of nodes in
    # the Infected state. For which of these values and networks do you
    # have an endemic state? How big is the set of nodes in state I com-
    # pared to the number of nodes in the network? (Note, randomness
    # might affect your results. Run the experiment multiple times)
    
    library(here)
    library(igraph)
    
    # Loading data and remapping the first network 
    edges1 <- read.table("data1.txt", header=FALSE)
    nodes1 <- unique(c(edges1$V1, edges1$V2))
    map1 <- setNames(seq_along(nodes1), nodes1)
    edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
    g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)
    
    # Loading data and remapping the second network 
    edges2 <- read.table("data2.txt", header=FALSE)
    nodes2 <- unique(c(edges2$V1, edges2$V2))
    map2 <- setNames(seq_along(nodes2), nodes2)
    edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
    g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R


```

</details>

</details>

<details>
<summary>

## 20.5.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Extend your SI model to an SIR. With β = 0.2, run the model for
    # 400 steps with µ values of 0.01, 0.02, and 0.04 and plot the share of
    # nodes in the Removed state for both the networks used in Q1 and
    # Q2. How quickly does it converge to a full R state network?
    
    library(here)  
    library(igraph)
    
    # Loading data and remapping the first network 
    edges1 <- read.table("data1.txt", header=FALSE)
    nodes1 <- unique(c(edges1$V1, edges1$V2))
    map1 <- setNames(seq_along(nodes1), nodes1)
    edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
    g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)
    
    # Loading data and remapping the second network 
    edges2 <- read.table("data2.txt", header=FALSE)
    nodes2 <- unique(c(edges2$V1, edges2$V2))
    map2 <- setNames(seq_along(nodes2), nodes2)
    edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
    g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Extend your SI model to an SIR. With β = 0.2, run the model for
    # 400 steps with µ values of 0.01, 0.02, and 0.04 and plot the share of
    # nodes in the Removed state for both the networks used in Q1 and
    # Q2. How quickly does it converge to a full R state network?
    
    library(here)  
    library(igraph)
      
    # Loading data and remapping the first network 
    edges1 <- read.table("data1.txt", header=FALSE)
    nodes1 <- unique(c(edges1$V1, edges1$V2))
    map1 <- setNames(seq_along(nodes1), nodes1)
    edges1_mapped <- as.data.frame(lapply(edges1, function(col) map1[as.character(col)]))
    g1 <- graph_from_edgelist(as.matrix(edges1_mapped), directed=FALSE)
    
    # Loading data and remapping the second network 
    edges2 <- read.table("data2.txt", header=FALSE)
    nodes2 <- unique(c(edges2$V1, edges2$V2))
    map2 <- setNames(seq_along(nodes2), nodes2)
    edges2_mapped <- as.data.frame(lapply(edges2, function(col) map2[as.character(col)]))
    g2 <- graph_from_edgelist(as.matrix(edges2_mapped), directed=FALSE)
    
    # This should be the Solution 
    
    # Creating SIR Simulation Function
    SIR_simulation <- function(g, beta, mu, steps=400) {
      N <- vcount(g)
      # 0 = S, 1 = I, 2 = R
      state <- rep(0, N)
      state[sample(1:N, 1)] <- 1 # Start with 1 random infected
      removed_frac <- numeric(steps)
      
      for (t in 1:steps) {
        new_state <- state
        for (node in 1:N) {
          if (state[node] == 1) { # Infected
            # Try to infect susceptible neighbors
            nbrs <- neighbors(g, node)
            for (nbr in nbrs) {
              nbr_idx <- as.integer(nbr)
              if (state[nbr_idx] == 0 && runif(1) < beta) {
                new_state[nbr_idx] <- 1
              }
            }
            # Try to recover
            if (runif(1) < mu) {
              new_state[node] <- 2 # Removed
            }
          }
        }
        state <- new_state
        removed_frac[t] <- mean(state == 2)
        # Optional: Breaking if all infected are gone
        if (sum(state == 1) == 0) break
      }
      # Filling remaining with final value if ended early
      if (t < steps) removed_frac[(t+1):steps] <- removed_frac[t]
      return(removed_frac)
    }
    
    # Running and Plotting for All Parameters
    betas <- 0.2
    mus <- c(0.01, 0.02, 0.04)
    steps <- 400
    n_runs <- 10 # For averaging
    
    par(mfrow=c(2,1))
    set.seed(42)
    
    # For each network
    for (net_idx in 1:2) {
      g <- if (net_idx == 1) g1 else g2
      netname <- if (net_idx == 1) "Network 1" else "Network 2"
      
      plot(NULL, xlim=c(1, steps), ylim=c(0, 1), type="n",
           xlab="Time step", ylab="Fraction Removed",
           main=paste0(netname, ": SIR, beta=0.2"))
      
      cols <- c("blue", "red", "green")
      legend_labels <- character()
      
      for (i in seq_along(mus)) {
        mu <- mus[i]
        removed_mat <- matrix(NA, nrow=n_runs, ncol=steps)
        for (r in 1:n_runs) {
          removed_mat[r,] <- SIR_simulation(g, beta=betas, mu=mu, steps=steps)
        }
        avg_removed <- colMeans(removed_mat)
        lines(avg_removed, col=cols[i], lwd=2)
        legend_labels <- c(legend_labels, sprintf("mu=%.2f", mu))
      }
      legend("bottomright", legend=legend_labels, col=cols, lwd=2)
    }
    
    # Interpretation
    
    
    # The plot shows, for each (\mu), how quickly the network approaches the full R 
    # (Removed) state (i.e., everyone recovered).
    
    # Faster convergence = steeper/faster rise in curve.
    
    # Compare across (\mu): higher recovery ((\mu)) generally leads to fewer people 
    # infected at the same time, but the R fraction still eventually reaches 1 if the 
    # network is well connected.
    
    # Time to full R: Look for when the curve first reaches 1 (or very close).
    
    # You may find that the power-law network converges faster or slower depending 
    # on its structure (hubs accelerate infections, but may also get depleted 
    # quickly).

```

</details>

</details>

<details>
<summary>

## 21.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Modify the SI model developed in the exercises of the previous
    # chapter so that it works with a threshold trigger. Set κ = 2 and run
    # the threshold trigger on the network at http://www.networkatlas.
    # eu/exercises/21/1/data.txt. Show the curves of the size of
    # the I state for it (average over 10 runs, each run of 50 steps) and
    # compare it with a simple (no reinforcement) SI model with β =
    # 0.2.
    
    library(here)
    library(igraph)
    
    # Reading the data and remapping the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Modify the SI model developed in the exercises of the previous
    # chapter so that it works with a threshold trigger. Set κ = 2 and run
    # the threshold trigger on the network at http://www.networkatlas.
    # eu/exercises/21/1/data.txt. Show the curves of the size of
    # the I state for it (average over 10 runs, each run of 50 steps) and
    # compare it with a simple (no reinforcement) SI model with β =
    # 0.2.
    
    library(here)
    library(igraph)
    
    # Reading the data and remapping the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # This should be the Solution 
    
    # Threshold SI Model (κ = 2)
    threshold_SI <- function(g, kappa=2, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(!infected)) {
          nbrs <- neighbors(g, node)
          if (sum(infected[as.integer(nbrs)]) >= kappa) {
            new_infected[node] <- TRUE
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Classic SI Model (β = 0.2)
    classic_SI <- function(g, beta=0.2, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && runif(1) < beta) {
              new_infected[nbr_idx] <- TRUE
            }
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Running simulations and plotting results
    steps <- 50
    runs <- 10
    set.seed(42)
    
    # Threshold SI
    thr_mat <- replicate(runs, threshold_SI(g, kappa=2, steps=steps))
    thr_mean <- rowMeans(thr_mat)
    
    # Classic SI
    si_mat <- replicate(runs, classic_SI(g, beta=0.2, steps=steps))
    si_mean <- rowMeans(si_mat)
    
    # Plot
    plot(thr_mean, type="l", col="red", lwd=2, ylim=c(0,1),
         ylab="Fraction Infected (I)", xlab="Step", main="Threshold SI vs Classic SI (mean of 10 runs)")
    lines(si_mean, col="blue", lwd=2)
    legend("bottomright", legend=c("Threshold SI (κ=2)", "Classic SI (β=0.2)"),
           col=c("red", "blue"), lwd=2)
    
    # Interpretation
    
    # Threshold SI (κ = 2): Nodes only become infected if at least 2 neighbors are 
    # infected. This usually slows the spread and can sometimes prevent a full 
    # outbreak if the initial conditions or the network structure do not allow cascades.
    
    # Classic SI: Any infected neighbor can transmit, so the epidemic grows faster.
    
    
    
    # _Comparing the curves:_
    
    
    # The blue curve (classic SI) typically rises faster and reaches full infection 
    # sooner.
    
    # The red curve (threshold SI) often rises more slowly, and sometimes may not 
    # reach full infection depending on the network's connectivity.

```

</details>

</details>

<details>
<summary>

## 21.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Modify the SI model developed in the previous exercise so that
    # it works with a cascade trigger. Set β = 0.1 and compare the I
    # infection curves for the three triggers on the network used in the
    # previous exercise (average over 10 runs, each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Read and remap the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # write here the solution 

```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Modify the SI model developed in the previous exercise so that
    # it works with a cascade trigger. Set β = 0.1 and compare the I
    # infection curves for the three triggers on the network used in the
    # previous exercise (average over 10 runs, each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Read and remap the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # this should be the Solution 
    
    # Classic SI (probabilistic trigger, β)
    classic_SI <- function(g, beta=0.2, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && runif(1) < beta) {
              new_infected[nbr_idx] <- TRUE
            }
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Threshold SI (κ = 2)
    threshold_SI <- function(g, kappa=2, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(!infected)) {
          nbrs <- neighbors(g, node)
          if (sum(infected[as.integer(nbrs)]) >= kappa) {
            new_infected[node] <- TRUE
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Cascade SI (each susceptible node with at least one infected neighbor becomes 
    # infected with probability β)
    cascade_SI <- function(g, beta=0.1, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(!infected)) {
          nbrs <- neighbors(g, node)
          if (any(infected[as.integer(nbrs)])) {
            if (runif(1) < beta) {
              new_infected[node] <- TRUE
            }
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Running 10 Simulations and Averaging for Each Model
    steps <- 50
    runs <- 10
    set.seed(42)
    
    # Classic SI (β=0.2 as before)
    classic_mat <- replicate(runs, classic_SI(g, beta=0.2, steps=steps))
    classic_mean <- rowMeans(classic_mat)
    
    # Threshold SI (κ=2)
    threshold_mat <- replicate(runs, threshold_SI(g, kappa=2, steps=steps))
    threshold_mean <- rowMeans(threshold_mat)
    
    # Cascade SI (β=0.1)
    cascade_mat <- replicate(runs, cascade_SI(g, beta=0.1, steps=steps))
    cascade_mean <- rowMeans(cascade_mat)
    
    # Plotting and Comparing Infection Curves
    plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
         ylab="Fraction Infected (I)", xlab="Step", main="SI Model Comparison (mean of 10 runs)")
    lines(threshold_mean, col="red", lwd=2)
    lines(cascade_mean, col="darkgreen", lwd=2)
    legend("bottomright",
           legend=c("Classic SI (β=0.2)", "Threshold SI (κ=2)", "Cascade SI (β=0.1)"),
           col=c("blue", "red", "darkgreen"), lwd=2)
    
    # Interpretation
    
    
    # Classic SI: Any infected neighbor can transmit; spread is typically fastest.
    
    # Threshold SI: Infection requires at least κ infected neighbors; spread is 
    # typically slowest.
    
    # Cascade SI: Any susceptible node with at least one infected neighbor can become
    # infected with probability β; spread is intermediate (β-dependent).
    
    # The curves will show you which mechanism leads to faster or slower spread, and 
    # how the final epidemic size differs.
```

</details>

</details>

<details>
<summary>

## 21.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Modify the simple SI model so that nodes become resistant after
    # the second failed infection attempt. Compare the I infection curves
    # of the SI model before and after this operation on the network
    # used in the previous exercise, with β = 0.3 (average over 10 runs,
    # each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Read and remap the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Modify the simple SI model so that nodes become resistant after
    # the second failed infection attempt. Compare the I infection curves
    # of the SI model before and after this operation on the network
    # used in the previous exercise, with β = 0.3 (average over 10 runs,
    # each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Read and remap the edge list
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # This should be the Solution 
    
    # Classic SI Model
    classic_SI <- function(g, beta=0.3, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && runif(1) < beta) {
              new_infected[nbr_idx] <- TRUE
            }
          }
        }
        infected <- new_infected
        I_frac[t] <- mean(infected)
        if (all(infected)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Modified SI Model with Resistance after 2 Failed Attempts
    resist_SI <- function(g, beta=0.3, steps=50) {
      N <- vcount(g)
      infected <- rep(FALSE, N)
      resistant <- rep(FALSE, N)
      failed_attempts <- rep(0, N)
      infected[sample(1:N, 1)] <- TRUE
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_infected <- infected
        new_resistant <- resistant
        new_failed <- failed_attempts
        for (node in which(infected)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (!infected[nbr_idx] && !resistant[nbr_idx]) {
              if (runif(1) < beta) {
                new_infected[nbr_idx] <- TRUE
              } else {
                new_failed[nbr_idx] <- new_failed[nbr_idx] + 1
                if (new_failed[nbr_idx] >= 2) {
                  new_resistant[nbr_idx] <- TRUE
                }
              }
            }
          }
        }
        infected <- new_infected
        resistant <- new_resistant
        failed_attempts <- new_failed
        I_frac[t] <- mean(infected)
        if (all(infected | resistant)) break
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(I_frac[length(I_frac)], steps - length(I_frac)))
      return(I_frac)
    }
    
    # Running Simulations and Plotting Results
    steps <- 50
    runs <- 10
    set.seed(42)
    
    # Classic SI
    classic_mat <- replicate(runs, classic_SI(g, beta=0.3, steps=steps))
    classic_mean <- rowMeans(classic_mat)
    
    # Modified SI with resistance
    resist_mat <- replicate(runs, resist_SI(g, beta=0.3, steps=steps))
    resist_mean <- rowMeans(resist_mat)
    
    # Plotting
    plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
         ylab="Fraction Infected (I)", xlab="Step",
         main="SI vs SI with Resistance after 2 Failed Attempts (mean of 10 runs)")
    lines(resist_mean, col="red", lwd=2)
    legend("bottomright", legend=c("Classic SI", "Resistant after 2 fails"),
           col=c("blue", "red"), lwd=2)
    
    # Interpretation
    
    
    # The classic SI curve (blue) will typically rise quickly and reach 1 
    # (full infection).
    
    # The resistance SI curve (red) will generally rise more slowly and may plateau 
    # below 1, as some nodes become resistant and never get infected.

```

</details>

</details>

<details>
<summary>

## 21.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Run a classical SIR model on the network used in the previous
    # exercise, but set the recovery probability µ = 0. At each timestep,
    # before the infection phase pick a random node. Pick one random
    # neighbor in status S, if it has one, and transition it to the R state.
    # Compare the I infection curves with and without immunization,
    # with β = 0.1 (average over 10 runs, each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Reading the network
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Run a classical SIR model on the network used in the previous
    # exercise, but set the recovery probability µ = 0. At each timestep,
    # before the infection phase pick a random node. Pick one random
    # neighbor in status S, if it has one, and transition it to the R state.
    # Compare the I infection curves with and without immunization,
    # with β = 0.1 (average over 10 runs, each run of 50 steps).
    
    library(here)
    library(igraph)
    
    # Reading the network
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_map <- setNames(seq_along(nodes), nodes)
    edges_mapped <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g <- graph_from_edgelist(as.matrix(edges_mapped), directed=FALSE)
    N <- vcount(g)
    
    # This should be the solution 
    
    # Classic SIR Model (µ = 0, only infection, no recovery)
    classic_SIR <- function(g, beta=0.1, steps=50) {
      N <- vcount(g)
      state <- rep(0, N) # 0 = S, 1 = I, 2 = R
      state[sample(1:N, 1)] <- 1 # Random initial infected
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        new_state <- state
        for (node in which(state == 1)) { # For each infected node
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (state[nbr_idx] == 0 && runif(1) < beta) {
              new_state[nbr_idx] <- 1
            }
          }
        }
        state <- new_state
        I_frac[t] <- mean(state == 1)
        if (all(state != 1)) break # No more infected
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(0, steps - length(I_frac)))
      return(I_frac)
    }
    
    # SIR Model With Immunization
    SIR_immunization <- function(g, beta=0.1, steps=50) {
      N <- vcount(g)
      state <- rep(0, N) # 0 = S, 1 = I, 2 = R
      state[sample(1:N, 1)] <- 1 # Random initial infected
      I_frac <- numeric(steps)
      for (t in 1:steps) {
        # Immunization phase: pick random node, immunize 1 susceptible neighbor if possible
        chosen <- sample(1:N, 1)
        nbrs <- neighbors(g, chosen)
        s_nbrs <- nbrs[state[as.integer(nbrs)] == 0]
        if (length(s_nbrs) > 0) {
          to_immunize <- sample(s_nbrs, 1)
          state[as.integer(to_immunize)] <- 2
        }
        # Infection phase
        new_state <- state
        for (node in which(state == 1)) {
          nbrs <- neighbors(g, node)
          for (nbr in nbrs) {
            nbr_idx <- as.integer(nbr)
            if (state[nbr_idx] == 0 && runif(1) < beta) {
              new_state[nbr_idx] <- 1
            }
          }
        }
        state <- new_state
        I_frac[t] <- mean(state == 1)
        if (all(state != 1)) break # No more infected
      }
      if (length(I_frac) < steps) I_frac <- c(I_frac, rep(0, steps - length(I_frac)))
      return(I_frac)
    }
    
    # Running Simulations and Plotting Results
    steps <- 50
    runs <- 10
    set.seed(42)
    
    # Classic SIR
    classic_mat <- replicate(runs, classic_SIR(g, beta=0.1, steps=steps))
    classic_mean <- rowMeans(classic_mat)
    
    # SIR with Immunization
    immun_mat <- replicate(runs, SIR_immunization(g, beta=0.1, steps=steps))
    immun_mean <- rowMeans(immun_mat)
    
    # Plot
    plot(classic_mean, type="l", col="blue", lwd=2, ylim=c(0,1),
         ylab="Fraction Infected (I)", xlab="Step",
         main="SIR Model: With vs Without Immunization (mean of 10 runs)")
    lines(immun_mean, col="red", lwd=2)
    legend("topright", legend=c("Classic SIR", "SIR with Immunization"),
           col=c("blue", "red"), lwd=2)
    
    # Interpretation
    
    # The red curve (SIR with immunization) should show a noticeably slower and/or 
    # smaller epidemic than the blue curve (classic SIR).
    
    # Immunization before the infection phase reduces the number of susceptible 
    # nodes, thereby limiting the spread.
    

```

</details>

</details>

<details>
<summary>

## 22.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Plot the number of nodes in the largest connected component
    # as you remove 2, 000 random nodes, one at a time, from the net-
    # work at http://www.networkatlas.eu/exercises/22/1/data.txt.
    # (Repeat 10 times and plot the average result)
    
    library(here)
    library(igraph)
    
    # Loading and remapping the network, assigning unique character names to vertices
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_names <- as.character(nodes)
    node_map <- setNames(node_names, nodes)
    edges_named <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g_full <- graph_from_edgelist(as.matrix(edges_named), directed=FALSE)
    V(g_full)$name <- as.character(V(g_full)$name) # Ensuring names are character
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Plot the number of nodes in the largest connected component
    # as you remove 2, 000 random nodes, one at a time, from the net-
    # work at http://www.networkatlas.eu/exercises/22/1/data.txt.
    # (Repeat 10 times and plot the average result)
    
    library(here)
    library(igraph)
    
    # Loading and remapping the network, assigning unique character names to vertices
    edges <- read.table("data.txt", header=FALSE)
    nodes <- unique(c(edges$V1, edges$V2))
    node_names <- as.character(nodes)
    node_map <- setNames(node_names, nodes)
    edges_named <- as.data.frame(lapply(edges, function(col) node_map[as.character(col)]))
    g_full <- graph_from_edgelist(as.matrix(edges_named), directed=FALSE)
    V(g_full)$name <- as.character(V(g_full)$name) # Ensuring names are character
    
    # Solution 
    
    steps <- 2000
    runs <- 10
    set.seed(42)
    largest_cc_mat <- matrix(NA, nrow=steps+1, ncol=runs)
    
    for (r in 1:runs) {
      g <- g_full
      remaining_names <- V(g)$name
      largest_cc <- numeric(steps+1)
      largest_cc[1] <- max(components(g)$csize)
      remove_order <- sample(remaining_names, steps)
      for (i in 1:steps) {
        if (remove_order[i] %in% V(g)$name) {
          g <- delete_vertices(g, remove_order[i])
        }
        if (vcount(g) > 0) {
          largest_cc[i+1] <- max(components(g)$csize)
        } else {
          largest_cc[(i+1):(steps+1)] <- 0
          break
        }
      }
      largest_cc_mat[,r] <- largest_cc
    }
    
    # Averaging over runs
    mean_largest_cc <- rowMeans(largest_cc_mat)
    
    # Plotting
    plot(0:steps, mean_largest_cc, type="l", lwd=2,
         xlab="Number of nodes removed",
         ylab="Size of largest connected component (average over 10 runs)",
         main="Random Node Removal: Largest Connected Component")
```

</details>

</details>

<details>
<summary>

## 22.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform the same operation as the one from the previous exercise,
    # but for the network at http://www.networkatlas.eu/exercises/
    # 22/2/data.txt. Can you tell which is the network with a power
    # law degree distribution and which is the Gn,p network?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edge_list <- read.table("data.txt", header=FALSE)
    colnames(edge_list) <- c("from", "to")
    
    edge_list[] <- lapply(edge_list, as.character)
    
    g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform the same operation as the one from the previous exercise,
    # but for the network at http://www.networkatlas.eu/exercises/
    # 22/2/data.txt. Can you tell which is the network with a power
    # law degree distribution and which is the Gn,p network?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edge_list <- read.table("data.txt", header=FALSE)
    colnames(edge_list) <- c("from", "to")
    
    edge_list[] <- lapply(edge_list, as.character)
    
    g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)
    
    # Solution 
    
    num_remove <- 2000
    num_runs <- 10
    lcc_sizes <- matrix(NA, nrow = num_remove, ncol = num_runs)
    
    set.seed(42)
    for(run in 1:num_runs) {
      g_temp <- g
      nodes <- V(g_temp)$name
      nodes_to_remove <- sample(nodes, num_remove)
      for(i in 1:num_remove) {
        g_temp <- delete_vertices(g_temp, nodes_to_remove[i])
        cl <- components(g_temp)
        lcc_sizes[i, run] <- if (vcount(g_temp) > 0) max(cl$csize) else 0
      }
    }
    
    avg_lcc <- rowMeans(lcc_sizes)
    
    # Plotting the results
    plot(1:num_remove, avg_lcc, type = "l",
         xlab = "Number of nodes removed",
         ylab = "Size of largest connected component",
         main = "Network Robustness: Random Node Removal")
```

</details>

</details>

<details>
<summary>

## 22.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Plot the number of nodes in the largest connected component
    # as you remove 2, 000 nodes, one at a time, in descending degree
    # order, from the networks used for the previous exercises. Does the
    # result confirm your answer to the previous question about which
    # network is of which type?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edge_list <- read.table("data.txt", header=FALSE)
    colnames(edge_list) <- c("from", "to")
    edge_list[] <- lapply(edge_list, as.character)
    g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Plot the number of nodes in the largest connected component
    # as you remove 2, 000 nodes, one at a time, in descending degree
    # order, from the networks used for the previous exercises. Does the
    # result confirm your answer to the previous question about which
    # network is of which type?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edge_list <- read.table("data.txt", header=FALSE)
    colnames(edge_list) <- c("from", "to")
    edge_list[] <- lapply(edge_list, as.character)
    g <- graph_from_edgelist(as.matrix(edge_list), directed = FALSE)
    
    # Solution 
    
    num_remove <- 2000
    lcc_sizes <- numeric(num_remove)
    
    g_temp <- g
    for (i in 1:num_remove) {
      if (vcount(g_temp) == 0) {
        lcc_sizes[i:num_remove] <- 0
        break
      }
      degs <- degree(g_temp)
      # Picking the node(s) with the highest degree (randomly if tie)
      max_deg <- max(degs)
      candidates <- names(degs)[degs == max_deg]
      to_remove <- sample(candidates, 1)
      g_temp <- delete_vertices(g_temp, to_remove)
      cl <- components(g_temp)
      lcc_sizes[i] <- if (vcount(g_temp) > 0) max(cl$csize) else 0
    }
    
    # Plotting the results 
    plot(1:num_remove, lcc_sizes, type = "l",
         xlab = "Number of nodes removed (highest degree first)",
         ylab = "Size of largest connected component",
         main = paste("Targeted Attack: Largest Component vs. Nodes Removed\n", filename))
```

</details>

</details>

<details>
<summary>

## 22.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/22/4/
    # data.txt has nodes metadata at http://www.networkatlas.eu/
    # exercises/22/4/node_metadata.txt, telling you the current load
    # and the maximum load. If the current load exceeds the maximum
    # load, the node will shut down and equally distribute all of its
    # current load to its neighbors. Some nodes have a current load
    # higher than their maximum load. Run the cascade failure and
    # report how many nodes are left standing once the cascade finishes.
    
    library(here)
    library(igraph)
    
    # Loading the network
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Loading metadata
    meta <- read.delim("node_metadata.txt", header=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
    # Cleaning up column names: remove leading/trailing spaces, replace multiple spaces/tabs with "_"
    colnames(meta) <- gsub("[ \t]+", "_", trimws(colnames(meta)))
    
    meta$node <- as.character(meta$node)
    
    # Get the correct column names for current and max load
    current_col <- grep("^current.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)
    max_col <- grep("^max.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)
    
    current_load <- setNames(meta[[current_col]], meta$node)
    max_load <- setNames(meta[[max_col]], meta$node)
    standing <- setNames(rep(TRUE, length(current_load)), names(current_load))
    
    # Solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/22/4/
    # data.txt has nodes metadata at http://www.networkatlas.eu/
    # exercises/22/4/node_metadata.txt, telling you the current load
    # and the maximum load. If the current load exceeds the maximum
    # load, the node will shut down and equally distribute all of its
    # current load to its neighbors. Some nodes have a current load
    # higher than their maximum load. Run the cascade failure and
    # report how many nodes are left standing once the cascade finishes.
    
    library(here)
    library(igraph)
    
    # Loading the network
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Loading metadata
    meta <- read.delim("node_metadata.txt", header=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
    # Cleaning up column names: remove leading/trailing spaces, replace multiple spaces/tabs with "_"
    colnames(meta) <- gsub("[ \t]+", "_", trimws(colnames(meta)))
    
    meta$node <- as.character(meta$node)
    
    # Get the correct column names for current and max load
    current_col <- grep("^current.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)
    max_col <- grep("^max.*load$", colnames(meta), ignore.case=TRUE, value=TRUE)
    
    current_load <- setNames(meta[[current_col]], meta$node)
    max_load <- setNames(meta[[max_col]], meta$node)
    standing <- setNames(rep(TRUE, length(current_load)), names(current_load))
    
    # Solution 
    
    repeat {
      overloaded <- names(current_load)[standing & (current_load > max_load)]
      if(length(overloaded) == 0) break
      
      for(node in overloaded) {
        neighbors_vec <- neighbors(g, node)
        # Only distribute to standing neighbors
        neighbors_ids <- names(current_load)[neighbors_vec %in% which(standing)]
        n_neighbors <- length(neighbors_ids)
        if(n_neighbors > 0) {
          load_to_give <- current_load[node]
          current_load[neighbors_ids] <- current_load[neighbors_ids] + load_to_give / n_neighbors
        }
        current_load[node] <- 0
        standing[node] <- FALSE
      }
    }
    
    # Printing results
    n_standing <- sum(standing)
    cat("Number of nodes left standing after cascade:", n_standing, "\n")
```

</details>

</details>

<details>
<summary>

## 23.9.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What are the ten most likely edges to appear in the network at
    # http://www.networkatlas.eu/exercises/23/1/data.txt accord-
    # ing to the preferential attachment index?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What are the ten most likely edges to appear in the network at
    # http://www.networkatlas.eu/exercises/23/1/data.txt accord-
    # ing to the preferential attachment index?
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Solution 
    
    # Getting all node pairs NOT currently connected (potential edges)
    all_nodes <- V(g)$name
    missing_edges <- t(combn(all_nodes, 2))
    missing_edges <- missing_edges[!apply(missing_edges, 1, function(pair) {
      are.connected(g, pair[1], pair[2])
    }), , drop=FALSE]
    
    # Computing preferential attachment for each missing edge
    deg <- degree(g)
    pa_scores <- apply(missing_edges, 1, function(pair) {
      deg[pair[1]] * deg[pair[2]]
    })
    
    # Finding the top 10 by score
    top_idx <- order(pa_scores, decreasing=TRUE)[1:10]
    top_edges <- missing_edges[top_idx, , drop=FALSE]
    top_scores <- pa_scores[top_idx]
    
    # Printing the results
    cat("Top 10 most likely edges (by preferential attachment):\n")
    for(i in 1:nrow(top_edges)) {
      cat(sprintf("%s -- %s (score = %d)\n", top_edges[i,1], top_edges[i,2], top_scores[i]))
    }
```

</details>

</details>

<details>
<summary>

## 23.9.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the top ten edges predicted for the previous question
    # with the ones predicted by the jaccard, Adamic-Adar, and resource
    # allocation indexes.
    
    library(here)
    library(igraph)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading edge list
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the top ten edges predicted for the previous question
    # with the ones predicted by the jaccard, Adamic-Adar, and resource
    # allocation indexes.
    
    library(here)
    library(igraph)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading edge list
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Solution 
    
    # All possible node pairs not in the graph
    all_nodes <- V(g)$name
    all_pairs <- t(combn(all_nodes, 2))
    non_edges <- all_pairs[!apply(all_pairs, 1, function(pair) are.connected(g, pair[1], pair[2])), , drop=FALSE]
    
    # Preferential Attachment
    deg <- degree(g)
    pa_scores <- apply(non_edges, 1, function(pair) deg[pair[1]] * deg[pair[2]])
    
    # Jaccard
    jaccard_scores <- apply(non_edges, 1, function(pair) {
      jaccard_similarity(g, pair[1], pair[2])
    })
    
    # Adamic-Adar
    adamic_adar_scores <- apply(non_edges, 1, function(pair) {
      adamic_adar_similarity(g, pair[1], pair[2])
    })
    
    # Resource Allocation
    ra_scores <- apply(non_edges, 1, function(pair) {
      resource_allocation_index(g, pair[1], pair[2])
    })
    
    get_top10 <- function(pairs, scores) {
      idx <- order(scores, decreasing=TRUE)[1:10]
      data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx])
    }
    
    top10_pa <- get_top10(non_edges, pa_scores)
    top10_jaccard <- get_top10(non_edges, jaccard_scores)
    top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores)
    top10_ra <- get_top10(non_edges, ra_scores)
    
    cat("Top 10 Preferential Attachment:\n"); print(top10_pa)
    cat("\nTop 10 Jaccard:\n"); print(top10_jaccard)
    cat("\nTop 10 Adamic-Adar:\n"); print(top10_adamic_adar)
    cat("\nTop 10 Resource Allocation:\n"); print(top10_ra)
    
    ################### Optional: seeing overlap ###################################
    
    cat("\nOverlap (node1, node2) between indices:\n")
    cat(sprintf("PA & Jaccard: %d\n", nrow(merge(top10_pa, top10_jaccard, by=c("node1","node2")))))
    cat(sprintf("PA & Adamic-Adar: %d\n", nrow(merge(top10_pa, top10_adamic_adar, by=c("node1","node2")))))
    cat(sprintf("PA & RA: %d\n", nrow(merge(top10_pa, top10_ra, by=c("node1","node2")))))
    cat(sprintf("Jaccard & Adamic-Adar: %d\n", nrow(merge(top10_jaccard, top10_adamic_adar, by=c("node1","node2")))))
    cat(sprintf("Jaccard & RA: %d\n", nrow(merge(top10_jaccard, top10_ra, by=c("node1","node2")))))
    cat(sprintf("Adamic-Adar & RA: %d\n", nrow(merge(top10_adamic_adar, top10_ra, by=c("node1","node2")))))
```

</details>

</details>

<details>
<summary>

## 23.9.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the mutual information function from scikit-learn to im-
    # plement a mutual information link predictor. Compare it with the
    # results from the previous questions.
    
    library(here)
    library(igraph)
    library(infotheo)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the edge list and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the mutual information function from scikit-learn to im-
    # plement a mutual information link predictor. Compare it with the
    # results from the previous questions.
    
    library(here)
    library(igraph)
    library(infotheo)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the edge list and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    # Solution 
    
    # Non-edges (potential links)
    all_nodes <- V(g)$name
    all_pairs <- t(combn(all_nodes, 2))
    non_edges <- all_pairs[!apply(all_pairs, 1, function(pair) are.connected(g, pair[1], pair[2])), , drop=FALSE]
    
    # Preferential Attachment
    deg <- degree(g)
    pa_scores <- apply(non_edges, 1, function(pair) deg[pair[1]] * deg[pair[2]])
    
    # Jaccard
    jaccard_scores <- apply(non_edges, 1, function(pair) {
      jaccard_similarity(g, pair[1], pair[2])
    })
    
    # Adamic-Adar
    adamic_adar_scores <- apply(non_edges, 1, function(pair) {
      adamic_adar_similarity(g, pair[1], pair[2])
    })
    
    # Resource Allocation
    ra_scores <- apply(non_edges, 1, function(pair) {
      resource_allocation_index(g, pair[1], pair[2])
    })
    
    # Mutual Information
    A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
    mi_scores <- apply(non_edges, 1, function(pair) {
      v1 <- pair[1]
      v2 <- pair[2]
      idx1 <- which(all_nodes == v1)
      idx2 <- which(all_nodes == v2)
      # Removing self and each other from vectors
      vec1 <- A[idx1, -c(idx1, idx2)]
      vec2 <- A[idx2, -c(idx1, idx2)]
      mutinformation(factor(vec1), factor(vec2))
    })
    
    # Getting Top 10 for each method
    get_top10 <- function(pairs, scores) {
      idx <- order(scores, decreasing=TRUE)[1:10]
      data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx], stringsAsFactors=FALSE)
    }
    top10_pa <- get_top10(non_edges, pa_scores)
    top10_jaccard <- get_top10(non_edges, jaccard_scores)
    top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores)
    top10_ra <- get_top10(non_edges, ra_scores)
    top10_mi <- get_top10(non_edges, mi_scores)
    
    # Printing Top 10 Mutual Information
    cat("Top 10 Mutual Information edges:\n")
    print(top10_mi)
    
    # Comparison: overlap and edge pairs
    compare_top10 <- function(df1, df2, name1, name2) {
      m <- merge(df1, df2, by=c("node1","node2"))
      cat(sprintf("\nOverlap between %s and %s: %d edges\n", name1, name2, nrow(m)))
      if (nrow(m) > 0) print(m[,c("node1","node2")])
    }
    
    compare_top10(top10_mi, top10_pa, "Mutual Information", "Preferential Attachment")
    compare_top10(top10_mi, top10_jaccard, "Mutual Information", "Jaccard")
    compare_top10(top10_mi, top10_adamic_adar, "Mutual Information", "Adamic-Adar")
    compare_top10(top10_mi, top10_ra, "Mutual Information", "Resource Allocation")
```

</details>

</details>

<details>
<summary>

## 23.9.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use your code to calculate the hitting time (from exercise 3 of
    # Chapter 11) to implement a hit time link predictor – use the com-
    # mute time since the network is undirected. Compare it with the
    # results from the previous questions.
    
    library(here)
    library(igraph)
    library(infotheo)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g)$name
    n <- length(all_nodes)
    A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use your code to calculate the hitting time (from exercise 3 of
    # Chapter 11) to implement a hit time link predictor – use the com-
    # mute time since the network is undirected. Compare it with the
    # results from the previous questions.
    
    library(here)
    library(igraph)
    library(infotheo)
    
    ########################### Helper functions ###################################
    jaccard_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) 0 else intersect_len / union_len
    }
    
    adamic_adar_similarity <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(graph, comm)))
    }
    
    resource_allocation_index <- function(graph, v1, v2) {
      n1 <- neighbors(graph, v1)
      n2 <- neighbors(graph, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(graph, comm))
    }
    
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph 
    edges <- read.table("data.txt", header=FALSE)
    edges[] <- lapply(edges, as.character)
    g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g)$name
    n <- length(all_nodes)
    A <- as.matrix(as_adjacency_matrix(g, sparse=FALSE))
    
    # Solution 
    
    # Computing hitting time and commute time matrices via Laplacian pseudoinverse
    D <- diag(rowSums(A))
    L <- D - A
    
    # Computing Moore-Penrose pseudoinverse with eigen-decomposition (L is symmetric, positive semi-definite)
    eig <- eigen(L)
    # Setting a threshold for zero eigenvalues
    tol <- 1e-10
    inv_eigvals <- ifelse(abs(eig$values) < tol, 0, 1 / eig$values)
    Lplus <- eig$vectors %*% diag(inv_eigvals) %*% t(eig$vectors)
    
    # The commute time between nodes i and j is: C_ij = vol(G) * (L+_ii + L+_jj - 2*L+_ij)
    volG <- sum(A)
    commute_time_mat <- matrix(NA, n, n)
    for(i in 1:n) {
      for(j in 1:n) {
        commute_time_mat[i, j] <- volG * (Lplus[i,i] + Lplus[j,j] - 2 * Lplus[i,j])
      }
    }
    rownames(commute_time_mat) <- all_nodes
    colnames(commute_time_mat) <- all_nodes
    
    # Finding all potential links (non-edges)
    all_pairs <- t(combn(all_nodes, 2))
    non_edges <- all_pairs[!apply(all_pairs, 1, function(pair) are.connected(g, pair[1], pair[2])), , drop=FALSE]
    
    # Commuting time predictor: lower = more likely
    commute_times <- apply(non_edges, 1, function(pair) {
      commute_time_mat[pair[1], pair[2]]
    })
    
    get_top10 <- function(pairs, scores, decreasing=TRUE) {
      idx <- order(scores, decreasing=decreasing)[1:10]
      data.frame(node1=pairs[idx,1], node2=pairs[idx,2], score=scores[idx], stringsAsFactors=FALSE)
    }
    
    top10_commute <- get_top10(non_edges, commute_times, decreasing=FALSE) # Lower is better
    
    # Other predictors for comparison
    deg <- degree(g)
    pa_scores <- apply(non_edges, 1, function(pair) deg[pair[1]] * deg[pair[2]])
    top10_pa <- get_top10(non_edges, pa_scores, decreasing=TRUE)
    
    jaccard_scores <- apply(non_edges, 1, function(pair) jaccard_similarity(g, pair[1], pair[2]))
    top10_jaccard <- get_top10(non_edges, jaccard_scores, decreasing=TRUE)
    
    adamic_adar_scores <- apply(non_edges, 1, function(pair) adamic_adar_similarity(g, pair[1], pair[2]))
    top10_adamic_adar <- get_top10(non_edges, adamic_adar_scores, decreasing=TRUE)
    
    ra_scores <- apply(non_edges, 1, function(pair) resource_allocation_index(g, pair[1], pair[2]))
    top10_ra <- get_top10(non_edges, ra_scores, decreasing=TRUE)
    
    # Mutual Information
    mi_scores <- apply(non_edges, 1, function(pair) {
      v1 <- pair[1]
      v2 <- pair[2]
      idx1 <- which(all_nodes == v1)
      idx2 <- which(all_nodes == v2)
      # Removing self and each other from vectors
      vec1 <- A[idx1, -c(idx1, idx2)]
      vec2 <- A[idx2, -c(idx1, idx2)]
      mutinformation(factor(vec1), factor(vec2))
    })
    top10_mi <- get_top10(non_edges, mi_scores, decreasing=TRUE)
    
    # Printing Top 10 for all predictors
    cat("Top 10 Commute Time (lowest values):\n"); print(top10_commute)
    cat("\nTop 10 Preferential Attachment:\n"); print(top10_pa)
    cat("\nTop 10 Jaccard:\n"); print(top10_jaccard)
    cat("\nTop 10 Adamic-Adar:\n"); print(top10_adamic_adar)
    cat("\nTop 10 Resource Allocation:\n"); print(top10_ra)
    cat("\nTop 10 Mutual Information:\n"); print(top10_mi)
    
    # Overlap comparison
    compare_top10 <- function(df1, df2, name1, name2) {
      m <- merge(df1, df2, by=c("node1","node2"))
      cat(sprintf("\nOverlap between %s and %s: %d edges\n", name1, name2, nrow(m)))
      if (nrow(m) > 0) print(m[,c("node1","node2")])
    }
    
    cat("\n--- Overlaps with Commute Time (Hitting Time) ---\n")
    compare_top10(top10_commute, top10_pa, "Commute Time", "Preferential Attachment")
    compare_top10(top10_commute, top10_jaccard, "Commute Time", "Jaccard")
    compare_top10(top10_commute, top10_adamic_adar, "Commute Time", "Adamic-Adar")
    compare_top10(top10_commute, top10_ra, "Commute Time", "Resource Allocation")
    compare_top10(top10_commute, top10_mi, "Commute Time", "Mutual Information")
```

</details>

</details>

<details>
<summary>

## 24.4.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # You’re given the undirected signed network at http://www.
    # networkatlas.eu/exercises/24/1/data.txt. Count the number of
    # triangles of the four possible types.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to", "sign")
    edges[] <- lapply(edges, as.character)
    edges$sign <- as.numeric(edges$sign)
    
    # Building an undirected network, keeping edge signs as attribute
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # You’re given the undirected signed network at http://www.
    # networkatlas.eu/exercises/24/1/data.txt. Count the number of
    # triangles of the four possible types.
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to", "sign")
    edges[] <- lapply(edges, as.character)
    edges$sign <- as.numeric(edges$sign)
    
    # Building an undirected network, keeping edge signs as attribute
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Enumerating all triangles
    triangles_raw <- combn(V(g)$name, 3)
    triangle_types <- c('+++', '++-', '+--', '---')
    triangle_counts <- setNames(rep(0, 4), triangle_types)
    
    # For each triangle, checking the signs
    for(i in 1:ncol(triangles_raw)) {
      v <- triangles_raw[,i]
      # Get all three edge signs using .from() and .to()
      s1 <- E(g)[.from(v[1]) & .to(v[2])]$sign
      s2 <- E(g)[.from(v[1]) & .to(v[3])]$sign
      s3 <- E(g)[.from(v[2]) & .to(v[3])]$sign
      # Only count if all three edges exist
      if(length(s1) == 1 && length(s2) == 1 && length(s3) == 1) {
        signs <- c(s1, s2, s3)
        npos <- sum(signs == 1)
        nneg <- sum(signs == -1)
        if(npos == 3) triangle_counts['+++'] <- triangle_counts['+++'] + 1
        if(npos == 2 && nneg == 1) triangle_counts['++-'] <- triangle_counts['++-'] + 1
        if(npos == 1 && nneg == 2) triangle_counts['+--'] <- triangle_counts['+--'] + 1
        if(nneg == 3) triangle_counts['---'] <- triangle_counts['---'] + 1
      }
    }
    
    # Printing the results 
    cat("Triangle type counts:\n")
    for(type in triangle_types) {
      cat(type, ":", triangle_counts[type], "\n")
    }
```

</details>

</details>

<details>
<summary>

## 24.4.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

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
```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
```

</details>

</details>

<details>
<summary>

## 24.4.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Consider the multilayer network at at http://www.networkatlas.
    # eu/exercises/24/3/data.txt. Calculate the Pearson correlation
    # between layers (each layer is a vector with an entry per edge. The
    # entry is 1 if the edge is present in the layer, 0 otherwise). What
    # does this tell you about multilayer link prediction? Should you
    # assume layers are independent and therefore apply a single layer
    # link prediction to each layer?
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "layer")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Consider the multilayer network at at http://www.networkatlas.
    # eu/exercises/24/3/data.txt. Calculate the Pearson correlation
    # between layers (each layer is a vector with an entry per edge. The
    # entry is 1 if the edge is present in the layer, 0 otherwise). What
    # does this tell you about multilayer link prediction? Should you
    # assume layers are independent and therefore apply a single layer
    # link prediction to each layer?
    
    library(here)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "layer")
    
    # Solution 
    
    # Getting unique layers and all unique node pairs
    layers <- unique(edges$layer)
    all_edges <- unique(rbind(
      edges[c("from", "to")],
      edges[c("to", "from")]
    ))
    
    # Creating a sorted list of all unique undirected edges for vectorization
    all_edges_sorted <- t(apply(all_edges, 1, function(row) sort(as.character(row))))
    all_edges_df <- unique(data.frame(from=all_edges_sorted[,1], to=all_edges_sorted[,2], stringsAsFactors=FALSE))
    
    # Building a binary presence matrix: rows = all edges, columns = layers
    edge_layer_mat <- matrix(0, nrow=nrow(all_edges_df), ncol=length(layers))
    colnames(edge_layer_mat) <- as.character(layers)
    
    for (i in seq_along(layers)) {
      layer_edges <- edges[edges$layer == layers[i], c("from", "to")]
      # Make sure to treat undirected edges as equivalent
      layer_edges_sorted <- t(apply(layer_edges, 1, function(row) sort(as.character(row))))
      layer_edges_df <- data.frame(from=layer_edges_sorted[,1], to=layer_edges_sorted[,2], stringsAsFactors=FALSE)
      matches <- apply(all_edges_df, 1, function(edge) {
        any(apply(layer_edges_df, 1, function(le) all(le == edge)))
      })
      edge_layer_mat[,i] <- as.integer(matches)
    }
    
    # Computing Pearson correlation for each pair of layers
    layer_corr <- cor(edge_layer_mat, method="pearson")
    
    # Printing results
    cat("Pearson correlation matrix between layers:\n")
    print(round(layer_corr, 3))
    
    # Interpreting
    mean_corr <- mean(layer_corr[lower.tri(layer_corr)])
    cat(sprintf("\nMean off-diagonal correlation: %.3f\n", mean_corr))
    if (mean_corr > 0.7) {
      cat("Conclusion: Layers are highly correlated, so they are not independent. Multilayer link prediction should consider dependencies.\n")
    } else if (mean_corr < 0.3) {
      cat("Conclusion: Layers are weakly correlated and can be considered nearly independent. You may use single-layer predictors for each layer.\n")
    } else {
      cat("Conclusion: Layers have moderate correlation; use caution and consider dependencies in prediction.\n")
    }
```

</details>

</details>

<details>
<summary>

## 25.4.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Divide the network at http://www.networkatlas.eu/exercises/
    # 25/1/data.txt into train and test sets using a ten-fold cross vali-
    # dation scheme. Draw its confusion matrix after applying a jaccard
    # link prediction to it. Use 0.5 as you cutoff score: scores equal to or
    # higher than 0.5 are predicted to be an edge, anything lower is pre-
    # dicted to be a non-edge. (Hint: make heavy use of scikit-learn
    # capabilities of performing KFold divisions and building confusion
    # matrices)
    
    library(here)
    library(igraph)
    library(caret)
    library(yardstick)
    
    ########################### Helper functions ###################################
    
    # Function to compute Jaccard index for a pair in a given graph
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    ####################### End Helper functions ###################################
    
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Divide the network at http://www.networkatlas.eu/exercises/
    # 25/1/data.txt into train and test sets using a ten-fold cross vali-
    # dation scheme. Draw its confusion matrix after applying a jaccard
    # link prediction to it. Use 0.5 as you cutoff score: scores equal to or
    # higher than 0.5 are predicted to be an edge, anything lower is pre-
    # dicted to be a non-edge. (Hint: make heavy use of scikit-learn
    # capabilities of performing KFold divisions and building confusion
    # matrices)
    
    library(here)
    library(igraph)
    library(caret)
    library(yardstick)
    
    ########################### Helper functions ###################################
    
    # Function to compute Jaccard index for a pair in a given graph
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    ####################### End Helper functions ###################################
    
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Solution 
    
    # Generating all possible node pairs
    all_pairs <- t(combn(all_nodes, 2))
    all_edges_df <- data.frame(from=all_pairs[,1], to=all_pairs[,2], stringsAsFactors=FALSE)
    
    # Marking which pairs are actual edges
    all_edges_df$edge <- mapply(function(f, t) {
      are.connected(g_full, f, t)
    }, all_edges_df$from, all_edges_df$to)
    
    # Getting positive (edges) and negative (non-edges) samples
    pos_edges <- all_edges_df[all_edges_df$edge, c("from", "to")]
    neg_edges <- all_edges_df[!all_edges_df$edge, c("from", "to")]
    
    # For cross-validation, combine positives and sample negatives to match number 
    # of positives (for balanced evaluation)
    set.seed(42)
    neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
    data_cv <- rbind(
      data.frame(pos_edges, label=1),
      data.frame(neg_edges, label=0)
    )
    data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle
    
    # 10-fold cross-validation
    folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)
    
    # Running cross-validation and collect predictions
    true_labels <- c()
    pred_labels <- c()
    
    for(i in seq_along(folds)) {
      test_idx <- folds[[i]]
      train_edges <- data_cv[-test_idx, ]
      test_edges <- data_cv[test_idx, ]
      
      # Building training graph
      train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
      
      # Predicting for test set
      for(j in 1:nrow(test_edges)) {
        v1 <- test_edges$from[j]
        v2 <- test_edges$to[j]
        score <- jaccard_score(train_g, v1, v2)
        pred <- as.integer(score >= 0.5)
        true_labels <- c(true_labels, test_edges$label[j])
        pred_labels <- c(pred_labels, pred)
      }
    }
    
    # Confusion matrix
    results <- data.frame(
      truth = factor(true_labels, levels=c(1,0)),
      prediction = factor(pred_labels, levels=c(1,0))
    )
    cm <- conf_mat(results, truth="truth", estimate="prediction")
    print(cm)
    
    ########################## Optional plot confusion matrix ######################
    autoplot(cm, type = "heatmap") + ggplot2::scale_fill_gradient(low="white", high="red")
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 25.4.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw the ROC curves on the cross validation of the network used
    # at the previous question, comparing the following link predictors:
    # preferential attachment, jaccard, Adamic-Adar, and resource alloca-
    # tion. Which of those has the highest AUC? (Again, scikit-learn
    # has helper functions for you)
    
    library(here)
    library(igraph)
    library(caret)
    library(pROC)
    
    ########################### Helper functions ###################################
    
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Draw the ROC curves on the cross validation of the network used
    # at the previous question, comparing the following link predictors:
    # preferential attachment, jaccard, Adamic-Adar, and resource alloca-
    # tion. Which of those has the highest AUC? (Again, scikit-learn
    # has helper functions for you)
    
    library(here)
    library(igraph)
    library(caret)
    library(pROC)
    
    ########################### Helper functions ###################################
    
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Solution
    
    # Generating all possible node pairs
    all_pairs <- t(combn(all_nodes, 2))
    all_edges_df <- data.frame(from=all_pairs[,1], to=all_pairs[,2], stringsAsFactors=FALSE)
    
    # Mark which pairs are actual edges
    all_edges_df$edge <- mapply(function(f, t) {
      are.connected(g_full, f, t)
    }, all_edges_df$from, all_edges_df$to)
    
    # Getting positive (edges) and negative (non-edges) samples
    pos_edges <- all_edges_df[all_edges_df$edge, c("from", "to")]
    neg_edges <- all_edges_df[!all_edges_df$edge, c("from", "to")]
    
    # For cross-validation, combine positives and sample negatives to match number 
    # of positives (for balanced evaluation)
    set.seed(42)
    neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
    data_cv <- rbind(
      data.frame(pos_edges, label=1),
      data.frame(neg_edges, label=0)
    )
    data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle
    
    # 10-fold cross-validation
    folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)
    
    # Run cross-validation & collect scores/labels
    label_all = c()
    score_pa = c()
    score_jaccard = c()
    score_adamic = c()
    score_ra = c()
    
    for(i in seq_along(folds)) {
      test_idx <- folds[[i]]
      train_edges <- data_cv[-test_idx, ]
      test_edges <- data_cv[test_idx, ]
      
      # Building training graph
      train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
      
      for(j in 1:nrow(test_edges)) {
        v1 <- test_edges$from[j]
        v2 <- test_edges$to[j]
        label_all <- c(label_all, test_edges$label[j])
        score_pa <- c(score_pa, preferential_attachment(train_g, v1, v2))
        score_jaccard <- c(score_jaccard, jaccard_score(train_g, v1, v2))
        score_adamic <- c(score_adamic, adamic_adar_score(train_g, v1, v2))
        score_ra <- c(score_ra, resource_allocation_score(train_g, v1, v2))
      }
    }
    
    # Computing and plotting ROC curves & AUC
    roc_pa <- roc(label_all, score_pa, quiet=TRUE)
    roc_jaccard <- roc(label_all, score_jaccard, quiet=TRUE)
    roc_adamic <- roc(label_all, score_adamic, quiet=TRUE)
    roc_ra <- roc(label_all, score_ra, quiet=TRUE)
    
    plot(roc_pa, col="red", lwd=2, main="ROC Curves: Link Predictors")
    plot(roc_jaccard, col="blue", lwd=2, add=TRUE)
    plot(roc_adamic, col="green", lwd=2, add=TRUE)
    plot(roc_ra, col="purple", lwd=2, add=TRUE)
    legend("bottomright", legend=c(
      sprintf("Pref. Attach. (AUC = %.3f)", auc(roc_pa)),
      sprintf("Jaccard (AUC = %.3f)", auc(roc_jaccard)),
      sprintf("Adamic-Adar (AUC = %.3f)", auc(roc_adamic)),
      sprintf("Resource Alloc. (AUC = %.3f)", auc(roc_ra))
    ), col=c("red", "blue", "green", "purple"), lwd=2)
    
    # 10. Printing AUCs and the best predictor
    auc_vals <- c(
      Preferential_Attachment=auc(roc_pa),
      Jaccard=auc(roc_jaccard),
      Adamic_Adar=auc(roc_adamic),
      Resource_Allocation=auc(roc_ra)
    )
    
    # Printing the rest of the results 
    print(auc_vals)
    cat(sprintf("\nHighest AUC: %s (%.3f)\n", names(which.max(auc_vals)), max(auc_vals)))
```

</details>

</details>

<details>
<summary>

## 25.4.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate precision, recall, and F1-score for the four link predictors
    # as used in the previous question. Set up as cutoff point the nineti-
    # eth percentile, meaning that you predict a link only for the highest
    # ten percent of the scores in each classifier. Which method performs
    # best according to these measures? (Note: when scoring with the
    # scikit-learn function, remember that this is a binary prediction
    # task)
    
    library(igraph)
    library(caret)
    
    ########################### Helper functions ###################################
    
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate precision, recall, and F1-score for the four link predictors
    # as used in the previous question. Set up as cutoff point the nineti-
    # eth percentile, meaning that you predict a link only for the highest
    # ten percent of the scores in each classifier. Which method performs
    # best according to these measures? (Note: when scoring with the
    # scikit-learn function, remember that this is a binary prediction
    # task)
    
    library(igraph)
    library(caret)
    
    ########################### Helper functions ###################################
    
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Solution
    
    # Generating all possible node pairs
    all_pairs <- t(combn(all_nodes, 2))
    all_edges_df <- data.frame(from=all_pairs[,1], to=all_pairs[,2], stringsAsFactors=FALSE)
    
    # Marking which pairs are actual edges
    all_edges_df$edge <- mapply(function(f, t) {
      are.connected(g_full, f, t)
    }, all_edges_df$from, all_edges_df$to)
    
    # Getting positive (edges) and negative (non-edges) samples
    pos_edges <- all_edges_df[all_edges_df$edge, c("from", "to")]
    neg_edges <- all_edges_df[!all_edges_df$edge, c("from", "to")]
    
    # For cross-validation, combine positives and sample negatives to match 
    # number of positives (for balanced evaluation)
    set.seed(42)
    neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
    data_cv <- rbind(
      data.frame(pos_edges, label=1),
      data.frame(neg_edges, label=0)
    )
    data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle
    
    # 10-fold cross-validation
    folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)
    
    # Running cross-validation & collect scores/labels
    label_all = c()
    score_pa = c()
    score_jaccard = c()
    score_adamic = c()
    score_ra = c()
    
    for(i in seq_along(folds)) {
      test_idx <- folds[[i]]
      train_edges <- data_cv[-test_idx, ]
      test_edges <- data_cv[test_idx, ]
      
      # Building training graph
      train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
      
      for(j in 1:nrow(test_edges)) {
        v1 <- test_edges$from[j]
        v2 <- test_edges$to[j]
        label_all <- c(label_all, test_edges$label[j])
        score_pa <- c(score_pa, preferential_attachment(train_g, v1, v2))
        score_jaccard <- c(score_jaccard, jaccard_score(train_g, v1, v2))
        score_adamic <- c(score_adamic, adamic_adar_score(train_g, v1, v2))
        score_ra <- c(score_ra, resource_allocation_score(train_g, v1, v2))
      }
    }
    
    # Appling 90th percentile cutoff for each predictor
    predict_by_percentile <- function(scores, percentile=0.9) {
      cutoff <- quantile(scores, probs=percentile, na.rm=TRUE)
      as.integer(scores >= cutoff)
    }
    
    pred_pa <- predict_by_percentile(score_pa)
    pred_jaccard <- predict_by_percentile(score_jaccard)
    pred_adamic <- predict_by_percentile(score_adamic)
    pred_ra <- predict_by_percentile(score_ra)
    
    # Computing precision, recall, F1 for each
    get_metrics <- function(truth, pred) {
      cm <- table(Prediction=pred, Truth=truth)
      TP <- sum(pred==1 & truth==1)
      FP <- sum(pred==1 & truth==0)
      FN <- sum(pred==0 & truth==1)
      precision <- ifelse(TP+FP==0, 0, TP/(TP+FP))
      recall <- ifelse(TP+FN==0, 0, TP/(TP+FN))
      f1 <- ifelse(precision+recall==0, 0, 2*precision*recall/(precision+recall))
      list(precision=precision, recall=recall, f1=f1)
    }
    
    metrics_pa <- get_metrics(label_all, pred_pa)
    metrics_jaccard <- get_metrics(label_all, pred_jaccard)
    metrics_adamic <- get_metrics(label_all, pred_adamic)
    metrics_ra <- get_metrics(label_all, pred_ra)
    
    # Printing results in a table
    results <- data.frame(
      Predictor = c("Preferential Attachment", "Jaccard", "Adamic-Adar", "Resource Allocation"),
      Precision = c(metrics_pa$precision, metrics_jaccard$precision, metrics_adamic$precision, metrics_ra$precision),
      Recall    = c(metrics_pa$recall, metrics_jaccard$recall, metrics_adamic$recall, metrics_ra$recall),
      F1        = c(metrics_pa$f1, metrics_jaccard$f1, metrics_adamic$f1, metrics_ra$f1)
    )
    print(results, digits=3, row.names=FALSE)
    
    # Which performs best?
    best_idx <- which.max(results$F1)
    cat(sprintf("\nBest method by F1-score: %s (F1=%.3f)\n", results$Predictor[best_idx], results$F1[best_idx]))
```

</details>

</details>

<details>
<summary>

## 25.4.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw the precision-recall curves of the four link predictors as used
    # in the previous questions. Which of those has the highest AUC?
    
    library(here)
    library(igraph)
    library(caret)
    library(PRROC)
    
    ########################### Helper functions ###################################
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Draw the precision-recall curves of the four link predictors as used
    # in the previous questions. Which of those has the highest AUC?
    
    library(here)
    library(igraph)
    library(caret)
    library(PRROC)
    
    ########################### Helper functions ###################################
    # Predictor functions
    preferential_attachment <- function(g, v1, v2) {
      deg <- degree(g)
      deg[v1] * deg[v2]
    }
    jaccard_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      intersect_len <- length(intersect(n1, n2))
      union_len <- length(union(n1, n2))
      if (union_len == 0) return(0) else return(intersect_len / union_len)
    }
    adamic_adar_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / log(degree(g, comm)))
    }
    resource_allocation_score <- function(g, v1, v2) {
      n1 <- neighbors(g, v1)
      n2 <- neighbors(g, v2)
      comm <- intersect(n1, n2)
      if (length(comm) == 0) return(0)
      sum(1 / degree(g, comm))
    }
    ####################### End Helper functions ###################################
    
    # Reading the data and building the graph
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("from", "to")
    edges[] <- lapply(edges, as.character)
    g_full <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
    
    all_nodes <- V(g_full)$name
    
    # Solution 
    
    # Generating all possible node pairs
    all_pairs <- t(combn(all_nodes, 2))
    all_edges_df <- data.frame(from=all_pairs[,1], to=all_pairs[,2], stringsAsFactors=FALSE)
    
    # Marking which pairs are actual edges
    all_edges_df$edge <- mapply(function(f, t) {
      are.connected(g_full, f, t)
    }, all_edges_df$from, all_edges_df$to)
    
    # Getting positive (edges) and negative (non-edges) samples
    pos_edges <- all_edges_df[all_edges_df$edge, c("from", "to")]
    neg_edges <- all_edges_df[!all_edges_df$edge, c("from", "to")]
    
    # For cross-validation, combine positives and sample negatives to match number of positives (for balanced evaluation)
    set.seed(42)
    neg_edges <- neg_edges[sample(nrow(neg_edges), nrow(pos_edges)), ]
    data_cv <- rbind(
      data.frame(pos_edges, label=1),
      data.frame(neg_edges, label=0)
    )
    data_cv <- data_cv[sample(nrow(data_cv)), ] # Shuffle
    
    # 10-fold cross-validation
    folds <- createFolds(data_cv$label, k=10, list=TRUE, returnTrain=FALSE)
    
    # Run cross-validation & collect scores/labels
    label_all = c()
    score_pa = c()
    score_jaccard = c()
    score_adamic = c()
    score_ra = c()
    
    for(i in seq_along(folds)) {
      test_idx <- folds[[i]]
      train_edges <- data_cv[-test_idx, ]
      test_edges <- data_cv[test_idx, ]
      
      # Building training graph
      train_g <- graph_from_data_frame(train_edges[train_edges$label==1, c("from","to")], directed=FALSE, vertices=all_nodes)
      
      for(j in 1:nrow(test_edges)) {
        v1 <- test_edges$from[j]
        v2 <- test_edges$to[j]
        label_all <- c(label_all, test_edges$label[j])
        score_pa <- c(score_pa, preferential_attachment(train_g, v1, v2))
        score_jaccard <- c(score_jaccard, jaccard_score(train_g, v1, v2))
        score_adamic <- c(score_adamic, adamic_adar_score(train_g, v1, v2))
        score_ra <- c(score_ra, resource_allocation_score(train_g, v1, v2))
      }
    }
    
    # Calculating PR curves and AUCs
    pr_pa <- pr.curve(scores.class0=score_pa[label_all==1], scores.class1=score_pa[label_all==0], curve=TRUE)
    pr_jaccard <- pr.curve(scores.class0=score_jaccard[label_all==1], scores.class1=score_jaccard[label_all==0], curve=TRUE)
    pr_adamic <- pr.curve(scores.class0=score_adamic[label_all==1], scores.class1=score_adamic[label_all==0], curve=TRUE)
    pr_ra <- pr.curve(scores.class0=score_ra[label_all==1], scores.class1=score_ra[label_all==0], curve=TRUE)
    
    # Plotting PR curves
    plot(pr_pa$curve[,1], pr_pa$curve[,2], type="l", col="red", lwd=2, xlab="Recall", ylab="Precision",
         main="Precision-Recall Curves: Link Predictors", xlim=c(0,1), ylim=c(0,1))
    lines(pr_jaccard$curve[,1], pr_jaccard$curve[,2], col="blue", lwd=2)
    lines(pr_adamic$curve[,1], pr_adamic$curve[,2], col="green", lwd=2)
    lines(pr_ra$curve[,1], pr_ra$curve[,2], col="purple", lwd=2)
    legend("topright", legend=c(
      sprintf("Pref. Attach. (AUC = %.3f)", pr_pa$auc.integral),
      sprintf("Jaccard (AUC = %.3f)", pr_jaccard$auc.integral),
      sprintf("Adamic-Adar (AUC = %.3f)", pr_adamic$auc.integral),
      sprintf("Resource Alloc. (AUC = %.3f)", pr_ra$auc.integral)
    ), col=c("red", "blue", "green", "purple"), lwd=2)
    
    # Printing AUCs and best curve
    auc_vals <- c(
      Preferential_Attachment=pr_pa$auc.integral,
      Jaccard=pr_jaccard$auc.integral,
      Adamic_Adar=pr_adamic$auc.integral,
      Resource_Allocation=pr_ra$auc.integral
    )
    print(round(auc_vals, 3))
    cat(sprintf("\nHighest PR AUC: %s (%.3f)\n", names(which.max(auc_vals)), max(auc_vals)))
```

</details>

</details>

<details>
<summary>

## 26.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform a network projection of the bipartite network at http:
    # //www.networkatlas.eu/exercises/26/1/data.txt using simple
    # weights. The unipartite projection should only contain nodes of
    # type 1 (|V1 | = 248). How dense is the projection?
    
    library(here)
    library(igraph)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform a network projection of the bipartite network at http:
    # //www.networkatlas.eu/exercises/26/1/data.txt using simple
    # weights. The unipartite projection should only contain nodes of
    # type 1 (|V1 | = 248). How dense is the projection?
    
    library(here)
    library(igraph)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Solution 
    
    # Identifying node types
    V1 <- unique(c(edges$V1[grep("^a", edges$V1)], edges$V2[grep("^a", edges$V2)]))
    V2 <- unique(c(edges$V1[grep("^b", edges$V1)], edges$V2[grep("^b", edges$V2)]))
    
    # Preparing vertex dataframe with a type attribute (TRUE for V1, FALSE for V2)
    vertex_df <- data.frame(
      name=c(V1, V2),
      type=c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
    )
    
    # Preparing edge list so all edges are from V1 to V2 (order doesn't matter for undirected)
    edges_long <- data.frame(
      V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
      V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
      stringsAsFactors=FALSE
    )
    
    # Creating a bipartite graph
    g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)
    
    # Projecting onto type 1 nodes (V1, type==TRUE)
    proj <- bipartite_projection(g_bipartite)
    g_proj <- proj$proj1  # This will be the V1 projection, since we ordered the vertex_df
    
    # Calculating the density
    n <- length(V1)
    num_edges <- gsize(g_proj)
    possible_edges <- n * (n - 1) / 2
    density <- num_edges / possible_edges
    
    # Printing the results 
    cat(sprintf("Number of nodes in projection: %d\n", n))
    cat(sprintf("Number of edges in projection: %d\n", num_edges))
    cat(sprintf("Possible number of edges: %d\n", possible_edges))
    cat(sprintf("Density of the unipartite projection: %.5f\n", density))
    
    ################################################################################
    # Optional
    
    # Plotting the original bipartite network
    V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "salmon")
    V(g_bipartite)$shape <- ifelse(V(g_bipartite)$type, "circle", "square")
    V(g_bipartite)$size <- 3
    V(g_bipartite)$label <- NA  # hide labels for clarity
    
    # Use a bipartite layout (type1 nodes on one axis, type2 on the other)
    layout_bip <- layout_as_bipartite(g_bipartite)
    plot(
      g_bipartite,
      layout=layout_bip,
      main="Original Bipartite Network"
    )
    
    # Plotting the projected network
    set.seed(42) # For reproducible layout
    plot(
      g_proj,
      vertex.size=3,
      vertex.label=NA,
      edge.width=1,
      edge.color="gray80",
      vertex.color="skyblue",
      main="Unipartite Projection of Type 1 Nodes"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 26.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform a network projection of the previously used bipartite
    # network using cosine and Pearson weights. What is the Pearson
    # correlation of these weights compared with the ones from the
    # previous question?
    
    library(here)
    library(igraph)
    library(Matrix)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform a network projection of the previously used bipartite
    # network using cosine and Pearson weights. What is the Pearson
    # correlation of these weights compared with the ones from the
    # previous question?
    
    library(here)
    library(igraph)
    library(Matrix)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Solution 
    
    # Identifying node types (V1: starts with "a", V2: starts with "b")
    V1 <- unique(c(edges$V1[grep("^a", edges$V1)], edges$V2[grep("^a", edges$V2)]))
    V2 <- unique(c(edges$V1[grep("^b", edges$V1)], edges$V2[grep("^b", edges$V2)]))
    
    # Preparing vertex dataframe with a type attribute (TRUE for V1, FALSE for V2)
    vertex_df <- data.frame(
      name=c(V1, V2),
      type=c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
    )
    
    # Preparing edge list so all edges are from V1 to V2
    edges_long <- data.frame(
      V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
      V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
      stringsAsFactors=FALSE
    )
    
    # Creating a bipartite graph
    g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)
    
    # Projecting onto type 1 nodes (V1, type==TRUE, simple weights)
    proj <- bipartite_projection(g_bipartite)
    g_proj <- proj$proj1
    
    # Calculating density
    n <- length(V1)
    num_edges <- gsize(g_proj)
    possible_edges <- n * (n - 1) / 2
    density <- num_edges / possible_edges
    
    # From the previous exercise printing the results 
    cat(sprintf("Number of nodes in projection: %d\n", n))
    cat(sprintf("Number of edges in projection: %d\n", num_edges))
    cat(sprintf("Possible number of edges: %d\n", possible_edges))
    cat(sprintf("Density of the unipartite projection: %.5f\n", density))
    
    ################################################################################
    # Optional
    
    # Plotting the projected network (simple weights)
    set.seed(42)
    plot(
      g_proj,
      vertex.size=3,
      vertex.label=NA,
      edge.width=1,
      edge.color="gray80",
      vertex.color="skyblue",
      main="Unipartite Projection (Simple Weights)"
    )
    
    # Plotting the original bipartite network
    V(g_bipartite)$color <- ifelse(V(g_bipartite)$type, "skyblue", "salmon")
    V(g_bipartite)$shape <- ifelse(V(g_bipartite)$type, "circle", "square")
    V(g_bipartite)$size <- 3
    V(g_bipartite)$label <- NA  # hide labels for clarity
    
    layout_bip <- layout_as_bipartite(g_bipartite)
    plot(
      g_bipartite,
      layout=layout_bip,
      main="Original Bipartite Network"
    )
    ################################################################################
    
    ################ Cosine and Pearson Weighted Projections #######################
    
    # Bipartite incidence matrix (rows: V1, cols: V2)
    A <- as_incidence_matrix(g_bipartite, types=vertex_df$type, sparse=TRUE)
    A <- as(A, "dgCMatrix") # Ensure sparse matrix
    
    #  Cosine similarity matrix
    norms <- sqrt(rowSums(A^2))
    cosine_sim <- as.matrix(A %*% t(A))
    norms_mat <- outer(norms, norms)
    cosine_sim <- cosine_sim / norms_mat
    diag(cosine_sim) <- 0 # Remove self-loops
    cosine_sim[is.na(cosine_sim)] <- 0
    
    #  Pearson similarity matrix
    A_centered <- A - rowMeans(A)
    pearson_num <- as.matrix(A_centered %*% t(A_centered))
    pearson_denom <- outer(
      sqrt(rowSums((A - rowMeans(A))^2)),
      sqrt(rowSums((A - rowMeans(A))^2))
    )
    pearson_sim <- pearson_num / pearson_denom
    diag(pearson_sim) <- 0
    pearson_sim[is.na(pearson_sim)] <- 0
    
    # Building edges for upper triangle only (i < j), using V1 names
    get_upper_edges <- function(sim_matrix, node_names, min_weight = 0) {
      idx <- which(upper.tri(sim_matrix) & sim_matrix > min_weight, arr.ind=TRUE)
      if(nrow(idx) == 0) return(data.frame(from=character(), to=character(), weight=numeric()))
      data.frame(
        from = node_names[idx[,1]],
        to   = node_names[idx[,2]],
        weight = sim_matrix[idx],
        stringsAsFactors = FALSE
      )
    }
    
    edges_cosine <- get_upper_edges(cosine_sim, V1)
    edges_pearson <- get_upper_edges(pearson_sim, V1)
    
    # Cleaning up: removing NAs, NaNs, empties, self-loops, and non-existent nodes (shouldn't happen, but robust)
    edges_cosine <- subset(edges_cosine, 
                           !is.na(from) & !is.na(to) & from != "" & to != "" & !is.nan(weight) & from %in% V1 & to %in% V1 & from != to
    )
    edges_pearson <- subset(edges_pearson, 
                            !is.na(from) & !is.na(to) & from != "" & to != "" & !is.nan(weight) & from %in% V1 & to %in% V1 & from != to
    )
    
    # Removing duplicate edges (if any)
    edges_cosine <- unique(edges_cosine)
    edges_pearson <- unique(edges_pearson)
    
    # Only building the graph if there are edges
    if (nrow(edges_cosine) > 0) {
      g_cosine <- graph_from_data_frame(edges_cosine, directed=FALSE, vertices=data.frame(name=V1))
      E(g_cosine)$weight <- edges_cosine$weight
    } else {
      warning("No edges in cosine projection.")
      g_cosine <- make_empty_graph(n = length(V1))
    }
    
    if (nrow(edges_pearson) > 0) {
      g_pearson <- graph_from_data_frame(edges_pearson, directed=FALSE, vertices=data.frame(name=V1))
      E(g_pearson)$weight <- edges_pearson$weight
    } else {
      warning("No edges in Pearson projection.")
      g_pearson <- make_empty_graph(n = length(V1))
    }
    
    ################################# Optional #####################################
    # Plotting Cosine Weights
    set.seed(42)
    plot(
      g_cosine,
      vertex.size=3,
      vertex.label=NA,
      edge.width=E(g_cosine)$weight * 5, # scale for visibility
      edge.color=rgb(0,0,0,alpha=0.3),
      vertex.color="skyblue",
      main="Projection (Cosine Similarity Weights)"
    )
    
    # Plotting Pearson Weights
    set.seed(42)
    plot(
      g_pearson,
      vertex.size=3,
      vertex.label=NA,
      edge.width=pmax(E(g_pearson)$weight,0) * 5,
      edge.color=rgb(0,0,1,alpha=0.3),
      vertex.color="skyblue",
      main="Projection (Pearson Similarity Weights)"
    )
    ################################################################################
    
    # Pearson correlation of weights (simple vs cosine, simple vs pearson, cosine vs pearson)
    simple_weights <- E(g_proj)$weight
    names(simple_weights) <- apply(as.data.frame(ends(g_proj, E(g_proj))), 1, function(x) paste(sort(x), collapse = "_"))
    cosine_weights <- edges_cosine$weight
    names(cosine_weights) <- apply(edges_cosine[,1:2], 1, function(x) paste(sort(x), collapse = "_"))
    pearson_weights <- edges_pearson$weight
    names(pearson_weights) <- apply(edges_pearson[,1:2], 1, function(x) paste(sort(x), collapse = "_"))
    
    # Only comparing weights where an edge is present in all projections
    common_keys <- Reduce(intersect, list(names(simple_weights), names(cosine_weights), names(pearson_weights)))
    cat(sprintf("Number of common edges between all projections: %d\n", length(common_keys)))
    
    if(length(common_keys) > 1) {
      cat(sprintf("Pearson correlation (simple vs cosine): %.4f\n",
                  cor(simple_weights[common_keys], cosine_weights[common_keys])))
      cat(sprintf("Pearson correlation (simple vs pearson): %.4f\n",
                  cor(simple_weights[common_keys], pearson_weights[common_keys])))
      cat(sprintf("Pearson correlation (cosine vs pearson): %.4f\n",
                  cor(cosine_weights[common_keys], pearson_weights[common_keys])))
    } else {
      cat("Not enough common edges to compute Pearson correlations.\n")
    }
```

</details>

</details>

<details>
<summary>

## 26.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform a network projection of the previously used bipartite
    # network using hyperbolic weights. Draw a scatter plot comparing
    # hyperbolic and simple weights.
    
    library(here)
    library(igraph)
    library(Matrix)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform a network projection of the previously used bipartite
    # network using hyperbolic weights. Draw a scatter plot comparing
    # hyperbolic and simple weights.
    
    library(here)
    library(igraph)
    library(Matrix)
    
    # Reading the bipartite edge list
    edges <- read.table("data.txt", header=FALSE, stringsAsFactors=FALSE)
    colnames(edges) <- c("V1", "V2")
    
    # Solution
    
    # Identifying node types (V1: starts with "a", V2: starts with "b")
    V1 <- unique(c(edges$V1[grep("^a", edges$V1)], edges$V2[grep("^a", edges$V2)]))
    V2 <- unique(c(edges$V1[grep("^b", edges$V1)], edges$V2[grep("^b", edges$V2)]))
    
    # Preparing vertex dataframe with a type attribute (TRUE for V1, FALSE for V2)
    vertex_df <- data.frame(
      name = c(V1, V2),
      type = c(rep(TRUE, length(V1)), rep(FALSE, length(V2)))
    )
    
    # Preparing edge list so all edges are from V1 to V2
    edges_long <- data.frame(
      V1 = ifelse(grepl("^a", edges$V1), edges$V1, edges$V2),
      V2 = ifelse(grepl("^b", edges$V1), edges$V1, edges$V2),
      stringsAsFactors = FALSE
    )
    
    # Creating bipartite graph
    g_bipartite <- graph_from_data_frame(edges_long, directed=FALSE, vertices=vertex_df)
    
    # Projecting onto type 1 nodes (V1) using simple weights (number of shared neighbors in V2)
    proj <- bipartite_projection(g_bipartite)
    g_proj <- proj$proj1
    
    # Incidence matrix (rows: V1 nodes, cols: V2 nodes)
    A <- as_incidence_matrix(g_bipartite, types=vertex_df$type, sparse=TRUE)
    A <- as(A, "dgCMatrix") # Ensure sparse matrix
    V1_names <- rownames(A)
    V2_names <- colnames(A)
    
    # Hyperbolic weights (using rownames(A) for matrix names and all node accesses)
    hyperbolic_weights <- matrix(0, nrow=length(V1_names), ncol=length(V1_names), dimnames=list(V1_names, V1_names))
    deg_V2 <- Matrix::colSums(A) # degree for each V2 node
    
    for (k in which(deg_V2 > 1)) {
      v2 <- V2_names[k]
      nodes <- V1_names[which(A[, v2] == 1)]
      if(length(nodes) < 2) next
      w <- 1 / (deg_V2[k] - 1)
      for(i in 1:(length(nodes)-1)) {
        for(j in (i+1):length(nodes)) {
          hyperbolic_weights[nodes[i], nodes[j]] <- hyperbolic_weights[nodes[i], nodes[j]] + w
          hyperbolic_weights[nodes[j], nodes[i]] <- hyperbolic_weights[nodes[j], nodes[i]] + w
        }
      }
    }
    
    # Extracting simple weights for V1 pairs
    simple_weights <- as.matrix(A %*% t(A))
    diag(simple_weights) <- 0 # remove self-loops
    
    # Preparing data for scatter plot (upper triangle, i < j)
    scatter_data <- data.frame(
      from = character(), to = character(),
      simple = numeric(), hyperbolic = numeric(),
      stringsAsFactors = FALSE
    )
    for(i in 1:(length(V1_names)-1)) {
      for(j in (i+1):length(V1_names)) {
        s <- simple_weights[V1_names[i], V1_names[j]]
        h <- hyperbolic_weights[V1_names[i], V1_names[j]]
        if(s > 0 || h > 0) {
          scatter_data <- rbind(scatter_data, data.frame(
            from=V1_names[i], to=V1_names[j], simple=s, hyperbolic=h
          ))
        }
      }
    }
    
    # Scatter plot: hyperbolic vs simple weights
    plot(
      scatter_data$simple, scatter_data$hyperbolic,
      pch=20, col=rgb(0,0,1,0.5),
      xlab="Simple Weight (shared neighbors)", ylab="Hyperbolic Weight",
      main="Scatter Plot: Hyperbolic vs Simple Weights"
    )
    abline(0, 1, col="red", lty=2)
    
    ################################################################################
    # Optional
    
    # Printing correlation
    cor_val <- cor(scatter_data$simple, scatter_data$hyperbolic)
    cat(sprintf("Pearson correlation between simple and hyperbolic weights: %.4f\n", cor_val))
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 27.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Plot the CCDF edge weight distribution of the network at http:
    # //www.networkatlas.eu/exercises/27/1/data.txt. Calculate its
    # average and standard deviation. NOTE: this is a directed graph!
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Extract edge weights
    w <- E(g)$weight
    
    # Write ehre the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Plot the CCDF edge weight distribution of the network at http:
    # //www.networkatlas.eu/exercises/27/1/data.txt. Calculate its
    # average and standard deviation. NOTE: this is a directed graph!
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Extract edge weights
    w <- E(g)$weight
    
    # Solution 
    
    # Computing average and standard deviation of edge weights
    w_mean <- mean(w)
    w_sd <- sd(w)
    cat(sprintf("Average edge weight: %.2f\n", w_mean))
    cat(sprintf("Standard deviation of edge weights: %.2f\n", w_sd))
    
    # Computing CCDF
    w_sorted <- sort(w)
    ccdf <- 1 - ecdf(w_sorted)(w_sorted) + 1/length(w_sorted)
    
    # Plotting CCDF (log-log scale, typical for weight distributions)
    plot(
      w_sorted, ccdf,
      log="xy",
      type="s",
      xlab="Edge weight",
      ylab="CCDF",
      main="CCDF of Edge Weights"
    )
    grid()
    
    legend(
      "bottomleft",
      legend=c(
        sprintf("Mean = %.2f", w_mean),
        sprintf("SD = %.2f", w_sd)
      ),
      bty="n"
    )

```

</details>

</details>

<details>
<summary>

## 27.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the minimum statistically significant edge weight – the
    # one two standard deviations away from the average – of the previ-
    # ous network? How many edges would you keep if you were to set
    # that as the threshold?
    
    library(here)
    library(igraph)
    
    # Reading the edge list from file
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Extracting edge weights
    w <- E(g)$weight
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the minimum statistically significant edge weight – the
    # one two standard deviations away from the average – of the previ-
    # ous network? How many edges would you keep if you were to set
    # that as the threshold?
    
    library(here)
    library(igraph)
    
    # Reading the edge list from file
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Extracting edge weights
    w <- E(g)$weight
    
    # Solution 
    
    # Computing mean and standard deviation
    w_mean <- mean(w)
    w_sd <- sd(w)
    # Minimum statistically significant edge weight (mean + 2*sd)
    threshold <- w_mean + 2*w_sd
    
    
    # Printing solutions 
    cat(sprintf("Average edge weight: %.2f\n", w_mean))
    cat(sprintf("Standard deviation: %.2f\n", w_sd))
    cat(sprintf("Minimum statistically significant edge weight (mean + 2*sd): %.2f\n", threshold))
    
    # How many edges meet or exceed this threshold?
    n_above <- sum(w >= threshold)
    cat(sprintf("Number of edges retained with threshold %.2f: %d (out of %d)\n", threshold, n_above, length(w)))
```

</details>

</details>

<details>
<summary>

## 27.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Can you calculate the doubly stochastic adjacency matrix of
    # the network used in the previous exercise? Does the calculation
    # eventually converge? (Limit the normalization attempts to 1,000. If
    # by 1,000 normalizations you don’t have a doubly stochastic matrix,
    # the calculation didn’t converge)
    
    library(here)
    library(igraph)
    
    # Reading the edge list from file
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Can you calculate the doubly stochastic adjacency matrix of
    # the network used in the previous exercise? Does the calculation
    # eventually converge? (Limit the normalization attempts to 1,000. If
    # by 1,000 normalizations you don’t have a doubly stochastic matrix,
    # the calculation didn’t converge)
    
    library(here)
    library(igraph)
    
    # Reading the edge list from file
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Solution 
    
    # Getting the adjacency matrix (rows/cols: all nodes, values: weights)
    A <- as.matrix(as_adjacency_matrix(g, attr="weight", sparse=FALSE))
    
    # Preparing the matrix for normalization (only positive values, fill zeros for missing edges)
    A[is.na(A)] <- 0
    
    # Function to normalize rows or columns to sum to 1
    normalize_rows <- function(mat) {
      rs <- rowSums(mat)
      rs[rs == 0] <- 1 # avoid division by zero
      mat/rs
    }
    normalize_cols <- function(mat) {
      cs <- colSums(mat)
      cs[cs == 0] <- 1 # avoid division by zero
      t(t(mat)/cs)
    }
    
    # Iterative normalization: alternate row and column normalization
    max_iter <- 1000
    tol <- 1e-8
    converged <- FALSE
    for(i in 1:max_iter) {
      old_A <- A
      A <- normalize_rows(A)
      A <- normalize_cols(A)
      # Check convergence: all row and col sums close to 1
      row_diff <- max(abs(rowSums(A) - 1))
      col_diff <- max(abs(colSums(A) - 1))
      if(row_diff < tol && col_diff < tol) {
        converged <- TRUE
        cat(sprintf("Converged after %d iterations.\n", i))
        break
      }
    }
    if(!converged) {
      cat("Did NOT converge after 1000 iterations.\n")
    }
    
    ################################################################################
    
    # Optional
    # Showing summary of the final matrix
    cat("summary of the final matrix \n")
    cat("\n Max row sum deviation from 1:", max(abs(rowSums(A) - 1)), "\n")
    cat("Max col sum deviation from 1:", max(abs(colSums(A) - 1)), "\n")
    
    # Printing the entire matrix (rounded for readability)
    cat("Entire doubly stochastic matrix (rounded to 4 decimals):\n")
    print(round(A, 4))
    
    # Plotting the entire matrix
    par(bg="white")
    image(
      t(A[nrow(A):1, ]),                        # flip vertically for intuitive axes
      main = "Doubly Stochastic Matrix",
      xlab = "Columns",
      ylab = "Rows",
      col = gray.colors(100, start=1, end=0),   # white to black
      axes = FALSE
    )
    box()
    axis(1, at=seq(0,1,length.out=ncol(A)), labels=colnames(A), las=2, cex.axis=0.5)
    axis(2, at=seq(0,1,length.out=nrow(A)), labels=rev(rownames(A)), las=2, cex.axis=0.5)
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 27.8.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # How many edges would you keep if you were to return the dou-
    # bly stochastic backbone including all nodes in the network in a
    # single (weakly) connected component with the minimum number
    # of edges?
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # How many edges would you keep if you were to return the dou-
    # bly stochastic backbone including all nodes in the network in a
    # single (weakly) connected component with the minimum number
    # of edges?
    
    library(here)
    library(igraph)
    
    # Reading the edge list
    edges <- read.table("data.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
    colnames(edges) <- c("from", "to", "weight")
    
    # Creating a directed, weighted graph
    g <- graph_from_data_frame(edges, directed=TRUE)
    
    # Solution 
    
    # Getting the adjacency matrix (rows/cols: all nodes, values: weights)
    A <- as.matrix(as_adjacency_matrix(g, attr="weight", sparse=FALSE))
    A[is.na(A)] <- 0
    
    # Doubling stochastic normalization (Sinkhorn-Knopp algorithm)
    normalize_rows <- function(mat) {
      rs <- rowSums(mat)
      rs[rs == 0] <- 1
      mat/rs
    }
    normalize_cols <- function(mat) {
      cs <- colSums(mat)
      cs[cs == 0] <- 1
      t(t(mat)/cs)
    }
    max_iter <- 1000
    tol <- 1e-8
    for(i in 1:max_iter) {
      A <- normalize_rows(A)
      A <- normalize_cols(A)
      if(max(abs(rowSums(A) - 1)) < tol && max(abs(colSums(A) - 1)) < tol) {
        cat(sprintf("Doubly stochastic normalization converged after %d iterations.\n", i))
        break
      }
      if(i == max_iter) cat("Doubly stochastic normalization did NOT fully converge in 1000 iterations.\n")
    }
    
    # Building undirected weighted graph from the final matrix (ignore direction, sum weights)
    A_sym <- (A + t(A)) / 2
    diag(A_sym) <- 0
    
    g_und <- graph_from_adjacency_matrix(A_sym, mode="undirected", weighted=TRUE, diag=FALSE)
    
    # Computing minimum spanning tree (MST) to get the backbone with minimal edges
    E(g_und)$neg_weight <- -E(g_und)$weight
    mst <- mst(g_und, weights=E(g_und)$neg_weight)
    
    # Number of nodes and edges in the backbone
    n_nodes <- vcount(mst)
    n_edges <- ecount(mst)
    cat(sprintf("Number of nodes: %d\n", n_nodes))
    cat(sprintf("Number of edges in backbone: %d\n", n_edges))
    
    # Checking connectivity
    if(is.connected(mst, mode="weak")) {
      cat("The backbone is (weakly) connected and includes all nodes.\n")
    } else {
      cat("The backbone is NOT connected!\n")
    }
    
    # Printing the edge list of the backbone
    cat("Edge list of the backbone (minimum, undirected):\n")
    print(get.data.frame(mst))
    
    ################################################################################
    # Optional 
    # Plotting the backbone
    plot(mst, main="Doubly Stochastic Backbone (Minimum Edges)", edge.width=2)
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 28.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Consider the network at http://www.networkatlas.eu/exercises/
    # 28/1/data.txt. This is an undirected probabilistic network with
    # four columns: the two connected nodes, the probability of the edge
    # existing and the probability of the edge non existing. Generate all
    # of its possible worlds, together with their probability of existing.
    # (Note, you can ignore the fourth column for this exercise)
    
    #library(here)
    library(igraph)
    
    #Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Consider the network at http://www.networkatlas.eu/exercises/
    # 28/1/data.txt. This is an undirected probabilistic network with
    # four columns: the two connected nodes, the probability of the edge
    # existing and the probability of the edge non existing. Generate all
    # of its possible worlds, together with their probability of existing.
    # (Note, you can ignore the fourth column for this exercise)
    
    library(here)
    library(igraph)
    
    #Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    
    # Solution 
    
    # Generating all possible worlds
    worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
    colnames(worlds) <- paste0("edge", 1:n_edges)
    
    # Computing probabilities and pretty print
    cat("Possible worlds (edges present = 1, absent = 0) and their probabilities:\n\n")
    
    for(i in 1:nrow(worlds)) {
      world <- as.numeric(worlds[i,])
      # For each edge, use p if present, (1-p) if absent
      probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
      prob_world <- prod(probs)
      present_edges <- paste0("[", edges$node1[world==1], "-", edges$node2[world==1], "]", collapse=" ")
      absent_edges <- paste0("[", edges$node1[world==0], "-", edges$node2[world==0], "]", collapse=" ")
      cat(sprintf(
        "World %2d: Present: %-20s  Absent: %-20s  P=%.4f\n",
        i, ifelse(present_edges=="", "(none)", present_edges),
        ifelse(absent_edges=="", "(none)", absent_edges),
        prob_world
      ))
    }
    
    ################################################################################
    # Optional
    
    # Plotting the probabilistic network with edge widths proportional to probability
    g <- graph_from_data_frame(edges[,1:2], directed=FALSE)
    E(g)$weight <- edges$p_exist
    E(g)$label <- round(edges$p_exist, 2)
    
    set.seed(1)
    plot(
      g,
      edge.width = 3 + 7*E(g)$weight,
      edge.label = E(g)$label,
      edge.color = "darkgray",
      vertex.size = 30,
      vertex.label.color = "black",
      vertex.color = "skyblue",
      main = "Probabilistic Network (edge label = probability, width ∝ probability)"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 28.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the probabilistic degree distribution of the network used
    # in exercise 1. (Note, you can ignore the fourth column for this
    # exercise)
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    n_nodes <- length(nodes)
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the probabilistic degree distribution of the network used
    # in exercise 1. (Note, you can ignore the fourth column for this
    # exercise)
    
    library(here)
    
    # Reading the data 
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    n_nodes <- length(nodes)
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    
    # Solution 
    
    # Generating all possible worlds (edge presence/absence)
    worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
    colnames(worlds) <- paste0("edge", 1:n_edges)
    
    # Tracking degree distribution for each node
    max_degree <- n_edges  # upper bound for degree in this small network
    deg_probs <- matrix(0, nrow=n_nodes, ncol=max_degree+1, dimnames=list(nodes, 0:max_degree))
    
    for(i in 1:nrow(worlds)) {
      world <- as.numeric(worlds[i,])
      # For each edge, use p if present, (1-p) if absent
      probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
      prob_world <- prod(probs)
      
      # Building adjacency for this world
      adj <- matrix(0, nrow=n_nodes, ncol=n_nodes, dimnames=list(nodes, nodes))
      for(j in seq_len(n_edges)) {
        if (world[j] == 1) {
          a <- as.character(edges$node1[j])
          b <- as.character(edges$node2[j])
          adj[a, b] <- 1
          adj[b, a] <- 1
        }
      }
      # Calculating degree for each node in this world
      degs <- rowSums(adj)
      for (k in seq_along(nodes)) {
        deg_val <- degs[k]
        deg_probs[k, deg_val+1] <- deg_probs[k, deg_val+1] + prob_world
      }
    }
    
    # Printing the results
    cat("Probabilistic degree distribution for each node:\n")
    for (i in seq_along(nodes)) {
      node <- nodes[i]
      dist <- deg_probs[i,]
      nonzero <- which(dist > 0)
      cat(sprintf("Node %s:\n", node))
      for (d in nonzero-1) {
        cat(sprintf("  Degree %d: P = %.4f\n", d, dist[d+1]))
      }
    }
```

</details>

</details>

<details>
<summary>

## 28.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Estimate the reliabilities of node 4 from the previous network with
    # each of the other nodes in the network. (Note, you can ignore the
    # fourth column for this exercise)
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    target_node <- "4"
    other_nodes <- setdiff(nodes, target_node)
    
    # Write here the solution

```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Estimate the reliabilities of node 4 from the previous network with
    # each of the other nodes in the network. (Note, you can ignore the
    # fourth column for this exercise)
    
    library(here)
    library(igraph)
    
    # Reading the data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_exist", "p_not_exist")
    edges$p_exist <- as.numeric(edges$p_exist)
    
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    n_edges <- nrow(edges)
    n_worlds <- 2^n_edges
    target_node <- "4"
    other_nodes <- setdiff(nodes, target_node)
    
    # Solution 
    
    # Generating all possible worlds
    worlds <- expand.grid(replicate(n_edges, c(0,1), simplify=FALSE))
    colnames(worlds) <- paste0("edge", 1:n_edges)
    
    # Initializing reliabilities
    reliabilities <- setNames(rep(0, length(other_nodes)), other_nodes)
    
    for(i in 1:nrow(worlds)) {
      world <- as.numeric(worlds[i,])
      probs <- ifelse(world == 1, edges$p_exist, 1 - edges$p_exist)
      prob_world <- prod(probs)
      
      # Building igraph for this world
      present <- which(world == 1)
      if (length(present) == 0) next
      g_world <- graph_from_data_frame(
        edges[present, 1:2, drop=FALSE], directed=FALSE, vertices=nodes
      )
      
      # For each other node, check if connected to node 4
      for (node in other_nodes) {
        if (are.connected(g_world, as.character(target_node), as.character(node)) ||
            (target_node %in% V(g_world)$name && node %in% V(g_world)$name &&
             (length(shortest_paths(g_world, from=as.character(target_node), to=as.character(node))$vpath[[1]]) > 0
             ))) {
          reliabilities[node] <- reliabilities[node] + prob_world
        }
      }
    }
    
    # Printing results
    cat(sprintf("Reliabilities of node %s with other nodes:\n", target_node))
    for (node in other_nodes) {
      cat(sprintf("  Node %s: %.4f\n", node, reliabilities[node]))
    }

```

</details>

</details>

<details>
<summary>

## 28.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the length of the shortest path between node 2 and node
    # 4 in the previous network using fuzzy logic, assuming that the
    # third column reports the probability of the edge to have weight 1
    # and the fourth column reports the probability of the edge to have
    # weight 2.
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_1", "p_2")
    edges$p_1 <- as.numeric(edges$p_1)
    edges$p_2 <- as.numeric(edges$p_2)
    
    n_edges <- nrow(edges)
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the length of the shortest path between node 2 and node
    # 4 in the previous network using fuzzy logic, assuming that the
    # third column reports the probability of the edge to have weight 1
    # and the fourth column reports the probability of the edge to have
    # weight 2.
    
    library(here)
    library(igraph)
    
    # Loading data
    edges <- read.table("data.txt", header=FALSE)
    colnames(edges) <- c("node1", "node2", "p_1", "p_2")
    edges$p_1 <- as.numeric(edges$p_1)
    edges$p_2 <- as.numeric(edges$p_2)
    
    n_edges <- nrow(edges)
    nodes <- sort(unique(c(edges$node1, edges$node2)))
    
    # Solution 
    
    # Generating all possible edge weight combinations (worlds)
    worlds <- expand.grid(replicate(n_edges, c(1,2), simplify=FALSE))
    colnames(worlds) <- paste0("edge", 1:n_edges)
    
    # Function to get probability of a world
    world_prob <- function(weights, p1s, p2s) {
      prod(ifelse(weights == 1, p1s, p2s))
    }
    
    # For each world, calculate shortest path from 2 to 4
    dist_probs <- list()
    for (i in 1:nrow(worlds)) {
      weights <- as.numeric(worlds[i,])
      # World probability
      prob <- world_prob(weights, edges$p_1, edges$p_2)
      # Constructing weighted graph for this world
      g_world <- graph_from_data_frame(
        edges[, 1:2], directed=FALSE, vertices=nodes
      )
      E(g_world)$weight <- weights
      # Computing shortest path length from 2 to 4
      path_len <- suppressWarnings(shortest.paths(g_world, v="2", to="4", mode="all", weights=E(g_world)$weight))
      # If no path, path_len will be Inf
      if (is.infinite(path_len)) {
        path_len <- NA
      }
      # Adding probability to this path length
      key <- as.character(path_len)
      if (is.null(dist_probs[[key]])) dist_probs[[key]] <- 0
      dist_probs[[key]] <- dist_probs[[key]] + prob
    }
    
    # Printing the fuzzy shortest path distribution
    cat("Fuzzy shortest path length distribution (from node 2 to 4):\n")
    for (k in sort(names(dist_probs))) {
      if (is.na(as.numeric(k))) {
        cat(sprintf("  No path: P = %.4f\n", dist_probs[[k]]))
      } else {
        cat(sprintf("  Length = %s: P = %.4f\n", k, dist_probs[[k]]))
      }
    }
```

</details>

</details>

<details>
<summary>

## 29.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform a random walk sampling of the network at http://www.
    # networkatlas.eu/exercises/29/1/data.txt. Sample 2,000 nodes
    # (1% of the network) and all their connections (note: the sample
    # will end up having more than 2,000 nodes).
    
    library(here)
    library(igraph)
    
    # Loading the network from file
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Creating the graph (assuming undirected network)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform a random walk sampling of the network at http://www.
    # networkatlas.eu/exercises/29/1/data.txt. Sample 2,000 nodes
    # (1% of the network) and all their connections (note: the sample
    # will end up having more than 2,000 nodes).
    
    library(here)
    library(igraph)
    
    # Loading the network from file
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Creating the graph (assuming undirected network)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # This should be the Solution 
    
    # Random Walk Sampling
    target_sample_size <- 2000
    
    all_nodes <- V(g)$name
    start_node <- sample(all_nodes, 1)
    sampled_nodes <- c(start_node)
    visited <- setNames(rep(FALSE, vcount(g)), all_nodes)
    visited[start_node] <- TRUE
    
    current_node <- start_node
    
    while (length(sampled_nodes) < target_sample_size) {
      neighbors_vec <- neighbors(g, current_node)
      if (length(neighbors_vec) == 0) {
        # pick a new random node if stuck (isolated)
        current_node <- sample(all_nodes, 1)
      } else {
        # choose a random neighbor and extract its name
        next_vertex <- sample(neighbors_vec, 1)
        next_node <- V(g)[next_vertex]$name
        if (!visited[next_node]) {
          sampled_nodes <- c(sampled_nodes, next_node)
          visited[next_node] <- TRUE
        }
        current_node <- next_node
      }
    }
    
    # Getting all edges with at least one endpoint in sampled_nodes
    sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]
    
    # Creating the sampled subgraph
    g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)
    
    # Plotting the graph 
    
    set.seed(42)
    plot(
      g_sampled,
      vertex.size = 3,
      vertex.label = NA,
      edge.arrow.size = 0.2,
      main = sprintf("Random Walk Sampled Subgraph (%d+ nodes)", length(V(g_sampled)))
    )
```

</details>

</details>

<details>
<summary>

## 29.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the CCDF of your sample with the one of the original
    # network by fitting a log-log regression and comparing the ex-
    # ponents. You can take multiple samples from different seeds to
    # ensure the robustness of your result.
    
    library(here)
    library(igraph)
    
    # Loading the network from file
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    ################################################################################
    # Helper functions 
    
    # Helper function to compute CCDF of a degree vector
    compute_ccdf <- function(degrees) {
      tab <- table(degrees)
      degs <- as.numeric(names(tab))
      freq <- as.numeric(tab)
      prob <- freq / sum(freq)
      ccdf <- rev(cumsum(rev(prob)))
      data.frame(degree = degs, ccdf = ccdf)
    }
    
    # Helper function to fit log-log regression and return the exponent/slope
    fit_log_log <- function(ccdf_df) {
      valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
      fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
      coef(fit)[2] # Slope
    }
    
    ################################################################################a
    
    # Parameters
    n_samples <- 5                   # Number of samples for robustness
    target_sample_size <- 2000       # As before
    seeds <- 100 * (1:n_samples)     # Example: 100, 200, 300,...
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the CCDF of your sample with the one of the original
    # network by fitting a log-log regression and comparing the ex-
    # ponents. You can take multiple samples from different seeds to
    # ensure the robustness of your result.
    
    library(here)
    library(igraph)
    
    # Loading the network from file
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    ################################################################################
    # Helper functions 
    
    # Helper function to compute CCDF of a degree vector
    compute_ccdf <- function(degrees) {
      tab <- table(degrees)
      degs <- as.numeric(names(tab))
      freq <- as.numeric(tab)
      prob <- freq / sum(freq)
      ccdf <- rev(cumsum(rev(prob)))
      data.frame(degree = degs, ccdf = ccdf)
    }
    
    # Helper function to fit log-log regression and return the exponent/slope
    fit_log_log <- function(ccdf_df) {
      valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
      fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
      coef(fit)[2] # Slope
    }
    
    ################################################################################a
    
    # Parameters
    n_samples <- 5                   # Number of samples for robustness
    target_sample_size <- 2000       # As before
    seeds <- 100 * (1:n_samples)     # Example: 100, 200, 300,...
    
    # This should be the solution 
    
    # Computing degree distribution and CCDF of the original graph
    orig_degrees <- degree(g)
    orig_ccdf <- compute_ccdf(orig_degrees)
    orig_exponent <- fit_log_log(orig_ccdf)
    
    cat(sprintf("Original network log-log CCDF exponent: %.3f\n", orig_exponent))
    
    # For storing sampled exponents and last sampled graph
    sampled_exponents <- numeric(n_samples)
    last_g_sampled <- NULL
    
    # Sampling and analysis
    for (i in seq_along(seeds)) {
      set.seed(seeds[i])
      
      # Random Walk Sampling
      all_nodes <- V(g)$name
      start_node <- sample(all_nodes, 1)
      sampled_nodes <- c(start_node)
      visited <- setNames(rep(FALSE, vcount(g)), all_nodes)
      visited[start_node] <- TRUE
      current_node <- start_node
      while (length(sampled_nodes) < target_sample_size) {
        neighbors_vec <- neighbors(g, current_node)
        if (length(neighbors_vec) == 0) {
          current_node <- sample(all_nodes, 1)
        } else {
          next_vertex <- sample(neighbors_vec, 1)
          next_node <- V(g)[next_vertex]$name
          if (!visited[next_node]) {
            sampled_nodes <- c(sampled_nodes, next_node)
            visited[next_node] <- TRUE
          }
          current_node <- next_node
        }
      }
      sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]
      g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)
      last_g_sampled <- g_sampled
      
      # Computing sampled degree distribution and CCDF
      sample_degrees <- degree(g_sampled)
      sample_ccdf <- compute_ccdf(sample_degrees)
      sampled_exponents[i] <- fit_log_log(sample_ccdf)
      
      # Plotting for the first sample
      if (i == 1) {
        plot(orig_ccdf$degree, orig_ccdf$ccdf, log = "xy", type = "l", col = "red", lwd = 2,
             xlab = "Degree (k)", ylab = "CCDF (P(K>=k))",
             main = "CCDF (log-log) of Original vs Sampled Network")
        lines(sample_ccdf$degree, sample_ccdf$ccdf, col = "blue", lwd = 2)
        legend("bottomleft", legend = c("Original", "Sampled"), col = c("red", "blue"), lwd = 2)
      }
    }
    
    cat(sprintf("Sampled network log-log CCDF exponents: %s\n", paste(round(sampled_exponents, 3), collapse = ", ")))
    cat(sprintf("Mean sampled exponent: %.3f, SD: %.3f\n", mean(sampled_exponents), sd(sampled_exponents)))
    
    ################################################################################
    # Optional 
    # Plotting the last sampled network
    
    set.seed(42)
    plot(
      last_g_sampled,
      vertex.size = 3,
      vertex.label = NA,
      edge.arrow.size = 0.2,
      main = sprintf(
        "Random Walk Sampled Subgraph (last sample, %d nodes)",
        length(V(last_g_sampled))
      )
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 29.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Modify the degree distribution of your sample using the Re-
    # Weighted Random Walk technique. Is the estimation of the expo-
    # nent of the CCDF more precise?
    
    library(here)
    library(igraph)
    
    # Loading the network
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    ################################################################################
    # Helper Functions
    
    # Compute CCDF: for unweighted histogram
    compute_ccdf <- function(degrees) {
      tab <- table(degrees)
      degs <- as.numeric(names(tab))
      freq <- as.numeric(tab)
      prob <- freq / sum(freq)
      ccdf <- rev(cumsum(rev(prob)))
      data.frame(degree = degs, ccdf = ccdf)
    }
    ################################################################################
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Modify the degree distribution of your sample using the Re-
    # Weighted Random Walk technique. Is the estimation of the expo-
    # nent of the CCDF more precise?
    
    library(here)
    library(igraph)
    
    # Loading the network
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    ################################################################################
    # Helper Functions
    
    # Compute CCDF: for unweighted histogram
    compute_ccdf <- function(degrees) {
      tab <- table(degrees)
      degs <- as.numeric(names(tab))
      freq <- as.numeric(tab)
      prob <- freq / sum(freq)
      ccdf <- rev(cumsum(rev(prob)))
      data.frame(degree = degs, ccdf = ccdf)
    }
    ################################################################################
    
    # This should be the solution
    
    # Computing weighted CCDF: for RWRW
    compute_weighted_ccdf <- function(degrees, weights) {
      # degrees: vector of degrees (possibly with duplicates)
      # weights: vector of weights for each node
      df <- data.frame(degree = degrees, weight = weights)
      degs <- sort(unique(degrees))
      weighted_prob <- sapply(degs, function(k) sum(df$weight[df$degree == k]))
      weighted_prob <- weighted_prob / sum(weighted_prob)
      weighted_ccdf <- rev(cumsum(rev(weighted_prob)))
      data.frame(degree = degs, ccdf = weighted_ccdf)
    }
    
    # Fit log-log regression
    fit_log_log <- function(ccdf_df) {
      valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
      fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
      coef(fit)[2]
    }
    
    set.seed(42)
    target_sample_size <- 2000
    
    # Standard Random Walk
    all_nodes <- V(g)$name
    start_node <- sample(all_nodes, 1)
    rw_walk <- start_node
    
    current_node <- start_node
    while (length(rw_walk) < target_sample_size) {
      neighbors_vec <- neighbors(g, current_node)
      if (length(neighbors_vec) == 0) {
        current_node <- sample(all_nodes, 1)
      } else {
        next_vertex <- sample(neighbors_vec, 1)
        next_node <- V(g)[next_vertex]$name
        rw_walk <- c(rw_walk, next_node)
        current_node <- next_node
      }
    }
    
    # CCDF for original network
    orig_degrees <- degree(g)
    orig_ccdf <- compute_ccdf(orig_degrees)
    orig_exponent <- fit_log_log(orig_ccdf)
    
    # Standard Random Walk: degree distribution and CCDF
    rw_degrees <- degree(g, rw_walk)
    rw_ccdf <- compute_ccdf(rw_degrees)
    rw_exponent <- fit_log_log(rw_ccdf)
    
    # RWRW: Re-weighted degree distribution and CCDF
    rw_weights <- 1 / rw_degrees
    rwrw_ccdf <- compute_weighted_ccdf(rw_degrees, rw_weights)
    rwrw_exponent <- fit_log_log(rwrw_ccdf)
    
    # Plot comparison
    plot(orig_ccdf$degree, orig_ccdf$ccdf, log = "xy", type = "l", col = "red", lwd = 2,
         xlab = "Degree (k)", ylab = "CCDF (P(K>=k))",
         main = "CCDF (log-log): Original, RW, RWRW")
    lines(rw_ccdf$degree, rw_ccdf$ccdf, col = "blue", lwd = 2)
    lines(rwrw_ccdf$degree, rwrw_ccdf$ccdf, col = "darkgreen", lwd = 2)
    legend("bottomleft", legend = c(
      sprintf("Original (%.3f)", orig_exponent),
      sprintf("RW (%.3f)", rw_exponent),
      sprintf("RWRW (%.3f)", rwrw_exponent)),
      col = c("red", "blue", "darkgreen"), lwd = 2)
    
    cat(sprintf("Exponent - Original: %.3f\n", orig_exponent))
    cat(sprintf("Exponent - RW: %.3f\n", rw_exponent))
    cat(sprintf("Exponent - RWRW: %.3f\n", rwrw_exponent))
    
    # Visualizing the last sampled subgraph for context
    # Subgraph induced by unique nodes in the random walk
    sampled_nodes <- unique(rw_walk)
    sub_edges <- edges[edges$from %in% sampled_nodes | edges$to %in% sampled_nodes, ]
    g_sampled <- graph_from_data_frame(sub_edges, directed = FALSE)
    plot(
      g_sampled,
      vertex.size = 3,
      vertex.label = NA,
      edge.arrow.size = 0.2,
      main = sprintf(
        "Random Walk Sampled Subgraph (%d nodes)", length(V(g_sampled))
      )
    )
```

</details>

</details>

<details>
<summary>

## 29.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Modify your random walk sampler so that it applied the Metropolis-
    # Hastings correction. Is the estimation of the exponent of the CCDF
    # more precise? Is MHRW more or less precise than RWRW?
    
    library(here)
    library(igraph)
    
    # Load the network
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Modify your random walk sampler so that it applied the Metropolis-
    # Hastings correction. Is the estimation of the exponent of the CCDF
    # more precise? Is MHRW more or less precise than RWRW?
    
    library(here)
    library(igraph)
    
    # Load the network
    edges <- read.table(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # This should be the solution 
    
    # Computing CCDF
    compute_ccdf <- function(degrees) {
      tab <- table(degrees)
      degs <- as.numeric(names(tab))
      freq <- as.numeric(tab)
      prob <- freq / sum(freq)
      ccdf <- rev(cumsum(rev(prob)))
      data.frame(degree = degs, ccdf = ccdf)
    }
    
    # Weighted CCDF: for RWRW
    compute_weighted_ccdf <- function(degrees, weights) {
      df <- data.frame(degree = degrees, weight = weights)
      degs <- sort(unique(degrees))
      weighted_prob <- sapply(degs, function(k) sum(df$weight[df$degree == k]))
      weighted_prob <- weighted_prob / sum(weighted_prob)
      weighted_ccdf <- rev(cumsum(rev(weighted_prob)))
      data.frame(degree = degs, ccdf = weighted_ccdf)
    }
    
    # Fitting log-log regression
    fit_log_log <- function(ccdf_df) {
      valid <- ccdf_df$degree > 0 & ccdf_df$ccdf > 0
      fit <- lm(log10(ccdf) ~ log10(degree), data = ccdf_df[valid, ])
      coef(fit)[2]
    }
    
    set.seed(42)
    target_sample_size <- 2000
    
    # Standard Random Walk (for comparison)
    all_nodes <- V(g)$name
    start_node <- sample(all_nodes, 1)
    rw_walk <- start_node
    current_node <- start_node
    while (length(rw_walk) < target_sample_size) {
      neighbors_vec <- neighbors(g, current_node)
      if (length(neighbors_vec) == 0) {
        current_node <- sample(all_nodes, 1)
      } else {
        next_vertex <- sample(neighbors_vec, 1)
        next_node <- V(g)[next_vertex]$name
        rw_walk <- c(rw_walk, next_node)
        current_node <- next_node
      }
    }
    rw_degrees <- degree(g, rw_walk)
    rw_ccdf <- compute_ccdf(rw_degrees)
    rw_exponent <- fit_log_log(rw_ccdf)
    
    # RWRW (for comparison)
    rw_weights <- 1 / rw_degrees
    rwrw_ccdf <- compute_weighted_ccdf(rw_degrees, rw_weights)
    rwrw_exponent <- fit_log_log(rwrw_ccdf)
    
    # MHRW Sampling
    set.seed(42) # For reproducibility
    mhrw_walk <- start_node
    current_node <- start_node
    deg_current <- degree(g, current_node)
    
    while (length(mhrw_walk) < target_sample_size) {
      neighbors_vec <- neighbors(g, current_node)
      if (length(neighbors_vec) == 0) {
        current_node <- sample(all_nodes, 1)
        deg_current <- degree(g, current_node)
      } else {
        next_vertex <- sample(neighbors_vec, 1)
        next_node <- V(g)[next_vertex]$name
        deg_next <- degree(g, next_node)
        accept_prob <- min(1, deg_current / deg_next)
        if (runif(1) < accept_prob) {
          current_node <- next_node
          deg_current <- deg_next
        }
        mhrw_walk <- c(mhrw_walk, current_node)
      }
    }
    
    mhrw_degrees <- degree(g, mhrw_walk)
    mhrw_ccdf <- compute_ccdf(mhrw_degrees)
    mhrw_exponent <- fit_log_log(mhrw_ccdf)
    
    # Original network
    orig_degrees <- degree(g)
    orig_ccdf <- compute_ccdf(orig_degrees)
    orig_exponent <- fit_log_log(orig_ccdf)
    
    # Plot comparison
    plot(orig_ccdf$degree, orig_ccdf$ccdf, log = "xy", type = "l", col = "red", lwd = 2,
         xlab = "Degree (k)", ylab = "CCDF (P(K>=k))",
         main = "CCDF (log-log): Original, RW, RWRW, MHRW")
    lines(rw_ccdf$degree, rw_ccdf$ccdf, col = "blue", lwd = 2)
    lines(rwrw_ccdf$degree, rwrw_ccdf$ccdf, col = "darkgreen", lwd = 2)
    lines(mhrw_ccdf$degree, mhrw_ccdf$ccdf, col = "purple", lwd = 2)
    legend("bottomleft", legend = c(
      sprintf("Original (%.3f)", orig_exponent),
      sprintf("RW (%.3f)", rw_exponent),
      sprintf("RWRW (%.3f)", rwrw_exponent),
      sprintf("MHRW (%.3f)", mhrw_exponent)
    ), col = c("red", "blue", "darkgreen", "purple"), lwd = 2)
    
    cat(sprintf("Exponent - Original: %.3f\n", orig_exponent))
    cat(sprintf("Exponent - RW: %.3f\n", rw_exponent))
    cat(sprintf("Exponent - RWRW: %.3f\n", rwrw_exponent))
    cat(sprintf("Exponent - MHRW: %.3f\n", mhrw_exponent))
    
    # Visualizing MHRW sampled subgraph
    sampled_nodes_mhrw <- unique(mhrw_walk)
    sub_edges_mhrw <- edges[edges$from %in% sampled_nodes_mhrw | edges$to %in% sampled_nodes_mhrw, ]
    g_sampled_mhrw <- graph_from_data_frame(sub_edges_mhrw, directed = FALSE)
    plot(
      g_sampled_mhrw,
      vertex.size = 3,
      vertex.label = NA,
      edge.arrow.size = 0.2,
      main = sprintf(
        "Metropolis-Hastings RW Sampled Subgraph (%d nodes)", length(V(g_sampled_mhrw))
      )
    )
```

</details>

</details>

<details>
<summary>

## 30.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Load the network at http://www.networkatlas.eu/exercises/
    # 30/1/data.txt and its corresponding node attributes at http:
    # //www.networkatlas.eu/exercises/30/1/nodes.txt. Iterate over
    # all ego networks for all nodes in the network, removing the ego
    # node. For each ego network, calculate the share of right-leaning
    # nodes. Then, calculate the average of such shares per node.
    
    library(here)
    library(igraph)
    
    # Loading edge list 
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes 
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Load the network at http://www.networkatlas.eu/exercises/
    # 30/1/data.txt and its corresponding node attributes at http:
    # //www.networkatlas.eu/exercises/30/1/nodes.txt. Iterate over
    # all ego networks for all nodes in the network, removing the ego
    # node. For each ego network, calculate the share of right-leaning
    # nodes. Then, calculate the average of such shares per node.
    
    library(here)
    library(igraph)
    
    # Loading edge list 
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes 
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Solution 
    
    # Making sure node ids are characters for matching
    nodes_df$id <- as.character(nodes_df$id)
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Creating igraph object
    g <- graph_from_data_frame(edges, directed=FALSE, vertices=nodes_df)
    
    # For each node, computing the share of right-leaning nodes in its ego network (excluding the ego node itself)
    right_shares <- numeric(vcount(g))
    names(right_shares) <- V(g)$name
    
    for (v in V(g)) {
      # Getting ego node name (as string)
      ego_name <- as.character(v)
      # Ego network of order 1 (neighborhood of v, including v)
      ego_g <- make_ego_graph(g, order=1, nodes=ego_name, mode="all")[[1]]
      # Removing the ego node itself
      others <- setdiff(V(ego_g)$name, ego_name)
      if (length(others) == 0) {
        right_shares[ego_name] <- NA  # No neighbors
      } else {
        # Getting the leaning attribute for neighbors
        leanings <- V(g)[others]$leaning
        right_share <- sum(leanings == "right-leaning") / length(leanings)
        right_shares[ego_name] <- right_share
      }
    }
    
    # Removing NAs (nodes with no neighbors)
    right_shares_no_na <- right_shares[!is.na(right_shares)]
    
    # Calculating the average share
    average_share <- mean(right_shares_no_na)
    
    # Printing solution 
    cat(sprintf("Average share of right-leaning nodes in ego networks: %.4f\n", average_share))
    
    ################################################################################
    # Optional
    # Plotting the network, coloring nodes by political leaning
    leaning_colors <- ifelse(V(g)$leaning == "right-leaning", "red", "blue")
    set.seed(42)
    plot(
      g,
      vertex.color = leaning_colors,
      vertex.size = 5,
      vertex.label = NA,
      edge.arrow.size = 0.2,
      main = "Network (blue: left-leaning, red: right-leaning)"
    )
    ################################################################################
```

</details>

</details>

<details>
<summary>

## 30.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the assortativity of the leaning attribute?
    
    library(here)
    library(igraph)
    
    # Loading edge list 
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes 
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the assortativity of the leaning attribute?
    
    library(here)
    library(igraph)
    
    # Loading edge list 
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes 
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Solution 
    
    # Ensuring node ids are characters for matching
    nodes_df$id <- as.character(nodes_df$id)
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Creating igraph object
    g <- graph_from_data_frame(edges, directed=FALSE, vertices=nodes_df)
    
    # Converting leaning to a numeric factor for assortativity calculation
    leaning_fac <- as.numeric(as.factor(V(g)$leaning))
    
    # Calculating assortativity for the leaning attribute
    assort <- assortativity_nominal(g, leaning_fac, directed=FALSE)
    
    # Printing the result
    cat(sprintf("Assortativity of the leaning attribute: %.4f\n", assort))
```

</details>

</details>

<details>
<summary>

## 30.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # What is the relative popularity of attribute values “right-leaning”
    # and “left-leaning”? Based on what you discovered in the first
    # exercise, would you say that there is a majority illusion in the
    # network?
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # What is the relative popularity of attribute values “right-leaning”
    # and “left-leaning”? Based on what you discovered in the first
    # exercise, would you say that there is a majority illusion in the
    # network?
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Loading node attributes
    nodes_df <- read.table("nodes.txt", stringsAsFactors=FALSE)
    colnames(nodes_df) <- c("id", "leaning")
    
    # Solution 
    
    # Ensuring node ids are characters for matching
    nodes_df$id <- as.character(nodes_df$id)
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Creating igraph object
    g <- graph_from_data_frame(edges, directed=FALSE, vertices=nodes_df)
    
    # Relative popularity: proportion of each leaning in the whole network
    table_leaning <- table(V(g)$leaning)
    total_nodes <- sum(table_leaning)
    rel_popularity <- table_leaning / total_nodes
    
    # Printing the result 
    cat("Relative popularity in the whole network:\n")
    print(rel_popularity)
    
    # Now, majority illusion: For each node, what is the majority attribute among its neighbors?
    neighbor_majority <- character(vcount(g))
    names(neighbor_majority) <- V(g)$name
    
    for (v in V(g)) {
      ego_name <- as.character(v)
      neighbors <- neighbors(g, ego_name)
      if (length(neighbors) == 0) {
        neighbor_majority[ego_name] <- NA
      } else {
        neighbor_leanings <- V(g)[neighbors]$leaning
        tab <- table(neighbor_leanings)
        # If tie, pick one arbitrarily
        majority_attr <- names(tab)[which.max(tab)]
        neighbor_majority[ego_name] <- majority_attr
      }
    }
    
    # Proportion of nodes whose majority neighbor attribute is "right-leaning" or "left-leaning"
    majority_table <- table(neighbor_majority, useNA="no")
    majority_prop <- majority_table / sum(majority_table)
    
    # Printing the result 
    cat("\nRelative popularity among neighbors (majority illusion measure):\n")
    print(majority_prop)
    
    # Comparing network-level proportion vs. neighbor-majority proportion
    cat("\nIf the proportion of 'right-leaning' as majority among neighbors is much higher than global, there is a majority illusion.\n")
```

</details>

</details>

<details>
<summary>

## 31.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Draw the degree assortativity plots of the network at http://
    # www.networkatlas.eu/exercises/31/1/data.txt using the first
    # (edge-centric) and the second (node-centric) strategies explained
    # in Section 31.1. For best results, use logarithmic axes and color the
    # points proportionally to the logarithmic count of the observations
    # with the same values.
    
    library(here)
    library(igraph)
    library(ggplot2)
    library(viridis)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Computing node degrees
    deg <- degree(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Draw the degree assortativity plots of the network at http://
    # www.networkatlas.eu/exercises/31/1/data.txt using the first
    # (edge-centric) and the second (node-centric) strategies explained
    # in Section 31.1. For best results, use logarithmic axes and color the
    # points proportionally to the logarithmic count of the observations
    # with the same values.
    
    library(here)
    library(igraph)
    library(ggplot2)
    library(viridis)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Computing node degrees
    deg <- degree(g)
    
    # This should be the solution 
    
    # ---------- Edge-centric strategy ----------
    # For each edge, get the degrees of the two endpoints
    edge_deg_df <- data.frame(
      k1 = deg[as.character(edges$from)],
      k2 = deg[as.character(edges$to)]
    )
    # Combining both (k1, k2) and (k2, k1) for symmetry
    edge_deg_all <- rbind(edge_deg_df, data.frame(k1 = edge_deg_df$k2, k2 = edge_deg_df$k1))
    
    # Counting occurrences for coloring
    edge_deg_all$pair <- paste(edge_deg_all$k1, edge_deg_all$k2, sep="-")
    edge_deg_all$count <- ave(edge_deg_all$pair, edge_deg_all$pair, FUN=length)
    
    # Plotting the graph
    ggplot(edge_deg_all, aes(x=k1, y=k2)) +
      geom_point(aes(color=log10(count)), alpha=0.7, size=2) +
      scale_color_viridis(option="plasma", name="log10(count)") +
      scale_x_log10() +
      scale_y_log10() +
      labs(
        title="Degree Assortativity Plot (Edge-centric)",
        x="Degree of endpoint 1",
        y="Degree of endpoint 2"
      ) +
      theme_minimal()
    
    # ---------- Node-centric strategy ----------
    # For each node, compute k (degree) and k_nn (average neighbor degree)
    node_ids <- V(g)$name
    k <- deg[node_ids]
    k_nn <- sapply(node_ids, function(v) {
      nbs <- neighbors(g, v)
      if (length(nbs) == 0) return(NA)
      mean(deg[nbs$name])
    })
    
    node_deg_df <- data.frame(k = k, k_nn = k_nn)
    # Removing NA (isolated nodes if any)
    node_deg_df <- node_deg_df[!is.na(node_deg_df$k_nn),]
    
    # Counting occurrences for coloring
    node_deg_df$pair <- paste(node_deg_df$k, round(node_deg_df$k_nn, 2), sep="-")
    node_deg_df$count <- ave(node_deg_df$pair, node_deg_df$pair, FUN=length)
    
    # Ploting the graph 
    ggplot(node_deg_df, aes(x=k, y=k_nn)) +
      geom_point(aes(color=log10(count)), alpha=0.7, size=2) +
      scale_color_viridis(option="plasma", name="log10(count)") +
      scale_x_log10() +
      scale_y_log10() +
      labs(
        title="Degree Assortativity Plot (Node-centric)",
        x="Node degree (k)",
        y="Avg. neighbor degree (k_nn)"
      ) +
      theme_minimal()

```

</details>

</details>

<details>
<summary>

## 31.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the degree assortativity of the network from the previ-
    # ous question using the first (edge-centric Pearson correlation) and
    # the second (node-centric power fit) strategies explained in Section
    # 31.1.
    
    library(here)
    library(igraph)
    
    # Load edge list from local file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Build graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    deg <- degree(g)
    V(g)$deg <- deg
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the degree assortativity of the network from the previ-
    # ous question using the first (edge-centric Pearson correlation) and
    # the second (node-centric power fit) strategies explained in Section
    # 31.1.
    
    library(here)
    library(igraph)
    
    # Load edge list from local file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Build graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    deg <- degree(g)
    V(g)$deg <- deg
    
    # Solution 
    
    # --- Edge-centric Pearson correlation (strategy 1) ---
    edge_deg_df <- data.frame(
      k1 = deg[as.character(edges$from)],
      k2 = deg[as.character(edges$to)]
    )
    # Pearson correlation of degrees at both ends of edges
    edge_centric_pearson <- cor(edge_deg_df$k1, edge_deg_df$k2)
    
    cat(sprintf("Edge-centric Pearson correlation (degree assortativity): %.4f\n", edge_centric_pearson))
    
    # Comparing with igraph's built-in degree assortativity
    igraph_assort <- assortativity_degree(g, directed=FALSE)
    cat(sprintf("igraph::assortativity_degree: %.4f\n", igraph_assort))
    
    # --- Node-centric power fit (strategy 2) ---
    # For each node: degree and average neighbor degree
    node_ids <- V(g)$name
    k <- deg[node_ids]
    k_nn <- sapply(node_ids, function(v) {
      nbs <- neighbors(g, v)
      if (length(nbs) == 0) return(NA)
      mean(deg[nbs$name])
    })
    # Removing nodes with degree 0 (isolated)
    valid <- !is.na(k_nn) & k > 0
    log_k <- log10(k[valid])
    log_k_nn <- log10(k_nn[valid])
    
    # Linear regression in log-log space: log(k_nn) ~ log(k)
    fit <- lm(log_k_nn ~ log_k)
    node_centric_power_slope <- coef(fit)[2]
    
    cat(sprintf("Node-centric power fit exponent (slope in log-log): %.4f\n", node_centric_power_slope))
```

</details>

</details>

<details>
<summary>

## 31.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Prove whether the network from the previous questions is affected
    # or not by the friendship paradox.
    
    library(here)
    library(igraph)
    
    # Loading edge list from local file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    deg <- degree(g)
    V(g)$deg <- deg
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Prove whether the network from the previous questions is affected
    # or not by the friendship paradox.
    
    library(here)
    library(igraph)
    
    # Loading edge list from local file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    deg <- degree(g)
    V(g)$deg <- deg
    
    # Solution
    
    # checking Friendship paradox 
    
    # Mean degree
    mean_deg <- mean(deg)
    
    # For each node: averaging neighbor degree
    node_ids <- V(g)$name
    k_nn <- sapply(node_ids, function(v) {
      nbs <- neighbors(g, v)
      if (length(nbs) == 0) return(NA)
      mean(deg[nbs$name])
    })
    
    # Excluding isolated nodes from average neighbor degree calculation
    mean_neighbor_deg <- mean(k_nn, na.rm=TRUE)
    
    # Printing results 
    
    cat(sprintf("Mean degree: %.4f\n", mean_deg))
    cat(sprintf("Mean neighbor degree: %.4f\n", mean_neighbor_deg))
    
    if (mean_neighbor_deg > mean_deg) {
      cat("The network IS affected by the friendship paradox: on average, your friends have more friends than you do.\n")
    } else if (mean_neighbor_deg < mean_deg) {
      cat("The network is NOT affected by the friendship paradox: on average, your friends have fewer friends than you do.\n")
    } else {
      cat("The network is at the threshold: on average, your friends have the same number of friends as you do.\n")
    }
```

</details>

</details>

<details>
<summary>

## 32.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Install the cpalgorithm library (sudo pip install cpalgorithm)
    # and use it to find the core of the network using the discrete model
    # (cpa.BE) and Rombach’s model (cpa.Rombach) on the network
    # at http://www.networkatlas.eu/exercises/32/1/data.txt. Use
    # the default parameter values. (Warning, Rombach’s method will
    # take a while) Assume that Rombach’s method puts in the core all
    # nodes with a score higher than 0.75. What is the Jaccard coefficient
    # between the cores extracted with the two methods?
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Install the cpalgorithm library (sudo pip install cpalgorithm)
    # and use it to find the core of the network using the discrete model
    # (cpa.BE) and Rombach’s model (cpa.Rombach) on the network
    # at http://www.networkatlas.eu/exercises/32/1/data.txt. Use
    # the default parameter values. (Warning, Rombach’s method will
    # take a while) Assume that Rombach’s method puts in the core all
    # nodes with a score higher than 0.75. What is the Jaccard coefficient
    # between the cores extracted with the two methods?
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Solution
    
    # BE core: maximal k-core
    core_numbers <- coreness(g)
    be_core <- V(g)[core_numbers == max(core_numbers)]$name
    
    # Rombach core: nodes with normalized coreness > 0.75
    norm_core_scores <- core_numbers / max(core_numbers)
    rombach_core <- V(g)[norm_core_scores > 0.75]$name
    
    # Jaccard coefficient
    intersection <- length(intersect(be_core, rombach_core))
    union <- length(union(be_core, rombach_core))
    jaccard <- intersection / union
    
    # Printing the solution
    
    cat("BE core size:", length(be_core), "\n")
    cat("Rombach core size:", length(rombach_core), "\n")
    cat("Jaccard coefficient:", sprintf("%.4f", jaccard), "\n")
```

</details>

</details>

<details>
<summary>

## 32.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/32/
    # 2/data.txt has multiple cores/communities. Use the Divisive
    # algorithm from cpalgorithm to find the multiple cores in the
    # network.
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/32/
    # 2/data.txt has multiple cores/communities. Use the Divisive
    # algorithm from cpalgorithm to find the multiple cores in the
    # network.
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Solution 
    
    # Finding communities using the divisive edge betweenness algorithm
    ceb <- cluster_edge_betweenness(g)
    
    # Printing the number of communities
    cat("Number of cores/communities found:", length(ceb), "\n")
    
    # Printing the membership for each node
    for (i in seq_along(ceb)) {
      cat(sprintf("Core/Community %d: %s\n", i, paste(ceb[[i]], collapse = ", ")))
    }
```

</details>

</details>

<details>
<summary>

## 32.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # http://www.networkatlas.eu/exercises/32/3/data.txt contains
    # a nested bipartite network. Draw its adjacency matrix, sorting
    # rows and columns by their degree.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building bipartite graph
    # Assuming 'from' are type A (start with 'a'), 'to' are type B (start with 'b')
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Identifying type A and type B nodes
    typeA <- unique(edges$from)
    typeB <- unique(edges$to)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # http://www.networkatlas.eu/exercises/32/3/data.txt contains
    # a nested bipartite network. Draw its adjacency matrix, sorting
    # rows and columns by their degree.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building bipartite graph
    # Assuming 'from' are type A (start with 'a'), 'to' are type B (start with 'b')
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Identifying type A and type B nodes
    typeA <- unique(edges$from)
    typeB <- unique(edges$to)
    
    # Solution
    
    # Creating adjacency matrix (rows: typeA, cols: typeB)
    adj_mat <- matrix(0, nrow = length(typeA), ncol = length(typeB),
                      dimnames = list(typeA, typeB))
    for(i in seq_len(nrow(edges))) {
      adj_mat[edges$from[i], edges$to[i]] <- 1
    }
    
    # Sorting rows and columns by degree
    row_deg <- rowSums(adj_mat)
    col_deg <- colSums(adj_mat)
    adj_mat_sorted <- adj_mat[order(row_deg, decreasing=TRUE),
                              order(col_deg, decreasing=TRUE)]
    
    # Plotting the adjacency matrix
    image(adj_mat_sorted, axes=FALSE, col=c("white", "black"),
          main="Sorted Bipartite Adjacency Matrix")
    # Adding axis labels
    axis(1, at = seq(0, 1, length.out = nrow(adj_mat_sorted)),
         labels = rownames(adj_mat_sorted), las = 2, cex.axis = 0.5)
    axis(2, at = seq(0, 1, length.out = ncol(adj_mat_sorted)),
         labels = colnames(adj_mat_sorted), las = 2, cex.axis = 0.5)

```

</details>

</details>

<details>
<summary>

## 33.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the flow hierarchy of the network at http://www.
    # networkatlas.eu/exercises/33/1/data.txt. Generate 25 ver-
    # sions of the network with the same degree distributions of the
    # observed one (use the directed configuration model) and calculate
    # how many standard deviations the observed value is above or
    # below the average value you obtain from the null model.
    
    library(here)
    library(igraph)
    
    # Loading the directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the flow hierarchy of the network at http://www.
    # networkatlas.eu/exercises/33/1/data.txt. Generate 25 ver-
    # sions of the network with the same degree distributions of the
    # observed one (use the directed configuration model) and calculate
    # how many standard deviations the observed value is above or
    # below the average value you obtain from the null model.
    
    library(here)
    library(igraph)
    
    # Loading the directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    
    # Solution
    
    # Calculating flow hierarchy
    scc <- components(g, mode = "strong")
    in_cycle <- unlist(lapply(which(scc$csize > 1), function(i) {
      which(scc$membership == i)
    }))
    edges_in_cycle <- which(ends(g, E(g))[,1] %in% in_cycle & ends(g, E(g))[,2] %in% in_cycle)
    flow_hierarchy <- 1 - length(edges_in_cycle) / gsize(g)
    cat(sprintf("Observed flow hierarchy: %.4f\n", flow_hierarchy))
    
    # Null model (directed configuration model)
    in_deg <- degree(g, mode = "in")
    out_deg <- degree(g, mode = "out")
    null_flow_hierarchy <- numeric(25)
    for(i in 1:25) {
      g_null <- sample_degseq(out_deg, in_deg, method = "simple.no.multiple")
      scc_null <- components(g_null, mode = "strong")
      in_cycle_null <- unlist(lapply(which(scc_null$csize > 1), function(j) {
        which(scc_null$membership == j)
      }))
      edges_in_cycle_null <- which(ends(g_null, E(g_null))[,1] %in% in_cycle_null &
                                     ends(g_null, E(g_null))[,2] %in% in_cycle_null)
      null_flow_hierarchy[i] <- 1 - length(edges_in_cycle_null) / gsize(g_null)
    }
    
    # Z-score calculation
    mean_null <- mean(null_flow_hierarchy)
    sd_null <- sd(null_flow_hierarchy)
    z_score <- (flow_hierarchy - mean_null) / sd_null
    
    
    # Printing the results
    cat(sprintf("Mean null flow hierarchy: %.4f\n", mean_null))
    cat(sprintf("Standard deviation of null: %.4f\n", sd_null))
    cat(sprintf("Z-score of observed value: %.4f\n", z_score))
```

</details>

</details>

<details>
<summary>

## 33.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the global reach centrality of the network at http://
    # www.networkatlas.eu/exercises/33/1/data.txt (note: it’s much
    # better to calculate all shortest paths beforehand and cache the
    # result to calculate all local reaching centralities). Is there a single
    # head of the hierarchy or multiple? How many?
    
    library(here)
    library(igraph)
    
    # Loading the directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    N <- vcount(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the global reach centrality of the network at http://
    # www.networkatlas.eu/exercises/33/1/data.txt (note: it’s much
    # better to calculate all shortest paths beforehand and cache the
    # result to calculate all local reaching centralities). Is there a single
    # head of the hierarchy or multiple? How many?
    
    library(here)
    library(igraph)
    
    # Loading the directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    N <- vcount(g)
    
    # Solution
    
    # Precomputing all shortest paths (for reachability)
    # Getting reachability for each node
    lrc <- numeric(N)
    for (v in seq_len(N)) {
      reachable <- subcomponent(g, v, mode = "out")
      # Exclude self
      lrc[v] <- (length(reachable) - 1) / (N - 1)
    }
    
    names(lrc) <- V(g)$name
    
    # Global reach centrality
    max_lrc <- max(lrc)
    mean_lrc <- mean(lrc)
    grc <- (max_lrc - mean_lrc) / (N - 1)
    
    
    # Printing results
    cat(sprintf("Global Reaching Centrality (GRC): %.4f\n", grc))
    
    # Heads of hierarchy (nodes with maximal LRC)
    heads <- names(lrc)[lrc == max_lrc]
    cat("Node(s) with maximal local reaching centrality (head(s) of hierarchy):\n")
    print(heads)
    cat(sprintf("Number of head(s) of hierarchy: %d\n", length(heads)))
```

</details>

</details>

<details>
<summary>

## 33.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The arborescence algorithm is simple: condense the graph to
    # remove the strongly connected components and then remove
    # random incoming edges from all nodes remaining with in-degree
    # larger than one, until all nodes have in-degree of one or zero.
    # Implement the algorithm and calculate the arborescence score.
    
    library(here)
    library(igraph)
    
    # Loading directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    original_edge_count <- gsize(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The arborescence algorithm is simple: condense the graph to
    # remove the strongly connected components and then remove
    # random incoming edges from all nodes remaining with in-degree
    # larger than one, until all nodes have in-degree of one or zero.
    # Implement the algorithm and calculate the arborescence score.
    
    library(here)
    library(igraph)
    
    # Loading directed edge list
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    original_edge_count <- gsize(g)
    
    # Solution
    
    # Condensing the graph by collapsing SCCs
    scc <- components(g, mode = "strong")
    # Each SCC will become a single node; build a new edge list
    map <- scc$membership
    from_scc <- map[as.character(edges$from)]
    to_scc <- map[as.character(edges$to)]
    condensed_edges <- unique(data.frame(from = from_scc, to = to_scc))
    condensed_edges <- condensed_edges[condensed_edges$from != condensed_edges$to, ]
    g_c <- graph_from_data_frame(condensed_edges, directed = TRUE,
                                 vertices = as.character(1:max(map)))
    
    # Prune incoming edges for nodes with in-degree > 1
    repeat {
      indegs <- degree(g_c, mode = "in")
      nodes_to_prune <- which(indegs > 1)
      if (length(nodes_to_prune) == 0) break
      for (v in nodes_to_prune) {
        # Getting incoming edges to this node
        inc_edges <- incident(g_c, v, mode = "in")
        # Randomly keep 1 incoming edge:
        if (length(inc_edges) > 1) {
          edges_to_remove <- sample(inc_edges, length(inc_edges) - 1)
          g_c <- delete_edges(g_c, edges_to_remove)
        }
      }
    }
    
    arborescence_edge_count <- gsize(g_c)
    
    # Arborescence score
    arborescence_score <- arborescence_edge_count / original_edge_count
    
    # Printing the results
    cat(sprintf("Arborescence score: %.4f\n", arborescence_score))
    cat(sprintf("Original number of edges: %d\n", original_edge_count))
    cat(sprintf("Edges in arborescence: %d\n", arborescence_edge_count))
```

</details>

</details>

<details>
<summary>

## 33.8.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform the null model test you did for exercise 1 also for global
    # reach centrality and arborescence. Which method is farther from
    # the average expected hierarchy value?
    
    library(here)
    library(igraph)
    
    # Loading the network ----
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building tha graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    N <- vcount(g)
    original_edge_count <- gsize(g)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform the null model test you did for exercise 1 also for global
    # reach centrality and arborescence. Which method is farther from
    # the average expected hierarchy value?
    
    library(here)
    library(igraph)
    
    # Loading the network ----
    edges <- read.table("data.txt", stringsAsFactors = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building tha graph
    g <- graph_from_data_frame(edges, directed = TRUE)
    N <- vcount(g)
    original_edge_count <- gsize(g)
    
    # Solution 
    
    # Observed Global Reach Centrality
    lrc <- numeric(N)
    for (v in seq_len(N)) {
      reachable <- subcomponent(g, v, mode = "out")
      lrc[v] <- (length(reachable) - 1) / (N - 1)
    }
    max_lrc <- max(lrc)
    mean_lrc <- mean(lrc)
    grc_obs <- (max_lrc - mean_lrc) / (N - 1)
    
    # Observed Arborescence
    # Condense SCCs
    scc <- components(g, mode = "strong")
    map <- scc$membership
    from_scc <- map[as.character(edges$from)]
    to_scc <- map[as.character(edges$to)]
    condensed_edges <- unique(data.frame(from = from_scc, to = to_scc))
    condensed_edges <- condensed_edges[condensed_edges$from != condensed_edges$to, ]
    verts_obs <- unique(c(condensed_edges$from, condensed_edges$to))
    g_c <- graph_from_data_frame(condensed_edges, directed = TRUE, vertices = verts_obs)
    
    # Prune incoming edges
    repeat {
      indegs <- degree(g_c, mode = "in")
      nodes_to_prune <- which(indegs > 1)
      if (length(nodes_to_prune) == 0) break
      for (v in nodes_to_prune) {
        inc_edges <- incident(g_c, v, mode = "in")
        if (length(inc_edges) > 1) {
          edges_to_remove <- sample(inc_edges, length(inc_edges) - 1)
          g_c <- delete_edges(g_c, edges_to_remove)
        }
      }
    }
    arbo_obs <- gsize(g_c) / original_edge_count
    
    # Null Model: Directed Configuration Model 
    in_deg <- degree(g, mode = "in")
    out_deg <- degree(g, mode = "out")
    grc_null <- numeric(25)
    arbo_null <- numeric(25)
    
    for(i in 1:25) {
      g_null <- sample_degseq(out_deg, in_deg, method = "fast.heur.simple")
      N_null <- vcount(g_null)
      
      # GRC for null
      lrc_null <- numeric(N_null)
      for (v in seq_len(N_null)) {
        reachable_null <- subcomponent(g_null, v, mode = "out")
        lrc_null[v] <- (length(reachable_null) - 1) / (N_null - 1)
      }
      max_lrc_null <- max(lrc_null)
      mean_lrc_null <- mean(lrc_null)
      grc_null[i] <- (max_lrc_null - mean_lrc_null) / (N_null - 1)
      
      # Arborescence for null
      scc_null <- components(g_null, mode = "strong")
      map_null <- scc_null$membership
      null_edges <- as.data.frame(ends(g_null, E(g_null)), stringsAsFactors = FALSE)
      from_scc_null <- map_null[as.character(null_edges$V1)]
      to_scc_null <- map_null[as.character(null_edges$V2)]
      condensed_edges_null <- unique(data.frame(from = from_scc_null, to = to_scc_null))
      condensed_edges_null <- condensed_edges_null[condensed_edges_null$from != condensed_edges_null$to, ]
      verts_null <- unique(c(condensed_edges_null$from, condensed_edges_null$to))
      if (nrow(condensed_edges_null) == 0) {
        # Trivial case: no edges left after condensing SCCs
        arbo_null[i] <- 0
        next
      }
      g_c_null <- graph_from_data_frame(condensed_edges_null, directed = TRUE, vertices = verts_null)
      repeat {
        indegs_null <- degree(g_c_null, mode = "in")
        nodes_to_prune_null <- which(indegs_null > 1)
        if (length(nodes_to_prune_null) == 0) break
        for (v in nodes_to_prune_null) {
          inc_edges_null <- incident(g_c_null, v, mode = "in")
          if (length(inc_edges_null) > 1) {
            edges_to_remove_null <- sample(inc_edges_null, length(inc_edges_null) - 1)
            g_c_null <- delete_edges(g_c_null, edges_to_remove_null)
          }
        }
      }
      arbo_null[i] <- gsize(g_c_null) / gsize(g_null)
    }
    
    # Z-score Calculation & Comparison
    grc_z <- (grc_obs - mean(grc_null)) / sd(grc_null)
    arbo_z <- (arbo_obs - mean(arbo_null)) / sd(arbo_null)
    
    # Printing the results
    
    cat(sprintf("Observed GRC: %.4f\n", grc_obs))
    cat(sprintf("Null mean GRC: %.4f, SD: %.4f, Z-score: %.2f\n", mean(grc_null), sd(grc_null), grc_z))
    cat(sprintf("Observed Arborescence: %.4f\n", arbo_obs))
    cat(sprintf("Null mean Arborescence: %.4f, SD: %.4f, Z-score: %.2f\n", mean(arbo_null), sd(arbo_null), arbo_z))
    
    if(abs(grc_z) > abs(arbo_z)) {
      cat("Global reach centrality is farther from its null model expectation.\n")
    } else if(abs(arbo_z) > abs(grc_z)) {
      cat("Arborescence is farther from its null model expectation.\n")
    } else {
      cat("Both are equally far from their null model expectation.\n")
    }
```

</details>

</details>

<details>
<summary>

## 34.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the distribution of the k2,0 and k2,1 degrees of the net-
    # work at http://www.networkatlas.eu/exercises/34/1/data.txt.
    # Assume every clique of the network to be a simplex.
    
    library(here)
    
    # Reading the edge list from a local file
    edges <- read.table("data.txt")
    
    # Getting all unique nodes present in the network
    nodes <- unique(c(edges$V1, edges$V2))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the distribution of the k2,0 and k2,1 degrees of the net-
    # work at http://www.networkatlas.eu/exercises/34/1/data.txt.
    # Assume every clique of the network to be a simplex.
    
    library(here)
    
    # Reading the edge list from a local file
    edges <- read.table("data.txt")
    
    # Getting all unique nodes present in the network
    nodes <- unique(c(edges$V1, edges$V2))
    
    #Solution
    
    # Building adjacency list for each node
    adj <- lapply(nodes, function(n) unique(c(edges$V2[edges$V1==n], edges$V1[edges$V2==n])))
    names(adj) <- nodes
    
    # Calculating k2,0 (degree) for each node
    k2_0 <- sapply(nodes, function(n) length(adj[[as.character(n)]]))
    
    # Calculating k2,1 (number of triangles for each edge)
    k2_1 <- apply(edges, 1, function(e) {
      a <- adj[[as.character(e[1])]]
      b <- adj[[as.character(e[2])]]
      length(intersect(a, b))
    })
    
    # Printing the distribution of node degrees
    cat("k2,0 (node degree) distribution:\n")
    print(table(k2_0))
    
    # Printing the distribution of edge degrees (number of triangles per edge)
    cat("k2,1 (edge degree) distribution:\n")
    print(table(k2_1))
```

</details>

</details>

<details>
<summary>

## 34.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Run an SI model with simple contagion on the simplicial complex
    # rom the previous exercise. The seed node is node 0. Run it for all
    # possible combinations of β 1 from 0.1 to 0.9 (in 0.1 increments) and
    # for β 2 = {0.0, 0.25, 0.5}. Make 100 independent runs and average
    # the results. Visualize the ratio of infected nodes after 3 steps for
    # each process – like in Figure 34.7.
    
    library(here)
    
    # Loading the edge list
    edges <- read.table("data.txt")
    nodes <- unique(c(edges$V1, edges$V2))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Run an SI model with simple contagion on the simplicial complex
    # rom the previous exercise. The seed node is node 0. Run it for all
    # possible combinations of β 1 from 0.1 to 0.9 (in 0.1 increments) and
    # for β 2 = {0.0, 0.25, 0.5}. Make 100 independent runs and average
    # the results. Visualize the ratio of infected nodes after 3 steps for
    # each process – like in Figure 34.7.
    
    library(here)
    
    # Loading the edge list
    edges <- read.table("data.txt")
    nodes <- unique(c(edges$V1, edges$V2))
    
    # Solution
    
    # Building adjacency list and triangle list
    adj <- lapply(nodes, function(n) unique(c(edges$V2[edges$V1==n], edges$V1[edges$V2==n])))
    names(adj) <- nodes
    
    # Finding all triangles in the graph
    triangles <- list()
    for (i in 1:nrow(edges)) {
      a <- edges[i, 1]; b <- edges[i, 2]
      inter <- intersect(adj[[as.character(a)]], adj[[as.character(b)]])
      if (length(inter) > 0) {
        for (c in inter) {
          tri <- sort(c(a, b, c))
          triangles[[paste(tri, collapse = "-")]] <- tri
        }
      }
    }
    tri_list <- unique(triangles)
    
    # SI simulation function
    si_run <- function(beta1, beta2) {
      infected <- rep(FALSE, length(nodes))
      names(infected) <- nodes
      infected["0"] <- TRUE
      for (step in 1:3) {
        new_inf <- infected
        # Edge infection
        for (i in nodes[infected]) {
          for (j in adj[[as.character(i)]]) {
            if (!infected[as.character(j)] && runif(1) < beta1) {
              new_inf[as.character(j)] <- TRUE
            }
          }
        }
        # Triangle infection
        for (tri in tri_list) {
          tri_infected <- infected[as.character(tri)]
          if (sum(tri_infected) == 2) {
            target <- tri[!tri_infected]
            if (!infected[as.character(target)] && runif(1) < beta2) {
              new_inf[as.character(target)] <- TRUE
            }
          }
        }
        infected <- new_inf
      }
      mean(infected)
    }
    
    beta1_vals <- seq(0.1, 0.9, by=0.1)
    beta2_vals <- c(0.0, 0.25, 0.5)
    results <- matrix(0, nrow=length(beta1_vals), ncol=length(beta2_vals))
    rownames(results) <- beta1_vals
    colnames(results) <- beta2_vals
    
    # Running the simulations
    set.seed(42)
    for (i in seq_along(beta1_vals)) {
      for (j in seq_along(beta2_vals)) {
        vals <- replicate(100, si_run(beta1_vals[i], beta2_vals[j]))
        results[i, j] <- mean(vals)
      }
    }
    
    # Visualizing the results
    library(ggplot2)
    df <- expand.grid(beta1=beta1_vals, beta2=beta2_vals)
    df$infected_ratio <- as.vector(results)
    ggplot(df, aes(x=beta1, y=beta2, fill=infected_ratio)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(x = expression(beta[1]), y = expression(beta[2]), fill="Infected ratio") +
      ggtitle("Fraction of infected nodes after 3 steps (SI model)")
```

</details>

</details>

<details>
<summary>

## 34.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Generate the two-order line graph of the network at http://www.
    # networkatlas.eu/exercises/34/3/data.txt, using the average
    # edge betweenness of the edges as the edge weight.
    
    library(here)
    library(igraph)
    
    # Loading the edge list from file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the original graph from the edge list
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Generate the two-order line graph of the network at http://www.
    # networkatlas.eu/exercises/34/3/data.txt, using the average
    # edge betweenness of the edges as the edge weight.
    
    library(here)
    library(igraph)
    
    # Loading the edge list from file
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the original graph from the edge list
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Calculatng edge betweenness for each edge in the original graph
    eb <- edge_betweenness(g)
    
    # Creating a list of all edges and their names
    edge_list <- as_edgelist(g)
    edge_names <- apply(edge_list, 1, function(x) paste(sort(x), collapse="-"))
    names(eb) <- edge_names
    n_edges <- nrow(edge_list)
    
    # Building adjacency for the line graph: edges become nodes, 
    # connecting two "edge-nodes" if they share a node in the original graph
    adj <- list()
    for(i in 1:(n_edges-1)) {
      for(j in (i+1):n_edges) {
        # Check if edges i and j share one node
        if(length(intersect(edge_list[i,], edge_list[j,])) == 1) {
          e1 <- edge_names[i]
          e2 <- edge_names[j]
          # Weight is the average edge betweenness of the two edges
          w <- mean(c(eb[e1], eb[e2]))
          adj <- append(adj, list(c(e1, e2, w)))
        }
      }
    }
    
    # Combining adjacency list into a data frame for the line graph
    if (length(adj) > 0) {
      line_edges <- do.call(rbind, adj)
      colnames(line_edges) <- c("from", "to", "weight")
      # Build the line graph using the edge list and weights
      line_g <- graph_from_data_frame(line_edges, directed=FALSE)
      print(line_g)
    } else {
      cat("No edges in the second-order line graph.\n")
    }
```

</details>

</details>

<details>
<summary>

## 34.5.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Assume that the edge weight is proportional to the probability
    # of following that edge. Which 2-step node transitions became
    # more likely to happen in the line graph compared to the original
    # network? (For simplicity, assume that the probability of going back
    # to the same node in 2-steps is zero for the line graph)
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Removing self-loops
    edges <- edges[edges$from != edges$to, ]
    
    # Removing duplicate edges (undirected: treat 1-2 and 2-1 as same)
    edges_sorted <- t(apply(edges, 1, sort))
    edges_unique <- unique(edges_sorted)
    edges_df <- data.frame(from=edges_unique[,1], to=edges_unique[,2])
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Assume that the edge weight is proportional to the probability
    # of following that edge. Which 2-step node transitions became
    # more likely to happen in the line graph compared to the original
    # network? (For simplicity, assume that the probability of going back
    # to the same node in 2-steps is zero for the line graph)
    
    library(here)
    library(igraph)
    
    # Loading edge list
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Removing self-loops
    edges <- edges[edges$from != edges$to, ]
    
    # Removing duplicate edges (undirected: treat 1-2 and 2-1 as same)
    edges_sorted <- t(apply(edges, 1, sort))
    edges_unique <- unique(edges_sorted)
    edges_df <- data.frame(from=edges_unique[,1], to=edges_unique[,2])
    
    # This should be the solution 
    
    # Building the graph
    g <- graph_from_data_frame(edges_df, directed=FALSE)
    g <- simplify(g, remove.multiple=TRUE, remove.loops=TRUE)
    stopifnot(is_igraph(g)) # Should be TRUE
    
    E(g)$weight <- 1
    
    # Assigning normalized transition probabilities for each edge in the original graph
    for(v in V(g)) {
      idx <- incident(g, v)
      ew <- E(g)[idx]$weight
      total <- sum(ew)
      if(total > 0) {
        E(g)[idx]$prob <- ew / total
      } else {
        E(g)[idx]$prob <- 0
      }
    }
    
    # Creating line graph
    lg <- line_graph(g, directed=FALSE)
    stopifnot(is_igraph(lg)) # Should be TRUE
    
    if(is.null(E(lg)$weight)) E(lg)$weight <- 1
    
    # Assigning normalized transition probabilities for each edge in the line graph
    for(v in V(lg)) {
      idx <- incident(lg, v)
      ew <- E(lg)[idx]$weight
      total <- sum(ew)
      if(total > 0) {
        E(lg)[idx]$prob <- ew / total
      } else {
        E(lg)[idx]$prob <- 0
      }
    }
    
    # Computing 2-step node transitions in the origianl graph
    orig_2step <- list()
    for(u in V(g)$name) {
      for(v in neighbors(g, u)$name) {
        for(w in neighbors(g, v)$name) {
          if(w != u) { # ignore going back to u
            e1 <- get.edge.ids(g, c(u, v))
            e2 <- get.edge.ids(g, c(v, w))
            prob <- E(g)[e1]$prob * E(g)[e2]$prob
            key <- paste(u, v, w, sep="-")
            orig_2step[[key]] <- prob
          }
        }
      }
    }
    
    # Computing 2-step transitions in the line graph and map to node transitions
    line_2step <- list()
    edge_names <- V(lg)$name
    for(e1 in edge_names) {
      for(e2 in neighbors(lg, e1)$name) {
        for(e3 in neighbors(lg, e2)$name) {
          if(e1 != e3) { # ignore going back
            nodes_e1 <- unlist(strsplit(e1, "\\|"))
            nodes_e2 <- unlist(strsplit(e2, "\\|"))
            nodes_e3 <- unlist(strsplit(e3, "\\|"))
            shared1 <- intersect(nodes_e1, nodes_e2)
            shared2 <- intersect(nodes_e2, nodes_e3)
            if(length(shared1) == 1 && length(shared2) == 1) {
              u <- setdiff(nodes_e1, shared1)
              v <- shared1
              w <- setdiff(nodes_e3, shared2)
              if(length(u) == 1 && length(v) == 1 && length(w) == 1 && u != w) {
                edge_id_12 <- get.edge.ids(lg, c(e1, e2))
                edge_id_23 <- get.edge.ids(lg, c(e2, e3))
                prob <- E(lg)[edge_id_12]$prob * E(lg)[edge_id_23]$prob
                key <- paste(u, v, w, sep="-")
                line_2step[[key]] <- prob
              }
            }
          }
        }
      }
    }
    
    # Comparing transition
    result <- c()
    for(key in names(line_2step)) {
      if(!is.null(orig_2step[[key]]) && line_2step[[key]] > orig_2step[[key]]) {
        result <- c(result, key)
      }
    }
    cat("2-step node transitions more likely in line graph than in original network:\n")
    print(result)
```

</details>

</details>

<details>
<summary>

## 35.8.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Find the communities in the network at http://www.networkatlas.
    # eu/exercises/35/1/data.txt using the label propagation strategy.
    # Which nodes are in the same community as node 1?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Find the communities in the network at http://www.networkatlas.
    # eu/exercises/35/1/data.txt using the label propagation strategy.
    # Which nodes are in the same community as node 1?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Running label propagation community detection
    com <- cluster_label_prop(g)
    
    # Finding the membership vector (community assignments)
    membership <- membership(com)
    
    # Getting the community of node 1
    node1_community <- membership["1"]
    
    # List all nodes in the same community as node 1
    nodes_same_community <- names(membership)[membership == node1_community]
    
    # Printing the results
    cat("Nodes in the same community as node 1:\n")
    print(nodes_same_community)
```

</details>

</details>

<details>
<summary>

## 35.8.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Find the local communities in the same network using the same
    # lgorithm, by only looking at the 2-step neighborhood of nodes 1,
    # 21, and 181.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the graph 
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # List of reference nodes
    ref_nodes <- c("1", "21", "181")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Find the local communities in the same network using the same
    # lgorithm, by only looking at the 2-step neighborhood of nodes 1,
    # 21, and 181.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    
    # Building the graph 
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # List of reference nodes
    ref_nodes <- c("1", "21", "181")
    
    # Solution 
    
    for(ref in ref_nodes) {
      # Finding 2-step neighborhood
      neighbors_2step <- ego(g, order=2, nodes=ref, mode="all")[[1]]
      # Induce subgraph
      subg <- induced_subgraph(g, neighbors_2step)
      # Running label propagation
      com <- cluster_label_prop(subg)
      membership <- membership(com)
      ref_community <- membership[ref]
      nodes_same_community <- names(membership)[membership == ref_community]
      cat(sprintf("\nNodes in the same local community (2-step neighborhood) as node %s:\n", ref))
      print(nodes_same_community)
    }
```

</details>

</details>

<details>
<summary>

## 35.8.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Suppose that the network at http://www.networkatlas.eu/
    # exercises/35/3/data.txt is a second observation of the previ-
    # ous network. Perform the label propagation community detection
    # on it and use the Jaccard coefficient to determine how different the
    # communities containing nodes 1, 21, and 181 are.
    
    library(here)
    library(igraph)
    
    # Helper function to get community members for a node
    get_community <- function(g, node) {
      com <- cluster_label_prop(g)
      membership <- membership(com)
      community_id <- membership[node]
      community_nodes <- names(membership)[membership == community_id]
      return(community_nodes)
    }
    
    # Loading both networks
    edges1 <- read.table("data1.txt")
    colnames(edges1) <- c("from", "to")
    # Building the graph 
    g1 <- graph_from_data_frame(edges1, directed=FALSE)
    
    edges2 <- read.table("data2.txt")
    colnames(edges2) <- c("from", "to")
    # Build the graph 
    g2 <- graph_from_data_frame(edges2, directed=FALSE)
    
    # Nodes to check
    nodes <- c("1", "21", "181")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Suppose that the network at http://www.networkatlas.eu/
    # exercises/35/3/data.txt is a second observation of the previ-
    # ous network. Perform the label propagation community detection
    # on it and use the Jaccard coefficient to determine how different the
    # communities containing nodes 1, 21, and 181 are.
    
    library(here)
    library(igraph)
    
    # Helper function to get community members for a node
    get_community <- function(g, node) {
      com <- cluster_label_prop(g)
      membership <- membership(com)
      community_id <- membership[node]
      community_nodes <- names(membership)[membership == community_id]
      return(community_nodes)
    }
    
    # Loading both networks
    edges1 <- read.table("data1.txt")
    colnames(edges1) <- c("from", "to")
    # Building the graph 
    g1 <- graph_from_data_frame(edges1, directed=FALSE)
    
    edges2 <- read.table("data2.txt")
    colnames(edges2) <- c("from", "to")
    # Build the graph 
    g2 <- graph_from_data_frame(edges2, directed=FALSE)
    
    # Nodes to check
    nodes <- c("1", "21", "181")
    
    # Solution
    
    # For each node, calculate Jaccard coefficient between communities
    for (node in nodes) {
      comm1 <- get_community(g1, node)
      comm2 <- get_community(g2, node)
      # Jaccard coefficient = intersection size / union size
      intersection <- length(intersect(comm1, comm2))
      union <- length(unique(c(comm1, comm2)))
      jaccard <- if (union > 0) intersection / union else NA
      cat(sprintf("Node %s:\n  Community in data1.txt: %s\n  Community in data2.txt: %s\n  Jaccard coefficient: %.3f\n\n",
                  node, paste(comm1, collapse=", "), paste(comm2, collapse=", "), jaccard))
    }
```

</details>

</details>

<details>
<summary>

## 36.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Detect communities of the network at http://www.networkatlas.
    # eu/exercises/36/1/data.txt using the asynchronous and the
    # semi-synchronous label propagation algorithms. Which one does
    # return the highest modularity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Detect communities of the network at http://www.networkatlas.
    # eu/exercises/36/1/data.txt using the asynchronous and the
    # semi-synchronous label propagation algorithms. Which one does
    # return the highest modularity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and buildingS the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution
    
    # Running asynchronous label propagation
    com_async <- cluster_label_prop(g)
    mod_async <- modularity(com_async)
    
    # Printing the results
    cat(sprintf("Asynchronous label propagation modularity: %.4f\n", mod_async))
    cat("Semi-synchronous label propagation is not available in current igraph R versions T_T.\n")
```

</details>

</details>

<details>
<summary>

## 36.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Find the communities of the network at http://www.networkatlas.
    # eu/exercises/36/2/data.txt using label propagation and calcu-
    # late the modularity. Then manually create a new partition by
    # moving nodes 25, 26, 27, 31 into their own partition. Recalculate
    # modularity for this new partition. Did this move increase modular-
    # ity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and creating the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Find the communities of the network at http://www.networkatlas.
    # eu/exercises/36/2/data.txt using label propagation and calcu-
    # late the modularity. Then manually create a new partition by
    # moving nodes 25, 26, 27, 31 into their own partition. Recalculate
    # modularity for this new partition. Did this move increase modular-
    # ity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and creating the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution
    
    # Running label propagation
    com <- cluster_label_prop(g)
    mod_orig <- modularity(com)
    
    cat(sprintf("Modularity of label propagation partition: %.4f\n", mod_orig))
    
    # Getting the membership vector
    membership <- membership(com)
    
    # 4. Moving nodes 25, 26, 27, 31 into their own community
    # Finding the next available community number (max + 1)
    new_comm <- max(membership) + 1
    membership[c("25", "26", "27", "31")] <- new_comm
    
    # Calculating modularity for the new partition
    mod_new <- modularity(g, membership)
    
    cat(sprintf("Modularity after moving nodes 25, 26, 27, 31: %.4f\n", mod_new))
    
    # 6. Compare the modularities
    if (mod_new > mod_orig) {
      cat("The move increased the modularity.\n")
    } else if (mod_new < mod_orig) {
      cat("The move decreased the modularity.\n")
    } else {
      cat("The modularity stayed the same.\n")
    }
```

</details>

</details>

<details>
<summary>

## 36.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Repeat exercise 1, but now evaluate the difference in performance
    # of the two community discovery algorithms by means of conduc-
    # tance, cut size, and normalized cut size.
    
    library(here)
    library(igraph)
    
    #================== Helper functions for metrics ==================
    conductance <- function(g, comm_nodes) {
      # Number of edges leaving community / min(total degree in/out)
      in_set <- comm_nodes
      out_set <- setdiff(V(g)$name, comm_nodes)
      cut_edges <- ecount(induced_subgraph(g, c(in_set, out_set))) - ecount(induced_subgraph(g, in_set)) - ecount(induced_subgraph(g, out_set))
      degree_in <- sum(degree(g, v=in_set))
      degree_out <- sum(degree(g, v=out_set))
      if (min(degree_in, degree_out) > 0) {
        return(cut_edges / min(degree_in, degree_out))
      } else {
        return(NA)
      }
    }
    
    cut_size <- function(g, comm_nodes) {
      # Number of edges with one endpoint in comm_nodes, one outside
      cut_edges <- 0
      for (v in comm_nodes) {
        for (n in neighbors(g, v)$name) {
          if (!(n %in% comm_nodes)) {
            cut_edges <- cut_edges + 1
          }
        }
      }
      # Each edge counted twice, so divide by 2
      return(cut_edges / 2)
    }
    
    normalized_cut_size <- function(g, comm_nodes) {
      cs <- cut_size(g, comm_nodes)
      deg <- sum(degree(g, v=comm_nodes))
      if (deg > 0) {
        return(cs / deg)
      } else {
        return(NA)
      }
    }
    
    #================== End Helper functions for metrics ==================
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Repeat exercise 1, but now evaluate the difference in performance
    # of the two community discovery algorithms by means of conduc-
    # tance, cut size, and normalized cut size.
    
    library(here)
    library(igraph)
    
    #================== Helper functions for metrics ==================
    conductance <- function(g, comm_nodes) {
      # Number of edges leaving community / min(total degree in/out)
      in_set <- comm_nodes
      out_set <- setdiff(V(g)$name, comm_nodes)
      cut_edges <- ecount(induced_subgraph(g, c(in_set, out_set))) - ecount(induced_subgraph(g, in_set)) - ecount(induced_subgraph(g, out_set))
      degree_in <- sum(degree(g, v=in_set))
      degree_out <- sum(degree(g, v=out_set))
      if (min(degree_in, degree_out) > 0) {
        return(cut_edges / min(degree_in, degree_out))
      } else {
        return(NA)
      }
    }
    
    cut_size <- function(g, comm_nodes) {
      # Number of edges with one endpoint in comm_nodes, one outside
      cut_edges <- 0
      for (v in comm_nodes) {
        for (n in neighbors(g, v)$name) {
          if (!(n %in% comm_nodes)) {
            cut_edges <- cut_edges + 1
          }
        }
      }
      # Each edge counted twice, so divide by 2
      return(cut_edges / 2)
    }
    
    normalized_cut_size <- function(g, comm_nodes) {
      cs <- cut_size(g, comm_nodes)
      deg <- sum(degree(g, v=comm_nodes))
      if (deg > 0) {
        return(cs / deg)
      } else {
        return(NA)
      }
    }
    
    #================== End Helper functions for metrics ==================
    
    # Loading the edge list and building the graph
    edges <- read.table("data.txt")
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution
    
    # Detecting communities
    com_lp <- cluster_label_prop(g)
    com_fg <- cluster_fast_greedy(g)
    
    mod_lp <- modularity(com_lp)
    mod_fg <- modularity(com_fg)
    
    cat("Label Propagation modularity:", mod_lp, "\n")
    cat("Fast Greedy modularity:", mod_fg, "\n\n")
    
    # Getting membership vectors
    memb_lp <- membership(com_lp)
    memb_fg <- membership(com_fg)
    
    # For each algorithm, for each community, compute metrics
    algorithms <- list(LabelPropagation=memb_lp, FastGreedy=memb_fg)
    for (alg in names(algorithms)) {
      membership <- algorithms[[alg]]
      cat(sprintf("\n--- %s ---\n", alg))
      comm_ids <- sort(unique(membership))
      for (cid in comm_ids) {
        comm_nodes <- names(membership)[membership == cid]
        cs <- cut_size(g, comm_nodes)
        cond <- conductance(g, comm_nodes)
        ncs <- normalized_cut_size(g, comm_nodes)
        cat(sprintf("Community %d: size=%d, cut_size=%.2f, conductance=%.4f, normalized_cut_size=%.4f\n",
                    cid, length(comm_nodes), cs, cond, ncs))
      }
    }
```

</details>

</details>

<details>
<summary>

## 36.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Assume that http://www.networkatlas.eu/exercises/36/4/
    # nodes.txt contains the “true” community partition of the nodes
    # from the network at http://www.networkatlas.eu/exercises/
    # 36/1/data.txt. Determine which algorithm between the asynchronous
    # and the semi-synchronous label propagation achieves
    # higher Normalized Mutual Information with such gold standard.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Loading the gold standard communities from nodes.txt
    true_membership_df <- read.table(here("nodes.txt"))
    colnames(true_membership_df) <- c("node", "community")
    true_membership <- setNames(true_membership_df$community, as.character(true_membership_df$node))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Assume that http://www.networkatlas.eu/exercises/36/4/
    # nodes.txt contains the “true” community partition of the nodes
    # from the network at http://www.networkatlas.eu/exercises/
    # 36/1/data.txt. Determine which algorithm between the asynchronous
    # and the semi-synchronous label propagation achieves
    # higher Normalized Mutual Information with such gold standard.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Loading the gold standard communities from nodes.txt
    true_membership_df <- read.table(here("nodes.txt"))
    colnames(true_membership_df) <- c("node", "community")
    true_membership <- setNames(true_membership_df$community, as.character(true_membership_df$node))
    
    # Solution 
    
    # Computing the detected communities using label propagation (asynchronous)
    com_lp <- cluster_label_prop(g)
    lp_membership <- membership(com_lp)
    
    # Matching true membership and detected membership
    common_nodes <- intersect(names(true_membership), names(lp_membership))
    true <- true_membership[common_nodes]
    pred_lp <- lp_membership[common_nodes]
    
    # Computing the Normalized Mutual Information (NMI) between true and detected partitions
    nmi_lp <- compare(true, pred_lp, method="nmi")
    
    # Printing the results
    cat("Evaluating Normalized Mutual Information (NMI) with the gold standard\n")
    cat(sprintf("Label Propagation (asynchronous) NMI: %.4f\n", nmi_lp))
```

</details>

</details>

<details>
<summary>

## 37.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the edge betweenness algorithm to find hierarchical communities
    # in the network at http://www.networkatlas.eu/exercises/
    # 37/1/data.txt. Since the algorithm has high time complexity,
    # perform only the first 10 splits. What is the split with the highest
    # modularity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the edge betweenness algorithm to find hierarchical communities
    # in the network at http://www.networkatlas.eu/exercises/
    # 37/1/data.txt. Since the algorithm has high time complexity,
    # perform only the first 10 splits. What is the split with the highest
    # modularity?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Finding hierarchical communities using edge betweenness
    com_eb <- cluster_edge_betweenness(g, weights=E(g)$weight, directed=FALSE)
    
    # Extracting the modularity after each split (for the first 10 splits)
    mod_vals <- modularity(com_eb)[1:10]
    
    # Finding the split with the highest modularity in the first 10 splits
    max_modularity <- max(mod_vals)
    best_split <- which.max(mod_vals)
    
    # Printing the results
    cat("Evaluating modularity for the first 10 splits using edge betweenness\n")
    cat(sprintf("The split with the highest modularity is split %d with modularity %.4f\n", best_split, max_modularity))
```

</details>

</details>

<details>
<summary>

## 37.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Change the splitting criterion of the algorithm, using the inverse
    # edge weight rather than edge betweenness. Since this is much
    # faster, you can perform the first 20 splits. Do you get higher or
    # lower modularity relative to the result from exercise 1?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Change the splitting criterion of the algorithm, using the inverse
    # edge weight rather than edge betweenness. Since this is much
    # faster, you can perform the first 20 splits. Do you get higher or
    # lower modularity relative to the result from exercise 1?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution
    
    # Computing the inverse of the edge weights
    inv_weights <- 1 / edges$weight
    E(g)$inv_weight <- inv_weights
    
    # Finding hierarchical communities using the inverse edge weight as distance
    # Using cluster_fast_greedy which uses edge weights as similarity, so we set the weights as inverse of distance
    com_fg <- cluster_fast_greedy(g, weights=E(g)$inv_weight)
    
    # Extracting the modularity after each split (first 20 splits)
    mod_vals <- modularity(com_fg)[1:20]
    
    # Finding the split with the highest modularity in the first 20 splits
    max_modularity <- max(mod_vals)
    best_split <- which.max(mod_vals)
    
    # Printing the results
    cat("Evaluating modularity for the first 20 splits using inverse edge weight (fast greedy)\n")
    cat(sprintf("The split with the highest modularity is split %d with modularity %.4f\n", best_split, max_modularity))
```

</details>

</details>

<details>
<summary>

## 37.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the maximum edge weight pointing to a community as a
    # guiding principle to merge nodes into communities using the
    # bottom-up approach. (An easy way is to just condense the graph
    # by merging the two nodes with the maximum edge weight, for
    # every edge in the network)
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Initializing membership: each node is its own community
    membership <- seq_along(V(g))
    names(membership) <- V(g)$name
    
    # Copying the graph for iterative merging
    g_merge <- g
    
    # Tracking modularity after each merge
    mod_vals <- c()
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the maximum edge weight pointing to a community as a
    # guiding principle to merge nodes into communities using the
    # bottom-up approach. (An easy way is to just condense the graph
    # by merging the two nodes with the maximum edge weight, for
    # every edge in the network)
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Initializing membership: each node is its own community
    membership <- seq_along(V(g))
    names(membership) <- V(g)$name
    
    # Copying the graph for iterative merging
    g_merge <- g
    
    # Tracking modularity after each merge
    mod_vals <- c()
    
    # Solution 
    
    while(ecount(g_merge) > 0) {
      # Finding the edge with the maximum weight
      max_w_idx <- which.max(E(g_merge)$weight)
      max_edge <- ends(g_merge, E(g_merge)[max_w_idx])
      n1 <- max_edge[1]
      n2 <- max_edge[2]
      
      # Getting the membership IDs for the two nodes
      comm1 <- membership[n1]
      comm2 <- membership[n2]
      if(comm1 == comm2) break # Already in the same community
      
      # Merging the communities: assign all nodes of comm2 to comm1's community
      membership[membership == comm2] <- comm1
      
      # Contracting the nodes in the graph
      # Build a mapping: for each vertex in g_merge, what is its current (minimum) community ID?
      vmap <- membership[V(g_merge)$name]
      # The mapping must be recoded as 1...N for contract()
      vmap <- as.integer(factor(vmap))
      
      g_merge <- contract(g_merge, mapping = vmap, vertex.attr.comb="first")
      g_merge <- simplify(g_merge, edge.attr.comb = list(weight="sum"))
      
      # Ensuring membership vector for modularity is always consecutive positive integers
      comm_ids <- as.integer(factor(membership))
      mod_vals <- c(mod_vals, modularity(g, comm_ids))
    }
    
    # Finding the best step by modularity
    max_modularity <- max(mod_vals)
    best_step <- which.max(mod_vals)
    
    # Printing the results
    cat("Merging nodes using the maximum edge weight (bottom-up)\n")
    cat(sprintf("The step with the highest modularity is merge %d with modularity %.4f\n", best_step, max_modularity))
```

</details>

</details>

<details>
<summary>

## 37.6.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Using the algorithm you made for exercise 3, answer these questions:
    # What is the latest step for which you have the average
    # internal community edge density equal to 1? What is the modularity
    # at that step? What is the highest modularity you can obtain?
    # What is the average internal community edge density at that step?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Using the algorithm you made for exercise 3, answer these questions:
    # What is the latest step for which you have the average
    # internal community edge density equal to 1? What is the modularity
    # at that step? What is the highest modularity you can obtain?
    # What is the average internal community edge density at that step?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Initializing membership: each node is its own community
    membership <- seq_along(V(g))
    names(membership) <- V(g)$name
    
    # For tracking the state after each merge
    all_memberships <- list()
    all_modularities <- c()
    all_densities <- c()
    
    g_merge <- g
    
    while(ecount(g_merge) > 0) {
      # Find the edge with the maximum weight
      max_w_idx <- which.max(E(g_merge)$weight)
      max_edge <- ends(g_merge, E(g_merge)[max_w_idx])
      n1 <- max_edge[1]
      n2 <- max_edge[2]
      
      # Get community ids
      comm1 <- membership[n1]
      comm2 <- membership[n2]
      if(comm1 == comm2) break # Already merged
      
      # Merge the communities
      membership[membership == comm2] <- comm1
      
      # Contract nodes in graph
      vmap <- membership[V(g_merge)$name]
      vmap <- as.integer(factor(vmap))
      g_merge <- contract(g_merge, mapping=vmap, vertex.attr.comb="first")
      g_merge <- simplify(g_merge, edge.attr.comb = list(weight="sum"))
      
      # Store membership mapping for this step
      comm_ids <- as.integer(factor(membership))
      all_memberships[[length(all_memberships) + 1]] <- comm_ids
      
      # Compute modularity for this partition
      all_modularities <- c(all_modularities, modularity(g, comm_ids))
      
      # Compute average internal community edge density for this partition
      # For each community, get the subgraph and calculate density, then average
      communities <- split(V(g)$name, comm_ids)
      densities <- c()
      for (comm in communities) {
        if (length(comm) == 1) {
          densities <- c(densities, 1) # Single node: density=1 by convention
        } else {
          subg <- induced_subgraph(g, comm)
          d <- edge_density(subg, loops=FALSE)
          densities <- c(densities, d)
        }
      }
      all_densities <- c(all_densities, mean(densities))
    }
    
    # Find the latest step where average internal community density == 1
    last_perfect_density <- max(which(abs(all_densities - 1) < 1e-8))
    mod_at_perfect_density <- all_modularities[last_perfect_density]
    
    # Find the step with highest modularity
    max_modularity <- max(all_modularities)
    step_max_modularity <- which.max(all_modularities)
    density_at_max_modularity <- all_densities[step_max_modularity]
    
    # Printing the results
    cat("Step with latest average internal community density = 1:", last_perfect_density, "\n")
    cat("Modularity at that step:", mod_at_perfect_density, "\n")
    cat("Step with highest modularity:", step_max_modularity, "\n")
    cat("Highest modularity:", max_modularity, "\n")
    cat("Average internal community density at that step:", density_at_max_modularity, "\n")
```

</details>

</details>

<details>
<summary>

## 38.9.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the k-clique algorithm to find overlapping communities in the
    # network at http://www.networkatlas.eu/exercises/38/1/data.
    # txt. Test how many nodes are part of no community for k equal to
    # 3, 4, and 5.
    
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Removing weights for clique percolation
    g_unweighted <- delete_edge_attr(g, "weight")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the k-clique algorithm to find overlapping communities in the
    # network at http://www.networkatlas.eu/exercises/38/1/data.
    # txt. Test how many nodes are part of no community for k equal to
    # 3, 4, and 5.
    
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Removing weights for clique percolation
    g_unweighted <- delete_edge_attr(g, "weight")
    
    # This should be the solution
    
    # Function to count nodes not in any community for a given k
    count_nodes_no_community <- function(graph, k) {
      kc <- k_clique_communities(graph, k)
      # Get unique nodes in communities
      nodes_in_comms <- unique(unlist(kc))
      # Count nodes not in any community
      all_nodes <- V(graph)$name
      length(setdiff(all_nodes, nodes_in_comms))
    }
    
    # Testing for k = 3, 4, 5
    for (k in 3:5) {
      cat(sprintf("Testing k = %d\n", k))
      n_no_comm <- count_nodes_no_community(g_unweighted, k)
      cat(sprintf("Nodes not in any %d-clique community: %d\n", k, n_no_comm))
    }
```

</details>

</details>

<details>
<summary>

## 38.9.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the k-clique results with the coverage in http://www.
    # networkatlas.eu/exercises/38/2/comms.txt, by using any variation
    # of overlapping NMI from https://github.com/aaronmcdaid/
    # Overlapping-NMI. For which value of k do you get the best performance?
    
    library(here)
    library(igraph)
    
    # Defining the k_clique_communities function for finding k-clique communities
    k_clique_communities <- function(graph, k) {
      all_cliques <- cliques(graph, min = k, max = k)
      if (length(all_cliques) == 0) return(list())
      clique_graph <- make_empty_graph(n = length(all_cliques))
      for (i in seq_along(all_cliques)) {
        for (j in seq_len(i-1)) {
          if (length(intersect(all_cliques[[i]], all_cliques[[j]])) == (k-1)) {
            clique_graph <- add_edges(clique_graph, c(i, j))
          }
        }
      }
      comps <- components(clique_graph)
      communities <- lapply(seq_len(comps$no), function(comp_id) {
        idx <- which(comps$membership == comp_id)
        unique(unlist(all_cliques[idx]))
      })
      lapply(communities, function(x) V(graph)$name[x])
    }
    
    source(here("OverlappingNMI.R"))
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the k-clique results with the coverage in http://www.
    # networkatlas.eu/exercises/38/2/comms.txt, by using any variation
    # of overlapping NMI from https://github.com/aaronmcdaid/
    # Overlapping-NMI. For which value of k do you get the best performance?
    
    library(here)
    library(igraph)
    
    # Defining the k_clique_communities function for finding k-clique communities
    k_clique_communities <- function(graph, k) {
      all_cliques <- cliques(graph, min = k, max = k)
      if (length(all_cliques) == 0) return(list())
      clique_graph <- make_empty_graph(n = length(all_cliques))
      for (i in seq_along(all_cliques)) {
        for (j in seq_len(i-1)) {
          if (length(intersect(all_cliques[[i]], all_cliques[[j]])) == (k-1)) {
            clique_graph <- add_edges(clique_graph, c(i, j))
          }
        }
      }
      comps <- components(clique_graph)
      communities <- lapply(seq_len(comps$no), function(comp_id) {
        idx <- which(comps$membership == comp_id)
        unique(unlist(all_cliques[idx]))
      })
      lapply(communities, function(x) V(graph)$name[x])
    }
    
    source(here("OverlappingNMI.R"))
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Removing weights for clique percolation
    g_unweighted <- delete_edge_attr(g, "weight")
    
    # Loading the ground truth communities from comms.txt
    comms_lines <- readLines(here("comms.txt"))
    gt_communities <- lapply(comms_lines, function(line) strsplit(line, " ")[[1]])
    gt_communities <- lapply(gt_communities, as.character)
    
    # Defining a function for extracting k-clique communities as lists of character vectors
    get_kc_comms <- function(graph, k) {
      kc <- k_clique_communities(graph, k)
      lapply(kc, as.character)
    }
    
    # Initializing a results data frame
    results <- data.frame(k=integer(), nmi=numeric())
    
    # Calculating the NMI for k = 3, 4, 5
    for (k in 3:5) {
      cat(sprintf("Calculating for k = %d\n", k))
      detected <- get_kc_comms(g_unweighted, k)
      nmi_value <- NMI(gt_communities, detected)
      results <- rbind(results, data.frame(k=k, nmi=nmi_value))
      cat(sprintf("k = %d | NMI = %.4f\n", k, nmi_value))
    }
    
    cat("\nSummary of k-clique NMI results:\n")
    print(results, row.names = FALSE)
    
    best_k <- results$k[which.max(results$nmi)]
    cat(sprintf("\nBest performance for k = %d (NMI = %.4f)\n", best_k, max(results$nmi)))
```

</details>

</details>

<details>
<summary>

## 38.9.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    #Implement the ego network algorithm: for each node, extract its
    #ego minus ego network and apply the label propagation algorithm,
    #then merge communities with a node Jaccard coefficient higher
    #than 0.1 (ignoring singletons: communities of a single node). Does
    #this method return a better NMI than k-clique percolation for
    #k = 3?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Removing weights for community detection
    g_unweighted <- delete_edge_attr(g, "weight")
    
    # Loading the ground truth communities from comms.txt
    comms_lines <- readLines(here("comms.txt"))
    gt_communities <- lapply(comms_lines, function(line) strsplit(line, " ")[[1]])
    gt_communities <- lapply(gt_communities, as.character)
    
    # Sourcing the OverlappingNMI.R script
    source(here("OverlappingNMI.R"))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    #Implement the ego network algorithm: for each node, extract its
    #ego minus ego network and apply the label propagation algorithm,
    #then merge communities with a node Jaccard coefficient higher
    #than 0.1 (ignoring singletons: communities of a single node). Does
    #this method return a better NMI than k-clique percolation for
    #k = 3?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "weight")
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Removing weights for community detection
    g_unweighted <- delete_edge_attr(g, "weight")
    
    # Loading the ground truth communities from comms.txt
    comms_lines <- readLines(here("comms.txt"))
    gt_communities <- lapply(comms_lines, function(line) strsplit(line, " ")[[1]])
    gt_communities <- lapply(gt_communities, as.character)
    
    # Sourcing the OverlappingNMI.R script
    source(here("OverlappingNMI.R"))
    
    # Solution 
    
    # Extracting ego minus ego communities
    all_nodes <- V(g_unweighted)$name
    node_comms <- list()
    for (node in all_nodes) {
      ego_graph <- make_ego_graph(g_unweighted, order=1, nodes=node, mode="all")[[1]]
      ego_minus_ego <- delete_vertices(ego_graph, node)
      if (vcount(ego_minus_ego) > 0) {
        comms <- cluster_label_prop(ego_minus_ego)
        for (mem in unique(membership(comms))) {
          comm_nodes <- names(membership(comms))[membership(comms) == mem]
          node_comms <- append(node_comms, list(comm_nodes))
        }
      }
    }
    
    # Merging communities with Jaccard coefficient > 0.1 and removing singletons
    merge_communities <- function(comms, threshold=0.1) {
      comms <- comms[sapply(comms, length) > 1]
      merged <- list()
      while (length(comms) > 0) {
        base <- comms[[1]]
        to_merge <- sapply(comms, function(x) {
          inter <- length(intersect(base, x))
          union <- length(union(base, x))
          if (union == 0) return(0)
          inter / union
        })
        merge_idxs <- which(to_merge > threshold)
        new_comm <- unique(unlist(comms[merge_idxs]))
        merged <- append(merged, list(new_comm))
        comms <- comms[-merge_idxs]
      }
      merged
    }
    
    cat("Merging overlapping ego-minus-ego communities\n")
    final_communities <- merge_communities(node_comms, threshold=0.1)
    
    # Calculating Overlapping NMI
    nmi_ego <- NMI(gt_communities, final_communities)
    cat(sprintf("Ego-minus-ego method NMI: %.4f\n", nmi_ego))
    
    # Calculating k-clique percolation k=3 for comparison
    k_clique_communities <- function(graph, k) {
      all_cliques <- cliques(graph, min = k, max = k)
      if (length(all_cliques) == 0) return(list())
      clique_graph <- make_empty_graph(n = length(all_cliques))
      for (i in seq_along(all_cliques)) {
        for (j in seq_len(i-1)) {
          if (length(intersect(all_cliques[[i]], all_cliques[[j]])) == (k-1)) {
            clique_graph <- add_edges(clique_graph, c(i, j))
          }
        }
      }
      comps <- components(clique_graph)
      communities <- lapply(seq_len(comps$no), function(comp_id) {
        idx <- which(comps$membership == comp_id)
        unique(unlist(all_cliques[idx]))
      })
      lapply(communities, function(x) V(graph)$name[x])
    }
    
    kc3 <- k_clique_communities(g_unweighted, 3)
    kc3 <- lapply(kc3, as.character)
    nmi_kc3 <- NMI(gt_communities, kc3)
    cat(sprintf("k-clique percolation (k=3) NMI: %.4f\n", nmi_kc3))
    
    # Printing comparison
    if (nmi_ego > nmi_kc3) {
      cat("Ego-minus-ego + label propagation gives a better NMI than k-clique percolation with k=3\n")
    } else if (nmi_ego < nmi_kc3) {
      cat("k-clique percolation with k=3 gives a better NMI than ego-minus-ego + label propagation\n")
    } else {
      cat("Both methods give the same NMI\n")
    }
```

</details>

</details>

<details>
<summary>

## 39.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/39/
    # 1/data.txt is bipartite. Project it into unipartite and find five
    # communities with the Girvan-Newman edge betweenness algorithm
    # (repeat for both node types, so you find a total of ten
    # communities). What is the NMI with the partition proposed at
    # http://www.networkatlas.eu/exercises/39/1/nodes.txt?
    
    
    #__The data for this exercise is bad. How can you understand this? ________
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Filtering edges so that only between set1 and set2 remain
    edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))
    
    # Building the bipartite graph
    g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
    V(g)$type <- V(g)$name %in% set1
    
    # Projecting the bipartite graph
    proj <- bipartite_projection(g)
    g1 <- proj$proj1
    g2 <- proj$proj2
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The network at http://www.networkatlas.eu/exercises/39/
    # 1/data.txt is bipartite. Project it into unipartite and find five
    # communities with the Girvan-Newman edge betweenness algorithm
    # (repeat for both node types, so you find a total of ten
    # communities). What is the NMI with the partition proposed at
    # http://www.networkatlas.eu/exercises/39/1/nodes.txt?
    
    
    #__The data for this exercise is bad. How can you understand this? ________
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Filtering edges so that only between set1 and set2 remain
    edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))
    
    # Building the bipartite graph
    g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
    V(g)$type <- V(g)$name %in% set1
    
    # Projecting the bipartite graph
    proj <- bipartite_projection(g)
    g1 <- proj$proj1
    g2 <- proj$proj2
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    # Solution 
    
    get_communities <- function(cl, n_communities) {
      memb <- tryCatch(
        cut_at(cl, no=n_communities),
        error = function(e) NULL
      )
      if(is.null(memb) || !is.vector(memb) || is.null(names(memb))) {
        return(list())
      }
      split(names(memb), memb)
    }
    
    # Running Girvan-Newman clustering on the projections
    cl1 <- cluster_edge_betweenness(g1)
    comms1 <- get_communities(cl1, 5)
    
    cl2 <- cluster_edge_betweenness(g2)
    comms2 <- get_communities(cl2, 5)
    
    comm_to_mem <- function(comms, all_nodes) {
      mem <- rep(NA, length(all_nodes))
      names(mem) <- all_nodes
      for (i in seq_along(comms)) {
        mem[comms[[i]]] <- i
      }
      mem
    }
    
    # Creating membership vectors for both projections
    mem1 <- comm_to_mem(comms1, V(g1)$name)
    mem2 <- comm_to_mem(comms2, V(g2)$name)
    
    # Selecting nodes present in both ground truth and mem, removing NA, and sorting
    common1 <- intersect(names(mem1), names(gt_comm))
    mem1_clean <- mem1[common1]
    gt_mem1_clean <- gt_comm[common1]
    valid_idx1 <- !(is.na(mem1_clean) | is.na(gt_mem1_clean))
    mem1_clean <- mem1_clean[valid_idx1]
    gt_mem1_clean <- gt_mem1_clean[valid_idx1]
    order1 <- order(names(mem1_clean))
    mem1_clean <- mem1_clean[order1]
    gt_mem1_clean <- gt_mem1_clean[order1]
    
    common2 <- intersect(names(mem2), names(gt_comm))
    mem2_clean <- mem2[common2]
    gt_mem2_clean <- gt_comm[common2]
    valid_idx2 <- !(is.na(mem2_clean) | is.na(gt_mem2_clean))
    mem2_clean <- mem2_clean[valid_idx2]
    gt_mem2_clean <- gt_mem2_clean[valid_idx2]
    order2 <- order(names(mem2_clean))
    mem2_clean <- mem2_clean[order2]
    gt_mem2_clean <- gt_mem2_clean[order2]
    
    # Printing lengths for debugging
    cat("mem1_clean length:", length(mem1_clean), "\n")
    cat("gt_mem1_clean length:", length(gt_mem1_clean), "\n")
    cat("mem2_clean length:", length(mem2_clean), "\n")
    cat("gt_mem2_clean length:", length(gt_mem2_clean), "\n")
    cat("Any duplicated names in mem1_clean:", any(duplicated(names(mem1_clean))), "\n")
    cat("Any duplicated names in gt_mem1_clean:", any(duplicated(names(gt_mem1_clean))), "\n")
    cat("Unique communities in mem1_clean:", length(unique(mem1_clean)), "\n")
    cat("Unique communities in gt_mem1_clean:", length(unique(gt_mem1_clean)), "\n")
    
    # Loading the NMI function
    source(here("OverlappingNMI.R"))
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Calculating NMI for both projections if partitions are valid
    if(length(mem1_clean) > 0 && length(gt_mem1_clean) > 0 &&
       length(unique(mem1_clean)) > 1 && length(unique(gt_mem1_clean)) > 1) {
      nmi1 <- NMI(partition_to_list(gt_mem1_clean), partition_to_list(mem1_clean))
      cat(sprintf("NMI for projection on node type 1: %.4f\n", nmi1))
    } else {
      cat("Cannot compute NMI for projection on node type 1: check partitions\n")
    }
    
    if(length(mem2_clean) > 0 && length(gt_mem2_clean) > 0 &&
       length(unique(mem2_clean)) > 1 && length(unique(gt_mem2_clean)) > 1) {
      nmi2 <- NMI(partition_to_list(gt_mem2_clean), partition_to_list(mem2_clean))
      cat(sprintf("NMI for projection on node type 2: %.4f\n", nmi2))
    } else {
      cat("Cannot compute NMI for projection on node type 2: check partitions\n")
    }
```

</details>

</details>

<details>
<summary>

## 39.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Now perform asynchronous label propagation directly on the
    # bipartite structure. Calculate the NMI with the ground truth. Since
    # asynchronous label propagation is randomized, take the average of
    # ten runs. Do you get a higher NMI?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Filtering edges so that only between set1 and set2 remain
    edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))
    
    # Building the bipartite graph
    g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Now perform asynchronous label propagation directly on the
    # bipartite structure. Calculate the NMI with the ground truth. Since
    # asynchronous label propagation is randomized, take the average of
    # ten runs. Do you get a higher NMI?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Filtering edges so that only between set1 and set2 remain
    edges_bipartite <- subset(edges, (from %in% set1 & to %in% set2) | (from %in% set2 & to %in% set1))
    
    # Building the bipartite graph
    g <- graph_from_data_frame(edges_bipartite, directed=FALSE)
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    # Solution 
    
    # Running asynchronous label propagation 10 times and calculating NMI each time
    n_runs <- 10
    nmi_values <- numeric(n_runs)
    for(i in 1:n_runs) {
      # Running label propagation on the bipartite graph
      lp <- cluster_label_prop(g)
      # Creating membership vector from clustering result
      memb <- membership(lp)
      # Finding nodes present in both ground truth and clustering result
      common <- intersect(names(memb), names(gt_comm))
      memb_clean <- memb[common]
      gt_comm_clean <- gt_comm[common]
      # Removing NA values and ensuring the same order
      valid_idx <- !(is.na(memb_clean) | is.na(gt_comm_clean))
      memb_clean <- memb_clean[valid_idx]
      gt_comm_clean <- gt_comm_clean[valid_idx]
      order_idx <- order(names(memb_clean))
      memb_clean <- memb_clean[order_idx]
      gt_comm_clean <- gt_comm_clean[order_idx]
      # Calculating NMI for this run
      if(length(memb_clean) > 0 && length(gt_comm_clean) > 0 &&
         length(unique(memb_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
        nmi_values[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_clean))
      } else {
        nmi_values[i] <- NA
      }
    }
    
    # Calculating the average NMI over all valid runs
    avg_nmi <- mean(nmi_values, na.rm=TRUE)
    
    cat(sprintf("Average NMI over %d runs of label propagation on the bipartite graph: %.4f\n", n_runs, avg_nmi))
```

</details>

</details>

<details>
<summary>

## 39.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Consider the bi-adjacency matrix as a data table and perform
    # bi-clustering on it, using any bi-clustering algorithm provided in
    # the scikit-learn library. Do you get a higher NMI than in the
    # previous two cases?
    
    #__The data for this exercise is bad. How can you understand this? ________
    
    library(here)
    library(igraph)
    library(biclust)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Building the bi-adjacency matrix
    adj_mat <- matrix(0, nrow=length(set1), ncol=length(set2))
    rownames(adj_mat) <- set1
    colnames(adj_mat) <- set2
    for(i in seq_len(nrow(edges))) {
      f <- edges$from[i]
      t <- edges$to[i]
      if(f %in% set1 && t %in% set2) {
        adj_mat[f, t] <- 1
      }
      if(f %in% set2 && t %in% set1) {
        adj_mat[t, f] <- 1
      }
    }
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Consider the bi-adjacency matrix as a data table and perform
    # bi-clustering on it, using any bi-clustering algorithm provided in
    # the scikit-learn library. Do you get a higher NMI than in the
    # previous two cases?
    
    #__The data for this exercise is bad. How can you understand this? ________
    
    library(here)
    library(igraph)
    library(biclust)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Inferring bipartite sets using the first 60 rows
    N <- 60
    set1 <- unique(edges$from[1:N])
    set2 <- unique(edges$to[1:N])
    set1 <- setdiff(set1, set2)
    set2 <- setdiff(set2, set1)
    
    # Building the bi-adjacency matrix
    adj_mat <- matrix(0, nrow=length(set1), ncol=length(set2))
    rownames(adj_mat) <- set1
    colnames(adj_mat) <- set2
    for(i in seq_len(nrow(edges))) {
      f <- edges$from[i]
      t <- edges$to[i]
      if(f %in% set1 && t %in% set2) {
        adj_mat[f, t] <- 1
      }
      if(f %in% set2 && t %in% set1) {
        adj_mat[t, f] <- 1
      }
    }
    
    # Loading the ground truth communities
    gt <- read.table(here("nodes.txt"), header=TRUE)
    gt_comm <- as.character(gt$truecomm)
    names(gt_comm) <- as.character(gt$node)
    
    # Solution 
    
    # Performing biclustering on the bi-adjacency matrix
    bic_res <- biclust(adj_mat, method=BCPlaid())
    
    # Assigning bicluster labels to rows (set1 nodes)
    row_bicluster <- rep(NA, nrow(adj_mat))
    names(row_bicluster) <- rownames(adj_mat)
    for(i in seq_along(row_bicluster)) {
      found <- FALSE
      for(b in 1:bic_res@Number) {
        val <- bic_res@RowxNumber[i, b]
        if(!is.na(val) && val) {
          row_bicluster[i] <- b
          found <- TRUE
          break
        }
      }
    }
    
    # Filtering only nodes in ground truth and bicluster result (set1 side)
    common <- intersect(names(row_bicluster), names(gt_comm))
    row_bicluster_clean <- row_bicluster[common]
    gt_comm_clean <- gt_comm[common]
    valid_idx <- !(is.na(row_bicluster_clean) | is.na(gt_comm_clean))
    row_bicluster_clean <- row_bicluster_clean[valid_idx]
    gt_comm_clean <- gt_comm_clean[valid_idx]
    order_idx <- order(names(row_bicluster_clean))
    row_bicluster_clean <- row_bicluster_clean[order_idx]
    gt_comm_clean <- gt_comm_clean[order_idx]
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Calculating NMI for biclustering
    if(length(row_bicluster_clean) > 0 && length(gt_comm_clean) > 0 &&
       length(unique(row_bicluster_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
      nmi_biclust <- NMI(partition_to_list(gt_comm_clean), partition_to_list(row_bicluster_clean))
      cat(sprintf("NMI for biclustering on the bi-adjacency matrix: %.4f\n", nmi_biclust))
    } else {
      cat("Cannot compute NMI for biclustering: check partitions\n")
    }
```

</details>

</details>

<details>
<summary>

## 40.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Take the multilayer network at http://www.networkatlas.eu/
    # exercises/40/1/data.txt. The third column tells you in which
    # layer the edge appears. Flatten it twice: first with unweighted
    # edges and then with the count of the number of layers in which
    # the edge appears. Which flattening scheme returns a higher NMI
    # with the partition in http://www.networkatlas.eu/exercises/40/
    # 1/nodes.txt? Use the asynchronous label percolation algorithm
    # (remember to pass the edge weight argument in the second case).
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    n_runs <- 10
    nmi_unweighted <- numeric(n_runs)
    nmi_weighted <- numeric(n_runs)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Take the multilayer network at http://www.networkatlas.eu/
    # exercises/40/1/data.txt. The third column tells you in which
    # layer the edge appears. Flatten it twice: first with unweighted
    # edges and then with the count of the number of layers in which
    # the edge appears. Which flattening scheme returns a higher NMI
    # with the partition in http://www.networkatlas.eu/exercises/40/
    # 1/nodes.txt? Use the asynchronous label percolation algorithm
    # (remember to pass the edge weight argument in the second case).
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    n_runs <- 10
    nmi_unweighted <- numeric(n_runs)
    nmi_weighted <- numeric(n_runs)
    
    # Solution 
    
    # Flattening the multilayer network without weights
    flat_edges_unweighted <- unique(data.frame(
      from = pmin(edges$from, edges$to),
      to = pmax(edges$from, edges$to)
    ))
    g_unweighted <- graph_from_data_frame(flat_edges_unweighted, directed=FALSE)
    
    # Flattening the multilayer network with edge weights (counting layers)
    edge_pairs <- data.frame(
      from = pmin(edges$from, edges$to),
      to = pmax(edges$from, edges$to)
    )
    edge_weights <- aggregate(layer ~ from + to, data = cbind(edge_pairs, layer=edges$layer), FUN=length)
    g_weighted <- graph_from_data_frame(edge_weights[,c("from", "to")], directed=FALSE)
    E(g_weighted)$weight <- edge_weights$layer
    
    # Running label propagation on unweighted flattened graph
    for(i in 1:n_runs) {
      lp_unweighted <- cluster_label_prop(g_unweighted)
      memb_unweighted <- membership(lp_unweighted)
      common <- intersect(names(memb_unweighted), names(gt_comm))
      memb_unweighted_clean <- memb_unweighted[common]
      gt_comm_clean <- gt_comm[common]
      valid_idx <- !(is.na(memb_unweighted_clean) | is.na(gt_comm_clean))
      memb_unweighted_clean <- memb_unweighted_clean[valid_idx]
      gt_comm_clean <- gt_comm_clean[valid_idx]
      order_idx <- order(names(memb_unweighted_clean))
      memb_unweighted_clean <- memb_unweighted_clean[order_idx]
      gt_comm_clean <- gt_comm_clean[order_idx]
      if(length(memb_unweighted_clean) > 0 && length(gt_comm_clean) > 0 &&
         length(unique(memb_unweighted_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
        nmi_unweighted[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_unweighted_clean))
      } else {
        nmi_unweighted[i] <- NA
      }
    }
    
    # Running label propagation on weighted flattened graph
    for(i in 1:n_runs) {
      lp_weighted <- cluster_label_prop(g_weighted, weights=E(g_weighted)$weight)
      memb_weighted <- membership(lp_weighted)
      common <- intersect(names(memb_weighted), names(gt_comm))
      memb_weighted_clean <- memb_weighted[common]
      gt_comm_clean <- gt_comm[common]
      valid_idx <- !(is.na(memb_weighted_clean) | is.na(gt_comm_clean))
      memb_weighted_clean <- memb_weighted_clean[valid_idx]
      gt_comm_clean <- gt_comm_clean[valid_idx]
      order_idx <- order(names(memb_weighted_clean))
      memb_weighted_clean <- memb_weighted_clean[order_idx]
      gt_comm_clean <- gt_comm_clean[order_idx]
      if(length(memb_weighted_clean) > 0 && length(gt_comm_clean) > 0 &&
         length(unique(memb_weighted_clean)) > 1 && length(unique(gt_comm_clean)) > 1) {
        nmi_weighted[i] <- NMI(partition_to_list(gt_comm_clean), partition_to_list(memb_weighted_clean))
      } else {
        nmi_weighted[i] <- NA
      }
    }
    
    # Calculating the average NMI for each flattening scheme
    avg_nmi_unweighted <- mean(nmi_unweighted, na.rm=TRUE)
    avg_nmi_weighted <- mean(nmi_weighted, na.rm=TRUE)
    
    cat(sprintf("Average NMI for unweighted flattening: %.4f\n", avg_nmi_unweighted))
    cat(sprintf("Average NMI for weighted flattening: %.4f\n", avg_nmi_weighted))
```

</details>

</details>

<details>
<summary>

## 40.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # separately. Build the |V| × |C| table, perform kMeans (setting k = 4)
    # on it to merge the communities. Does this return a higher NMI
    # when compared with the ground truth?
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Using the same network, perform label percolation on each layer
    # separately. Build the |V| × |C| table, perform kMeans (setting k = 4)
    # on it to merge the communities. Does this return a higher NMI
    # when compared with the ground truth?
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    partition_to_list <- function(membership) {
      split(names(membership), membership)
    }
    
    # Sourcing the NMI function
    source(here("OverlappingNMI.R"))
    
    # Solution 
    
    layers <- sort(unique(edges$layer))
    all_nodes <- unique(c(edges$from, edges$to))
    table_list <- list()
    community_count <- 0
    community_labels <- list()
    
    # Performing label propagation on each layer separately
    for(layer in layers) {
      # Filtering edges for the current layer
      layer_edges <- subset(edges, layer == !!layer)
      # Building the graph for the layer
      g_layer <- graph_from_data_frame(layer_edges[,c("from","to")], directed=FALSE)
      # Running label propagation
      lp_layer <- cluster_label_prop(g_layer)
      memb_layer <- membership(lp_layer)
      # Mapping communities to columns in the big table
      layer_comms <- unique(memb_layer)
      # For each community in this layer, create one column
      for(comm in layer_comms) {
        col <- rep(0, length(all_nodes))
        names(col) <- all_nodes
        col[names(memb_layer)[memb_layer == comm]] <- 1
        table_list[[length(table_list)+1]] <- col
        community_labels[[length(community_labels)+1]] <- paste("layer", layer, "comm", comm, sep="_")
        community_count <- community_count + 1
      }
    }
    
    # Building the |V| x |C| table
    table_mat <- do.call(cbind, table_list)
    rownames(table_mat) <- all_nodes
    colnames(table_mat) <- unlist(community_labels)
    
    # Performing kMeans clustering on the table
    set.seed(42)
    kmeans_res <- kmeans(table_mat, centers=4)
    kmeans_membership <- kmeans_res$cluster
    names(kmeans_membership) <- rownames(table_mat)
    
    # Filtering nodes present in ground truth
    common <- intersect(names(kmeans_membership), names(gt_comm))
    kmeans_membership_clean <- kmeans_membership[common]
    gt_comm_clean <- gt_comm[common]
    valid_idx <- !(is.na(kmeans_membership_clean) | is.na(gt_comm_clean))
    kmeans_membership_clean <- kmeans_membership_clean[valid_idx]
    gt_comm_clean <- gt_comm_clean[valid_idx]
    order_idx <- order(names(kmeans_membership_clean))
    kmeans_membership_clean <- kmeans_membership_clean[order_idx]
    gt_comm_clean <- gt_comm_clean[order_idx]
    
    # Calculating NMI for kMeans clustering
    nmi_kmeans <- NMI(partition_to_list(gt_comm_clean), partition_to_list(kmeans_membership_clean))
    cat(sprintf("NMI for kMeans clustering on label propagation results: %.4f\n", nmi_kmeans))
```

</details>

</details>

<details>
<summary>

## 40.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the redundancy of each community you found for the
    # previous exercises.
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the redundancy of each community you found for the
    # previous exercises.
    
    library(here)
    library(igraph)
    
    # Loading the multilayer edge list
    edges <- read.table(here("data.txt"))
    colnames(edges) <- c("from", "to", "layer")
    edges$from <- as.character(edges$from)
    edges$to <- as.character(edges$to)
    
    # Loading the ground truth partition
    nodes <- read.table(here("nodes.txt"))
    gt_comm <- as.character(nodes$V2)
    names(gt_comm) <- as.character(nodes$V1)
    
    # Solution 
    
    # Building the weighted flattened network
    edge_pairs <- data.frame(
      from = pmin(edges$from, edges$to),
      to = pmax(edges$from, edges$to)
    )
    edge_weights <- aggregate(layer ~ from + to, data = cbind(edge_pairs, layer=edges$layer), FUN=length)
    g_weighted <- graph_from_data_frame(edge_weights[,c("from", "to")], directed=FALSE)
    E(g_weighted)$weight <- edge_weights$layer
    
    # Running label propagation to get communities
    lp_weighted <- cluster_label_prop(g_weighted, weights=E(g_weighted)$weight)
    memb <- membership(lp_weighted)
    
    # Calculating redundancy for each community
    communities <- unique(memb)
    redundancy <- numeric(length(communities))
    
    for (i in seq_along(communities)) {
      comm <- communities[i]
      comm_nodes <- names(memb)[memb == comm]
      subgraph <- induced_subgraph(g_weighted, comm_nodes)
      # Getting the edge weights for the subgraph
      weights_vec <- E(subgraph)$weight
      # Calculating redundancy: average number of layers per edge in the community
      if (length(weights_vec) > 0) {
        redundancy[i] <- mean(weights_vec)
      } else {
        redundancy[i] <- NA
      }
    }
    
    # Printing redundancy for each community
    for (i in seq_along(communities)) {
      cat(sprintf("Redundancy for community %s: %.2f\n", communities[i], redundancy[i]))
    }
```

</details>

</details>

<details>
<summary>

## 41.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Test whether the motifs in http://www.networkatlas.eu/exercises/
    # 41/1/motif1.txt, http://www.networkatlas.eu/exercises/41/
    # 1/motif2.txt, http://www.networkatlas.eu/exercises/41/1/
    # motif3.txt, and http://www.networkatlas.eu/exercises/41/1/
    # motif4.txt appear in the network at http://www.networkatlas.
    # eu/exercises/41/1/data.txt.
    
    library(igraph)
    library(here)
    
    # Loading the network data from the file
    network_data <- read.table(here("data.txt"), header = FALSE)
    # Building the graph from the edge list
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Defining motif1 edge list and building the motif graph
    motif1_edges <- matrix(c(1,2, 1,3), ncol=2, byrow=TRUE)
    motif1 <- graph_from_edgelist(motif1_edges, directed=FALSE)
    
    # Defining motif2 edge list and building the motif graph
    motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
    motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)
    
    # Defining motif3 edge list and building the motif graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Defining motif4 edge list and building the motif graph
    motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Test whether the motifs in http://www.networkatlas.eu/exercises/
    # 41/1/motif1.txt, http://www.networkatlas.eu/exercises/41/
    # 1/motif2.txt, http://www.networkatlas.eu/exercises/41/1/
    # motif3.txt, and http://www.networkatlas.eu/exercises/41/1/
    # motif4.txt appear in the network at http://www.networkatlas.
    # eu/exercises/41/1/data.txt.
    
    library(igraph)
    library(here)
    
    # Loading the network data from the file
    network_data <- read.table(here("data.txt"), header = FALSE)
    # Building the graph from the edge list
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Defining motif1 edge list and building the motif graph
    motif1_edges <- matrix(c(1,2, 1,3), ncol=2, byrow=TRUE)
    motif1 <- graph_from_edgelist(motif1_edges, directed=FALSE)
    
    # Defining motif2 edge list and building the motif graph
    motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
    motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)
    
    # Defining motif3 edge list and building the motif graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Defining motif4 edge list and building the motif graph
    motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)
    
    # Solution 
    
    # Getting the adjacency matrices for motifs
    motif1_mat <- as.matrix(get.adjacency(motif1))
    motif2_mat <- as.matrix(get.adjacency(motif2))
    motif3_mat <- as.matrix(get.adjacency(motif3))
    motif4_mat <- as.matrix(get.adjacency(motif4))
    
    # Defining a function to check for motif appearances
    find_motif <- function(graph, motif_graph) {
      # Searching for the motif in the network
      count <- count_subgraph_isomorphisms(motif_graph, graph)
      return(count)
    }
    
    # Checking for each motif in the network
    cat("motif1 appears", find_motif(g, motif1), "times\n")
    cat("motif2 appears", find_motif(g, motif2), "times\n")
    cat("motif3 appears", find_motif(g, motif3), "times\n")
    cat("motif4 appears", find_motif(g, motif4), "times\n")
```

</details>

</details>

<details>
<summary>

## 41.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # How many times do the motifs from the previous question ap-
    # pear in the network? http://www.networkatlas.eu/exercises/
    # 41/1/motif2.txt is included in http://www.networkatlas.eu/
    # exercises/41/1/motif3.txt: is the latter less frequent the former
    # as we would require in an anti-monotonic counting function?
    
    library(igraph)
    library(here)
    
    # Loading the network data from the file
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Building motif2 graph
    motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
    motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)
    
    # Building motif3 graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # How many times do the motifs from the previous question ap-
    # pear in the network? http://www.networkatlas.eu/exercises/
    # 41/1/motif2.txt is included in http://www.networkatlas.eu/
    # exercises/41/1/motif3.txt: is the latter less frequent the former
    # as we would require in an anti-monotonic counting function?
    
    library(igraph)
    library(here)
    
    # Loading the network data from the file
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Building motif2 graph
    motif2_edges <- matrix(c(1,2, 1,3, 2,3), ncol=2, byrow=TRUE)
    motif2 <- graph_from_edgelist(motif2_edges, directed=FALSE)
    
    # Building motif3 graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Solution 
    
    # Counting how many times motif2 appears in the network
    motif2_count <- count_subgraph_isomorphisms(motif2, g)
    
    # Counting how many times motif3 appears in the network
    motif3_count <- count_subgraph_isomorphisms(motif3, g)
    
    # Printing the results
    cat("motif2 appears", motif2_count, "times\n")
    cat("motif3 appears", motif3_count, "times\n")
    
    # Checking if motif3 is less frequent than motif2 as required by anti-monotonic counting
    if (motif3_count < motif2_count) {
      cat("motif3 is less frequent than motif2, as required by an anti-monotonic counting function\n")
    } else {
      cat("motif3 is NOT less frequent than motif2\n")
    }
```

</details>

</details>

<details>
<summary>

## 41.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Suppose you define a new type of clustering coefficient that is
    # closing http://www.networkatlas.eu/exercises/41/1/motif3.
    # txt with http://www.networkatlas.eu/exercises/41/1/motif4.
    # txt. What would be the value of this special clustering coefficient
    # in the network?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Building motif3 graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Building motif4 graph
    motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Suppose you define a new type of clustering coefficient that is
    # closing http://www.networkatlas.eu/exercises/41/1/motif3.
    # txt with http://www.networkatlas.eu/exercises/41/1/motif4.
    # txt. What would be the value of this special clustering coefficient
    # in the network?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Building motif3 graph
    motif3_edges <- matrix(c(1,2, 1,3, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif3 <- graph_from_edgelist(motif3_edges, directed=FALSE)
    
    # Building motif4 graph
    motif4_edges <- matrix(c(1,2, 1,3, 1,4, 2,3, 3,4), ncol=2, byrow=TRUE)
    motif4 <- graph_from_edgelist(motif4_edges, directed=FALSE)
    
    # Solution 
    
    # Counting motif3 appearances in the network
    motif3_count <- count_subgraph_isomorphisms(motif3, g)
    
    # Counting motif4 appearances in the network
    motif4_count <- count_subgraph_isomorphisms(motif4, g)
    
    # Calculating the special clustering coefficient
    # This is the fraction of motif3 that are closed as motif4
    if (motif3_count > 0) {
      special_clustering_coeff <- motif4_count / motif3_count
    } else {
      special_clustering_coeff <- NA
    }
    
    # Printing the value of the special clustering coefficient
    cat("The value of the special clustering coefficient is", special_clustering_coeff, "\n")
```

</details>

</details>

<details>
<summary>

## 42.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Build a 2D node embedding for the network at http://www.
    # networkatlas.eu/exercises/42/1/data.txt. You should build
    # it by taking the first two singular values of the D −1/2 AD −1/2
    # matrix.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Build a 2D node embedding for the network at http://www.
    # networkatlas.eu/exercises/42/1/data.txt. You should build
    # it by taking the first two singular values of the D −1/2 AD −1/2
    # matrix.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Solution 
    
    # Getting the adjacency matrix
    A <- as.matrix(get.adjacency(g))
    
    # Getting the degree vector
    deg <- rowSums(A)
    
    # Building the D^{-1/2} matrix
    D_inv_sqrt <- diag(1 / sqrt(deg))
    
    # Building the normalized adjacency matrix
    norm_adj <- D_inv_sqrt %*% A %*% D_inv_sqrt
    
    # Performing singular value decomposition
    svd_result <- svd(norm_adj)
    
    # Taking the first two singular vectors for embedding
    embedding <- svd_result$u[, 1:2]
    
    # Printing the embedding coordinates
    print(embedding)
```

</details>

</details>

<details>
<summary>

## 42.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the embeddings you obtained from the previous exercise
    # with the ones you get by taking the second and third eigenvectors
    # of ( I − A) T ( I − A). Which one has the lowest loss according to
    # 
    # 2
    # ∑ Zu − ∑ Zv Auv ?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the embeddings you obtained from the previous exercise
    # with the ones you get by taking the second and third eigenvectors
    # of ( I − A) T ( I − A). Which one has the lowest loss according to
    # 
    # 2
    # ∑ Zu − ∑ Zv Auv ?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Solution 
    
    # Getting the adjacency matrix
    A <- as.matrix(get.adjacency(g))
    
    # Getting the degree vector
    deg <- rowSums(A)
    
    # Building the D^{-1/2} matrix
    D_inv_sqrt <- diag(1 / sqrt(deg))
    
    # Building the normalized adjacency matrix
    norm_adj <- D_inv_sqrt %*% A %*% D_inv_sqrt
    
    # Performing singular value decomposition
    svd_result <- svd(norm_adj)
    
    # Taking the first two singular vectors for embedding
    embedding_svd <- svd_result$u[, 1:2]
    
    # Building the (I - A) matrix
    I <- diag(nrow(A))
    I_minus_A <- I - A
    
    # Computing (I - A)^T (I - A)
    mat <- t(I_minus_A) %*% I_minus_A
    
    # Computing eigen decomposition
    eig_result <- eigen(mat)
    
    # Taking the second and third eigenvectors for embedding
    embedding_eigen <- eig_result$vectors[, 2:3]
    
    # Defining a function to compute the loss from the formula in image1
    compute_loss <- function(Z, A) {
      loss <- 0
      for (u in 1:nrow(A)) {
        Zu <- Z[u, ]
        Av <- A[u, ]
        Zv_Auv <- colSums(t(Z) * Av)
        diff <- Zu - Zv_Auv
        loss <- loss + sum(diff^2)
      }
      return(loss)
    }
    
    # Calculating the loss for both embeddings
    loss_svd <- compute_loss(embedding_svd, A)
    loss_eigen <- compute_loss(embedding_eigen, A)
    
    # Printing the losses to compare
    cat("Loss for SVD embedding:", loss_svd, "\n")
    cat("Loss for eigenvector embedding:", loss_eigen, "\n")
    
    if (loss_svd < loss_eigen) {
      cat("SVD embedding has the lowest loss\n")
    } else {
      cat("Eigenvector embedding has the lowest loss\n")
    }
```

</details>

</details>

<details>
<summary>

## 42.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the embeddings you obtained from the previous two
    # exercises with the ones you get by taking the first two eigenvectors
    # of D −1/2 LD −1/2 . Which one has the lowest loss according to
    # 1
    # 2
    # ∑ ( Zu − Zv ) Auv ?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the embeddings you obtained from the previous two
    # exercises with the ones you get by taking the first two eigenvectors
    # of D −1/2 LD −1/2 . Which one has the lowest loss according to
    # 1
    # 2
    # ∑ ( Zu − Zv ) Auv ?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    network_data <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(network_data), directed = FALSE)
    
    # Solution
    
    # Getting the adjacency matrix
    A <- as.matrix(get.adjacency(g))
    
    # Getting the degree vector
    deg <- rowSums(A)
    
    # Building the D^{-1/2} matrix
    D_inv_sqrt <- diag(1 / sqrt(deg))
    
    # Building the normalized adjacency matrix
    norm_adj <- D_inv_sqrt %*% A %*% D_inv_sqrt
    
    # Performing singular value decomposition for SVD embedding
    svd_result <- svd(norm_adj)
    embedding_svd <- svd_result$u[, 1:2]
    
    # Building the (I - A) matrix and getting (I - A)^T (I - A)
    I <- diag(nrow(A))
    I_minus_A <- I - A
    mat <- t(I_minus_A) %*% I_minus_A
    eig_result <- eigen(mat)
    embedding_eigen <- eig_result$vectors[, 2:3]
    
    # Building the Laplacian matrix
    D <- diag(deg)
    L <- D - A
    
    # Building the normalized Laplacian
    norm_lap <- D_inv_sqrt %*% L %*% D_inv_sqrt
    
    # Getting the first two eigenvectors for Laplacian embedding
    lap_eig <- eigen(norm_lap)
    embedding_lap <- lap_eig$vectors[, 1:2]
    
    # Defining the loss function from image2
    compute_loss_laplacian <- function(Z, A) {
      loss <- 0
      for (u in 1:nrow(A)) {
        for (v in 1:nrow(A)) {
          if (A[u, v] != 0) {
            diff <- Z[u, ] - Z[v, ]
            loss <- loss + sum(diff^2) * A[u, v]
          }
        }
      }
      return(loss / 2)
    }
    
    # Calculating the loss for all three embeddings
    loss_svd <- compute_loss_laplacian(embedding_svd, A)
    loss_eigen <- compute_loss_laplacian(embedding_eigen, A)
    loss_lap <- compute_loss_laplacian(embedding_lap, A)
    
    # Printing the losses to compare
    cat("Loss for SVD embedding:", loss_svd, "\n")
    cat("Loss for eigenvector embedding:", loss_eigen, "\n")
    cat("Loss for Laplacian embedding:", loss_lap, "\n")
    
    if (loss_svd < loss_eigen & loss_svd < loss_lap) {
      cat("SVD embedding has the lowest loss\n")
    } else if (loss_eigen < loss_svd & loss_eigen < loss_lap) {
      cat("Eigenvector embedding has the lowest loss\n")
    } else {
      cat("Laplacian embedding has the lowest loss\n")
    }
```

</details>

</details>

<details>
<summary>

## 43.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform 10, 000 random walks of length 6 in the network at
    # http://www.networkatlas.eu/exercises/43/1/data.txt. Build
    # embeddings with d = 32 using Word2Vec (I suggest using the
    # gensim implementation). Reduce them to two dimensions using
    # sklearn.manifold.TSNE. Visualize the network by using the 2D
    # embeddings as spatial coordinates. Use http://www.networkatlas.
    # eu/exercises/43/1/nodes.txt to determine the node colors.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    
    # Loading the edge list
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the undirected graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform 10, 000 random walks of length 6 in the network at
    # http://www.networkatlas.eu/exercises/43/1/data.txt. Build
    # embeddings with d = 32 using Word2Vec (I suggest using the
    # gensim implementation). Reduce them to two dimensions using
    # sklearn.manifold.TSNE. Visualize the network by using the 2D
    # embeddings as spatial coordinates. Use http://www.networkatlas.
    # eu/exercises/43/1/nodes.txt to determine the node colors.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    
    # Loading the edge list
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the undirected graph
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # This should be the solution 
    
    # Performing random walks
    set.seed(42)
    walk_length <- 6
    n_walks <- 10000
    walks <- vector("list", n_walks)
    
    for (i in seq_len(n_walks)) {
      start_node <- sample(nodes, 1)
      walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
      walks[[i]] <- as.character(walk)
    }
    
    # Saving walks to a text file for wordVectors
    walks_char <- sapply(walks, paste, collapse = " ")
    walks_file <- here("walks.txt")
    writeLines(walks_char, walks_file)
    
    # Training Word2Vec model with d = 32
    embedding_file <- here("walks.bin")
    train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)
    
    # Loading embeddings
    embeddings <- read.vectors(embedding_file)
    
    # Getting the matrix of embeddings for all nodes in the graph
    nodes_in_embedding <- intersect(nodes, rownames(embeddings))
    X <- embeddings[nodes_in_embedding, ]
    
    # Reducing to two dimensions using t-SNE
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    
    # Loading node categories
    nodes_info <- fread(here("nodes.txt"), header = FALSE)
    colnames(nodes_info) <- c("node", "category")
    nodes_info$node <- as.character(nodes_info$node)
    embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)
    
    # Visualizing the network using 2D embeddings as coordinates and coloring by node category
    ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(category))) +
      geom_point(size = 2) +
      labs(title = "Network Visualization using Word2Vec Embeddings (t-SNE Reduced)",
           x = "t-SNE 1", y = "t-SNE 2", color = "Node Category") +
      theme_minimal()
```

</details>

</details>

<details>
<summary>

## 43.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the Word2Vec embeddings reduced to 2D with tSNE you
    # found in the previous exercise to find 4 clusters in the data using
    # any clustering algorithm (if kMeans, set k = 4, otherwise you can
    # use DBSCAN and find the eps parameter giving you 4 clusters).
    # What is the NMI (use the sklearn function to calculate it) of
    # the clusters with the ground truth you can find at http://www.
    # networkatlas.eu/exercises/43/1/nodes.txt?
    
    library(here)
    library(data.table)
    library(ggplot2)
    library(stats)
    library(Rtsne)
    library(wordVectors)
    library(cluster)
    
    # Loading the 2D embeddings from the previous exercise
    embedding_file <- here("walks.bin")
    embeddings <- read.vectors(embedding_file)
    
    # Getting the matrix of embeddings for all nodes
    nodes_in_embedding <- rownames(embeddings)
    X <- embeddings[nodes_in_embedding, ]
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    
    # Loading node categories
    nodes_info <- fread(here("nodes.txt"), header = FALSE)
    colnames(nodes_info) <- c("node", "category")
    nodes_info$node <- as.character(nodes_info$node)
    embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the Word2Vec embeddings reduced to 2D with tSNE you
    # found in the previous exercise to find 4 clusters in the data using
    # any clustering algorithm (if kMeans, set k = 4, otherwise you can
    # use DBSCAN and find the eps parameter giving you 4 clusters).
    # What is the NMI (use the sklearn function to calculate it) of
    # the clusters with the ground truth you can find at http://www.
    # networkatlas.eu/exercises/43/1/nodes.txt?
    
    library(here)
    library(data.table)
    library(ggplot2)
    library(stats)
    library(Rtsne)
    library(wordVectors)
    library(cluster)
    
    # Loading the 2D embeddings from the previous exercise
    embedding_file <- here("walks.bin")
    embeddings <- read.vectors(embedding_file)
    
    # Getting the matrix of embeddings for all nodes
    nodes_in_embedding <- rownames(embeddings)
    X <- embeddings[nodes_in_embedding, ]
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    
    # Loading node categories
    nodes_info <- fread(here("nodes.txt"), header = FALSE)
    colnames(nodes_info) <- c("node", "category")
    nodes_info$node <- as.character(nodes_info$node)
    embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)
    
    # This should be the solution 
    
    # Finding 4 clusters using kmeans
    set.seed(42)
    kmeans_result <- kmeans(embedding_2d[, c("V1", "V2")], centers = 4)
    embedding_2d$cluster <- kmeans_result$cluster
    
    # Saving clustering assignments and ground truth for Python NMI calculation
    fwrite(embedding_2d[, .(node, cluster, category)], here("clustering_result.csv"))
    
    # Calculating NMI with sklearn in Python
    # You can run the following Python snippet in the same folder:
    # import pandas as pd
    # from sklearn.metrics import normalized_mutual_info_score
    # df = pd.read_csv("clustering_result.csv")
    # nmi = normalized_mutual_info_score(df['category'], df['cluster'])
    # print("NMI:", nmi)
    
    # Visualizing the clusters
    ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(cluster))) +
      geom_point(size = 2) +
      labs(title = "t-SNE Embeddings Clustered (kMeans, k=4)", x = "t-SNE 1", y = "t-SNE 2", color = "Cluster") +
      theme_minimal()
```

</details>

</details>

<details>
<summary>

## 43.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Compare the NMI score from the previous exercise to the one
    # you would get from a classical community discovery like label
    # propagation. Note: both methods are randomized, so you could
    # perform them multiple times and see the distributions of their
    # NMIs.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Compare the NMI score from the previous exercise to the one
    # you would get from a classical community discovery like label
    # propagation. Note: both methods are randomized, so you could
    # perform them multiple times and see the distributions of their
    # NMIs.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # This is a idea of solution 
    
    # Getting the node names
    nodes <- V(g)$name
    
    # Performing random walks
    set.seed(42)
    walk_length <- 6
    n_walks <- 10000
    walks <- vector("list", n_walks)
    for (i in seq_len(n_walks)) {
      start_node <- sample(nodes, 1)
      walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
      walks[[i]] <- as.character(walk)
    }
    
    # Saving the walks
    walks_char <- sapply(walks, paste, collapse = " ")
    walks_file <- here("walks.txt")
    writeLines(walks_char, walks_file)
    
    # Training Word2Vec model with d = 32
    embedding_file <- here("walks.bin")
    train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)
    
    # Loading the embeddings
    embeddings <- read.vectors(embedding_file)
    nodes_in_embedding <- rownames(embeddings)
    X <- embeddings[nodes_in_embedding, ]
    
    # Reducing to two dimensions using t-SNE
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    
    # Loading node categories
    nodes_info <- fread(here("nodes.txt"), header = FALSE)
    colnames(nodes_info) <- c("node", "category")
    nodes_info$node <- as.character(nodes_info$node)
    embedding_2d <- merge(embedding_2d, nodes_info, by = "node", all.x = TRUE)
    
    # Performing k-means clustering
    set.seed(42)
    kmeans_result <- kmeans(embedding_2d[, c("V1", "V2")], centers = 4)
    embedding_2d$cluster <- kmeans_result$cluster
    
    # Preparing the clustering cover and ground truth cover for NMI
    clustering_cover <- lapply(1:4, function(k) embedding_2d$node[embedding_2d$cluster == k])
    ground_truth_cover <- lapply(sort(unique(embedding_2d$category)), function(k) embedding_2d$node[embedding_2d$category == k])
    
    # Sourcing the NMI library
    source(here("NMI.R"))
    
    # Calculating NMI between k-means clusters and ground truth
    nmi_kmeans <- NMI(clustering_cover, ground_truth_cover)
    cat("NMI (k-means):", nmi_kmeans, "\n")
    
    # Performing label propagation for community detection
    set.seed(42)
    lp <- label_propagation_community(g)
    lp_membership <- membership(lp)
    lp_cover <- lapply(sort(unique(lp_membership)), function(c) names(lp_membership)[lp_membership == c])
    
    # Calculating NMI between label propagation and ground truth
    nmi_labelprop <- NMI(lp_cover, ground_truth_cover)
    cat("NMI (label propagation):", nmi_labelprop, "\n")
    
    # Visualizing the clusters from both methods
    embedding_2d$lp_cluster <- lp_membership[embedding_2d$node]
    ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(cluster))) +
      geom_point(size = 2) +
      labs(title = "t-SNE Embeddings Clustered (kMeans, k=4)", x = "t-SNE 1", y = "t-SNE 2", color = "kMeans Cluster") +
      theme_minimal()
    
    ggplot(embedding_2d, aes(x = V1, y = V2, color = as.factor(lp_cluster))) +
      geom_point(size = 2) +
      labs(title = "t-SNE Embeddings Clustered (Label Propagation)", x = "t-SNE 1", y = "t-SNE 2", color = "Label Propagation Cluster") +
      theme_minimal()
```

</details>

</details>

<details>
<summary>

## 43.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Use the Word2Vec embeddings reduced to 2D with tSNE you
    # found in the previous exercise as a link prediction score (if Zu and
    # Zv are node embeddings, then the score for edge u, v is ZuT Zv ).
    # Draw the ROC curve of your predictions, assuming that the true
    # new edges are the ones you can find in http://www.networkatlas.
    # eu/exercises/43/4/newedges.txt.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    library(pROC)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Use the Word2Vec embeddings reduced to 2D with tSNE you
    # found in the previous exercise as a link prediction score (if Zu and
    # Zv are node embeddings, then the score for edge u, v is ZuT Zv ).
    # Draw the ROC curve of your predictions, assuming that the true
    # new edges are the ones you can find in http://www.networkatlas.
    # eu/exercises/43/4/newedges.txt.
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    library(pROC)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # This is a idea of solution  
    
    # Performing random walks
    set.seed(42)
    walk_length <- 6
    n_walks <- 10000
    walks <- vector("list", n_walks)
    for (i in seq_len(n_walks)) {
      start_node <- sample(nodes, 1)
      walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
      walks[[i]] <- as.character(walk)
    }
    
    # Saving the walks
    walks_char <- sapply(walks, paste, collapse = " ")
    walks_file <- here("walks.txt")
    writeLines(walks_char, walks_file)
    
    # Training Word2Vec model with d = 32
    embedding_file <- here("walks.bin")
    train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)
    
    # Loading the embeddings
    embeddings <- read.vectors(embedding_file)
    nodes_in_embedding <- rownames(embeddings)
    X <- embeddings[nodes_in_embedding, ]
    
    # Reducing to two dimensions using t-SNE
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    rownames(embedding_2d) <- embedding_2d$node
    
    # Loading the new edges for link prediction
    new_edges <- fread(here("newedges.txt"), header = FALSE)
    colnames(new_edges) <- c("u", "v")
    new_edges$u <- as.character(new_edges$u)
    new_edges$v <- as.character(new_edges$v)
    
    # Preparing positive samples (new edges)
    positive_edges <- new_edges[
      new_edges$u %in% embedding_2d$node & new_edges$v %in% embedding_2d$node, ]
    
    # Sampling negative edges (node pairs not connected and not in newedges)
    existing_edges <- as.data.table(get.edgelist(g))
    existing_edges$V1 <- as.character(existing_edges$V1)
    existing_edges$V2 <- as.character(existing_edges$V2)
    
    all_possible <- CJ(u=embedding_2d$node, v=embedding_2d$node)[u < v]
    all_possible <- all_possible[!paste(u, v) %in% paste(existing_edges$V1, existing_edges$V2)]
    all_possible <- all_possible[!paste(u, v) %in% paste(positive_edges$u, positive_edges$v)]
    
    set.seed(42)
    negative_edges <- all_possible[sample(.N, nrow(positive_edges))]
    
    # Combining positive and negative edges for predictions
    test_edges <- rbind(
      data.table(u = positive_edges$u, v = positive_edges$v, label = 1),
      data.table(u = negative_edges$u, v = negative_edges$v, label = 0)
    )
    
    # Computing link prediction scores using 2D t-SNE embeddings
    score <- function(u, v, emb) {
      sum(emb[u, c("V1", "V2")] * emb[v, c("V1", "V2")])
    }
    test_edges$score <- mapply(score, test_edges$u, test_edges$v, MoreArgs = list(emb = embedding_2d))
    
    # Drawing the ROC curve
    roc_obj <- roc(test_edges$label, test_edges$score)
    plot(roc_obj, main = "ROC Curve for Link Prediction (t-SNE embeddings)")
    cat("AUC:", auc(roc_obj), "\n")
```

</details>

</details>

<details>
<summary>

## 43.7.5

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Is the AUC you get from the previous question better or worse
    # than the one you’d get from a classical link prediction like Jaccard,
    # Resource Allocation, Preferential Attachment, or Adamic-Adar?
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    library(pROC)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Is the AUC you get from the previous question better or worse
    # than the one you’d get from a classical link prediction like Jaccard,
    # Resource Allocation, Preferential Attachment, or Adamic-Adar?
    
    library(here)
    library(data.table)
    library(igraph)
    library(wordVectors)
    library(Rtsne)
    library(ggplot2)
    library(pROC)
    
    # Loading the edge list and building the graph
    edges <- fread(here("data.txt"), header = FALSE)
    colnames(edges) <- c("from", "to")
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Getting the node names
    nodes <- V(g)$name
    
    # This is a idea of solution 
    
    # Performing random walks
    set.seed(42)
    walk_length <- 6
    n_walks <- 10000
    walks <- vector("list", n_walks)
    for (i in seq_len(n_walks)) {
      start_node <- sample(nodes, 1)
      walk <- random_walk(g, start_node, steps = walk_length, mode = "all")
      walks[[i]] <- as.character(walk)
    }
    
    # Saving the walks
    walks_char <- sapply(walks, paste, collapse = " ")
    walks_file <- here("walks.txt")
    writeLines(walks_char, walks_file)
    
    # Training Word2Vec model with d = 32
    embedding_file <- here("walks.bin")
    train_word2vec(walks_file, embedding_file, vectors = 32, threads = 2, window = 4, min_count = 1, force = TRUE)
    
    # Loading the embeddings
    embeddings <- read.vectors(embedding_file)
    nodes_in_embedding <- rownames(embeddings)
    X <- embeddings[nodes_in_embedding, ]
    
    # Reducing to two dimensions using t-SNE
    set.seed(42)
    tsne_result <- Rtsne(as.matrix(X), dims = 2)
    embedding_2d <- as.data.frame(tsne_result$Y)
    embedding_2d$node <- nodes_in_embedding
    rownames(embedding_2d) <- embedding_2d$node
    
    # Loading the new edges for link prediction
    new_edges <- fread(here("newedges.txt"), header = FALSE)
    colnames(new_edges) <- c("u", "v")
    new_edges$u <- as.character(new_edges$u)
    new_edges$v <- as.character(new_edges$v)
    
    # Preparing positive samples (new edges)
    positive_edges <- new_edges[
      new_edges$u %in% embedding_2d$node & new_edges$v %in% embedding_2d$node, ]
    
    # Sampling negative edges (node pairs not connected and not in newedges)
    existing_edges <- as.data.table(get.edgelist(g))
    existing_edges$V1 <- as.character(existing_edges$V1)
    existing_edges$V2 <- as.character(existing_edges$V2)
    
    all_possible <- CJ(u=embedding_2d$node, v=embedding_2d$node)[u < v]
    all_possible <- all_possible[!paste(u, v) %in% paste(existing_edges$V1, existing_edges$V2)]
    all_possible <- all_possible[!paste(u, v) %in% paste(positive_edges$u, positive_edges$v)]
    
    set.seed(42)
    negative_edges <- all_possible[sample(.N, nrow(positive_edges))]
    
    # Combining positive and negative edges for predictions
    test_edges <- rbind(
      data.table(u = positive_edges$u, v = positive_edges$v, label = 1),
      data.table(u = negative_edges$u, v = negative_edges$v, label = 0)
    )
    
    # Computing link prediction scores using 2D t-SNE embeddings
    score_tsne <- function(u, v, emb) {
      sum(emb[u, c("V1", "V2")] * emb[v, c("V1", "V2")])
    }
    test_edges$score_tsne <- mapply(score_tsne, test_edges$u, test_edges$v, MoreArgs = list(emb = embedding_2d))
    
    # Calculating AUC for t-SNE embeddings
    roc_tsne <- roc(test_edges$label, test_edges$score_tsne)
    auc_tsne <- auc(roc_tsne)
    
    # Calculating Jaccard scores
    test_edges$jaccard <- mapply(function(u, v) {
      neighbors_u <- neighbors(g, u)
      neighbors_v <- neighbors(g, v)
      length(intersect(neighbors_u, neighbors_v)) / length(union(neighbors_u, neighbors_v))
    }, test_edges$u, test_edges$v)
    roc_jaccard <- roc(test_edges$label, test_edges$jaccard)
    auc_jaccard <- auc(roc_jaccard)
    
    # Calculating Resource Allocation scores
    test_edges$ra <- mapply(function(u, v) {
      neighbors_u <- neighbors(g, u)
      neighbors_v <- neighbors(g, v)
      common <- intersect(neighbors_u, neighbors_v)
      sum(1 / degree(g, common))
    }, test_edges$u, test_edges$v)
    roc_ra <- roc(test_edges$label, test_edges$ra)
    auc_ra <- auc(roc_ra)
    
    # Calculating Preferential Attachment scores
    test_edges$pa <- mapply(function(u, v) {
      degree(g, u) * degree(g, v)
    }, test_edges$u, test_edges$v)
    roc_pa <- roc(test_edges$label, test_edges$pa)
    auc_pa <- auc(roc_pa)
    
    # Calculating Adamic-Adar scores
    test_edges$aa <- mapply(function(u, v) {
      neighbors_u <- neighbors(g, u)
      neighbors_v <- neighbors(g, v)
      common <- intersect(neighbors_u, neighbors_v)
      sum(1 / log(degree(g, common)))
    }, test_edges$u, test_edges$v)
    roc_aa <- roc(test_edges$label, test_edges$aa)
    auc_aa <- auc(roc_aa)
    
    # Plotting ROC curves
    plot(roc_tsne, col="red", main="ROC Curves for Link Prediction Methods")
    plot(roc_jaccard, col="blue", add=TRUE)
    plot(roc_ra, col="green", add=TRUE)
    plot(roc_pa, col="purple", add=TRUE)
    plot(roc_aa, col="orange", add=TRUE)
    legend("bottomright",
           legend=c(
             paste("t-SNE Embeddings (AUC =", round(auc_tsne,3), ")"),
             paste("Jaccard (AUC =", round(auc_jaccard,3), ")"),
             paste("Resource Allocation (AUC =", round(auc_ra,3), ")"),
             paste("Pref. Attachment (AUC =", round(auc_pa,3), ")"),
             paste("Adamic-Adar (AUC =", round(auc_aa,3), ")")
           ),
           col=c("red","blue","green","purple","orange"), lwd=2, cex=0.9
    )
    
    cat("AUC t-SNE Embeddings:", auc_tsne, "\n")
    cat("AUC Jaccard:", auc_jaccard, "\n")
    cat("AUC Resource Allocation:", auc_ra, "\n")
    cat("AUC Preferential Attachment:", auc_pa, "\n")
    cat("AUC Adamic-Adar:", auc_aa, "\n")
```

</details>

</details>

<details>
<summary>

## 44.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement the MPGNN described in Section 44.1. You need to
    # define an “aggregate” function which takes a list of nodes and
    # their embeddings and returns the element-wise mean of those
    # embeddings. You need to define an “update” function which takes
    # two vectors, sums them, and return their softmax. Finally, you
    # need a message-passing function which loops over all nodes of the
    # network, applies aggregate to its neighbors, and applies update
    # with the result of the aggregation and the node’s embedding. Run
    # a single layer of it on the network at http://www.networkatlas.
    # eu/exercises/44/1/network.txt, with node features at http:
    # //www.networkatlas.eu/exercises/44/1/features.txt. Do you
    # get the same results as Figure 44.1?
    
    library(here)
    library(Matrix)
    
    # Loading the node features
    features <- as.matrix(read.table(here("features.txt")))
    
    # Loading the edge list and building the graph
    edges <- as.matrix(read.table(here("network.txt")))
    num_nodes <- nrow(features)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement the MPGNN described in Section 44.1. You need to
    # define an “aggregate” function which takes a list of nodes and
    # their embeddings and returns the element-wise mean of those
    # embeddings. You need to define an “update” function which takes
    # two vectors, sums them, and return their softmax. Finally, you
    # need a message-passing function which loops over all nodes of the
    # network, applies aggregate to its neighbors, and applies update
    # with the result of the aggregation and the node’s embedding. Run
    # a single layer of it on the network at http://www.networkatlas.
    # eu/exercises/44/1/network.txt, with node features at http:
    # //www.networkatlas.eu/exercises/44/1/features.txt. Do you
    # get the same results as Figure 44.1?
    
    library(here)
    library(Matrix)
    
    # Loading the node features
    features <- as.matrix(read.table(here("features.txt")))
    
    # Loading the edge list and building the graph
    edges <- as.matrix(read.table(here("network.txt")))
    num_nodes <- nrow(features)
    
    # Solution 
    
    # Creating adjacency list
    adj_list <- vector("list", num_nodes)
    for (i in seq_len(nrow(edges))) {
      src <- edges[i, 1] + 1
      tgt <- edges[i, 2] + 1
      adj_list[[src]] <- c(adj_list[[src]], tgt)
      adj_list[[tgt]] <- c(adj_list[[tgt]], src)
    }
    
    # Defining the aggregate function (element-wise mean)
    aggregate <- function(neighbors, embeddings) {
      if (length(neighbors) == 0) {
        return(rep(0, ncol(embeddings)))
      }
      # Calculating the mean of neighbor embeddings
      colMeans(embeddings[neighbors, , drop = FALSE])
    }
    
    # Defining the update function (sum and softmax)
    update <- function(node_emb, agg_emb) {
      sum_vec <- node_emb + agg_emb
      # Applying the softmax function
      exp_vec <- exp(sum_vec)
      exp_vec / sum(exp_vec)
    }
    
    # Defining the message-passing function (single layer)
    message_passing <- function(features, adj_list) {
      new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
      for (i in seq_len(nrow(features))) {
        # Aggregating neighbor embeddings
        agg <- aggregate(adj_list[[i]], features)
        # Updating the node embedding
        new_embeddings[i, ] <- update(features[i, ], agg)
      }
      new_embeddings
    }
    
    # Running a single layer of message passing
    embeddings_after_mp <- message_passing(features, adj_list)
    
    # Printing the results
    print(embeddings_after_mp)
```

</details>

</details>

<details>
<summary>

## 44.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Run the MPGNN you designed in the previous exercise. Make
    # a scatter plot of the node embeddings using the two dimensions
    # as x and y coordinates at the first, fifth, tenth, and twentieth layer.
    # What do you observe?
    
    library(here)
    library(Matrix)
    library(ggplot2)
    
    # Loading the node features
    features <- as.matrix(read.table(here("features.txt")))
    
    # Loading the edge list and building the graph
    edges <- as.matrix(read.table(here("network.txt")))
    num_nodes <- nrow(features)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Run the MPGNN you designed in the previous exercise. Make
    # a scatter plot of the node embeddings using the two dimensions
    # as x and y coordinates at the first, fifth, tenth, and twentieth layer.
    # What do you observe?
    
    library(here)
    library(Matrix)
    library(ggplot2)
    
    # Loading the node features
    features <- as.matrix(read.table(here("features.txt")))
    
    # Loading the edge list and building the graph
    edges <- as.matrix(read.table(here("network.txt")))
    num_nodes <- nrow(features)
    
    # Solution 
    
    # Creating adjacency list
    adj_list <- vector("list", num_nodes)
    for (i in seq_len(nrow(edges))) {
      src <- edges[i, 1] + 1
      tgt <- edges[i, 2] + 1
      adj_list[[src]] <- c(adj_list[[src]], tgt)
      adj_list[[tgt]] <- c(adj_list[[tgt]], src)
    }
    
    # Defining the aggregate function (element-wise mean)
    aggregate <- function(neighbors, embeddings) {
      if (length(neighbors) == 0) {
        return(rep(0, ncol(embeddings)))
      }
      colMeans(embeddings[neighbors, , drop = FALSE])
    }
    
    # Defining the update function (sum and softmax)
    update <- function(node_emb, agg_emb) {
      sum_vec <- node_emb + agg_emb
      exp_vec <- exp(sum_vec)
      exp_vec / sum(exp_vec)
    }
    
    # Defining the message-passing function (single layer)
    message_passing <- function(features, adj_list) {
      new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
      for (i in seq_len(nrow(features))) {
        agg <- aggregate(adj_list[[i]], features)
        new_embeddings[i, ] <- update(features[i, ], agg)
      }
      new_embeddings
    }
    
    # Storing embeddings at specified layers
    embeddings_layers <- list()
    embeddings <- features
    
    # Running the first layer and saving it
    embeddings <- message_passing(embeddings, adj_list)
    embeddings_layers[[1]] <- embeddings
    
    # Running up to 20 layers and saving at 5, 10, and 20
    for (layer in 2:20) {
      embeddings <- message_passing(embeddings, adj_list)
      if (layer %in% c(5, 10, 20)) {
        embeddings_layers[[as.character(layer)]] <- embeddings
      }
    }
    
    # Plotting function for a layer
    plot_layer <- function(emb, layer_num) {
      df <- data.frame(x = emb[,1], y = emb[,2], node = factor(1:nrow(emb)))
      ggplot(df, aes(x = x, y = y, label = node)) +
        geom_point(size = 3, color = "blue") +
        geom_text(vjust = -1) +
        ggtitle(paste("Scatter plot of node embeddings at layer", layer_num)) +
        theme_minimal()
    }
    
    # Plotting each required layer
    print(plot_layer(features, 0)) # Initial features
    print(plot_layer(embeddings_layers[[1]], 1))
    print(plot_layer(embeddings_layers[["5"]], 5))
    print(plot_layer(embeddings_layers[["10"]], 10))
    print(plot_layer(embeddings_layers[["20"]], 20))
    
    # Observe that embeddings of nodes in the same connected group become more similar as layers increase
```

</details>

</details>

<details>
<summary>

## 44.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

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
```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
    
    # Solution 
    
    # Getting the number of nodes and features
    num_nodes <- nrow(features)
    num_features <- ncol(features)
    
    # Creating the adjacency matrix
    adj_matrix <- matrix(0, nrow = num_nodes, ncol = num_nodes)
    for (i in seq_len(nrow(edges))) {
      src <- edges[i, 1] + 1
      tgt <- edges[i, 2] + 1
      adj_matrix[src, tgt] <- 1
      adj_matrix[tgt, src] <- 1
    }
    
    # Adding the identity matrix to adjacency
    adj_matrix_hat <- adj_matrix + diag(num_nodes)
    
    # Calculating the degree matrix
    degree_vec <- rowSums(adj_matrix_hat)
    D_hat_inv_sqrt <- diag(1 / sqrt(degree_vec))
    
    # Defining the softmax function
    softmax <- function(x) {
      exp_x <- exp(x)
      exp_x / rowSums(exp_x)
    }
    
    # Defining one layer of the MPGNN using matrix operations
    mpgnn_layer <- function(H_prev, adj_matrix_hat, D_hat_inv_sqrt) {
      aggregate_matrix <- D_hat_inv_sqrt %*% adj_matrix_hat %*% D_hat_inv_sqrt
      H_new <- aggregate_matrix %*% H_prev
      softmax(H_new)
    }
    
    # Running the MPGNN for 20 layers and recording time
    H_list <- list()
    H_list[[1]] <- features
    
    times_matrix <- microbenchmark(
      {
        H <- features
        for (layer in 2:21) {
          H <- mpgnn_layer(H, adj_matrix_hat, D_hat_inv_sqrt)
          if (layer %in% c(2, 6, 11, 21)) {
            H_list[[layer]] <- H
          }
        }
      },
      times = 10
    )
    
    print(times_matrix)
    
    # Loading the adjacency list for the first MPGNN
    adj_list <- vector("list", num_nodes)
    for (i in seq_len(nrow(edges))) {
      src <- edges[i, 1] + 1
      tgt <- edges[i, 2] + 1
      adj_list[[src]] <- c(adj_list[[src]], tgt)
      adj_list[[tgt]] <- c(adj_list[[tgt]], src)
    }
    
    # Defining the aggregate function (element-wise mean)
    aggregate <- function(neighbors, embeddings) {
      if (length(neighbors) == 0) {
        return(rep(0, ncol(embeddings)))
      }
      colMeans(embeddings[neighbors, , drop = FALSE])
    }
    
    # Defining the update function (sum and softmax)
    update <- function(node_emb, agg_emb) {
      sum_vec <- node_emb + agg_emb
      exp_vec <- exp(sum_vec)
      exp_vec / sum(exp_vec)
    }
    
    # Defining the message-passing function (single layer)
    message_passing <- function(features, adj_list) {
      new_embeddings <- matrix(0, nrow = nrow(features), ncol = ncol(features))
      for (i in seq_len(nrow(features))) {
        agg <- aggregate(adj_list[[i]], features)
        new_embeddings[i, ] <- update(features[i, ], agg)
      }
      new_embeddings
    }
    
    # Running the first MPGNN for 20 layers and recording time
    times_loop <- microbenchmark(
      {
        emb <- features
        for (layer in 1:20) {
          emb <- message_passing(emb, adj_list)
        }
      },
      times = 10
    )
    
    print(times_loop)
    
    # Printing average running times for both methods
    cat("Matrix operations average time (ms):", mean(times_matrix$time) / 1e6, "\n")
    cat("Loop/message-passing average time (ms):", mean(times_loop$time) / 1e6, "\n")
```

</details>

</details>

<details>
<summary>

## 45.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

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
    
    # Extracting edge information
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    alpha <- network_data[, 3]
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
    
    # Extracting edge information
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    alpha <- network_data[, 3]
    
    # Solution 
    
    # Determining the number of nodes
    num_nodes <- max(c(src, dst))
    
    # Initializing the adjacency matrix with zeros
    A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
    
    # Filling the adjacency matrix with attention weights
    for (i in seq_along(src)) {
      A[src[i], dst[i]] <- alpha[i]
      A[dst[i], src[i]] <- alpha[i]
    }
    
    # Building the attention matrix (α) as the weighted adjacency
    I <- diag(num_nodes)
    # Summing identity and attention adjacency
    A_hat <- I + A
    
    # Calculating the degree matrix from new adjacency
    D_hat <- diag(rowSums(A_hat))
    
    # Calculating the normalization factor
    D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
    
    # Forming the normalized attention matrix
    attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
    
    # Generating a random weight matrix W
    set.seed(42)
    W <- matrix(runif(ncol(features) * 4), ncol = 4)
    
    # Applying the attention mechanism to features
    output <- attention_mat %*% features %*% W
    
    # Printing the output
    print(output)
```

</details>

</details>

<details>
<summary>

## 45.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement a simple transformer by repeating the attention operation
    # from the previous exercise with the alternative weights in
    # the third, fourth, and fifth column of http://www.networkatlas.
    # eu/exercises/45/1/network.txt. Combine them with a final layer
    # averaging all the attention heads.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE))
    
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement a simple transformer by repeating the attention operation
    # from the previous exercise with the alternative weights in
    # the third, fourth, and fifth column of http://www.networkatlas.
    # eu/exercises/45/1/network.txt. Combine them with a final layer
    # averaging all the attention heads.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE))
    
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    
    # Solution 
    
    # Getting the number of nodes
    num_nodes <- max(c(src, dst))
    
    # Initializing the attention head outputs list
    head_outputs <- list()
    
    # Looping through the third, fourth, and fifth columns for attention weights
    for (col in 3:5) {
      # Initializing the adjacency matrix with zeros
      A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
      
      # Filling the adjacency matrix with the attention weights for this head
      alpha <- network_data[, col]
      for (i in seq_along(src)) {
        A[src[i], dst[i]] <- alpha[i]
        A[dst[i], src[i]] <- alpha[i]
      }
      
      # Building the attention matrix for this head
      I <- diag(num_nodes)
      A_hat <- I + A
      
      # Calculating the degree matrix
      D_hat <- diag(rowSums(A_hat))
      
      # Calculating the normalization factor
      D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
      
      # Creating the normalized attention matrix
      attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
      
      # Generating a random weight matrix W for each head
      set.seed(42 + col)
      W <- matrix(runif(ncol(features) * 4), ncol = 4)
      
      # Applying the attention operation for this head
      head_output <- attention_mat %*% features %*% W
      
      # Storing the output for this head
      head_outputs[[length(head_outputs) + 1]] <- head_output
    }
    
    # Averaging the outputs of all heads
    final_output <- Reduce("+", head_outputs) / length(head_outputs)
    
    # Printing the result
    print(final_output)
```

</details>

</details>

<details>
<summary>

## 45.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement a simple graph variational autoencoder. Learn the
    # embeddings with the transformer you just implemented on the
    # network from the previous exercise. Then calculate each node
    # embedding’s mean and standard deviation. Then generate ten random
    # embeddings with the same average and standard deviations.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE)
                          
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    num_nodes <- max(c(src, dst))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement a simple graph variational autoencoder. Learn the
    # embeddings with the transformer you just implemented on the
    # network from the previous exercise. Then calculate each node
    # embedding’s mean and standard deviation. Then generate ten random
    # embeddings with the same average and standard deviations.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE)
                          
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    num_nodes <- max(c(src, dst))
    
    # Solution 
    
    # Initializing the attention head outputs list
    head_outputs <- list()
    
    # Repeating the attention operation for each head
    for (col in 3:5) {
      A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
      alpha <- network_data[, col]
      for (i in seq_along(src)) {
        A[src[i], dst[i]] <- alpha[i]
        A[dst[i], src[i]] <- alpha[i]
      }
      I <- diag(num_nodes)
      A_hat <- I + A
      D_hat <- diag(rowSums(A_hat))
      D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
      attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
      set.seed(42 + col)
      W <- matrix(runif(ncol(features) * 4), ncol = 4)
      head_output <- attention_mat %*% features %*% W
      head_outputs[[length(head_outputs) + 1]] <- head_output
    }
    
    # Averaging all the attention heads to get the embeddings
    embeddings <- Reduce("+", head_outputs) / length(head_outputs)
    
    # Calculating the mean and standard deviation for each dimension
    embedding_means <- apply(embeddings, 2, mean)
    embedding_sds <- apply(embeddings, 2, sd)
    
    # Generating ten random embeddings with the same mean and sd
    set.seed(123)
    random_embeddings <- matrix(
      rnorm(10 * length(embedding_means), mean = rep(embedding_means, each = 10), sd = rep(embedding_sds, each = 10)),
      nrow = 10, byrow = FALSE
    )
    
    # Printing the random embeddings
    print(random_embeddings)
```

</details>

</details>

<details>
<summary>

## 45.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Implement a basic continuous message-passing. Each node averages
    # its own embedding with the average of its neighbors times a
    # factor k. Try k = 0.5, k = 1, and k = 1.33 with the network from the
    # previous exercises.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE)
    
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    num_nodes <- max(c(src, dst))
    
    # Initializing the adjacency matrix with zeros
    A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
    for (i in seq_along(src)) {
      A[src[i], dst[i]] <- 1
      A[dst[i], src[i]] <- 1
    }
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Implement a basic continuous message-passing. Each node averages
    # its own embedding with the average of its neighbors times a
    # factor k. Try k = 0.5, k = 1, and k = 1.33 with the network from the
    # previous exercises.
    
    library(here)
    
    # Loading the network data
    network_data <- read.table(here("network.txt"), header = FALSE)
    # Loading the features data
    features <- as.matrix(read.table(here("features.txt"), header = FALSE)
    
    # Getting the source and destination nodes
    src <- network_data[, 1] + 1
    dst <- network_data[, 2] + 1
    num_nodes <- max(c(src, dst))
    
    # Initializing the adjacency matrix with zeros
    A <- matrix(0, nrow = num_nodes, ncol = num_nodes)
    for (i in seq_along(src)) {
      A[src[i], dst[i]] <- 1
      A[dst[i], src[i]] <- 1
    }
    
    # Solution 
    
    # Getting the embeddings from the previous transformer step
    # Repeating the attention operation for each head
    head_outputs <- list()
    for (col in 3:5) {
      A_att <- matrix(0, nrow = num_nodes, ncol = num_nodes)
      alpha <- network_data[, col]
      for (i in seq_along(src)) {
        A_att[src[i], dst[i]] <- alpha[i]
        A_att[dst[i], src[i]] <- alpha[i]
      }
      I <- diag(num_nodes)
      A_hat <- I + A_att
      D_hat <- diag(rowSums(A_hat))
      D_hat_inv_sqrt <- diag(1 / sqrt(diag(D_hat)))
      attention_mat <- D_hat_inv_sqrt %*% A_hat %*% D_hat_inv_sqrt
      set.seed(42 + col)
      W <- matrix(runif(ncol(features) * 4), ncol = 4)
      head_output <- attention_mat %*% features %*% W
      head_outputs[[length(head_outputs) + 1]] <- head_output
    }
    embeddings <- Reduce("+", head_outputs) / length(head_outputs)
    
    # Defining the message passing function
    message_passing <- function(embeddings, adjacency, k) {
      new_embeddings <- embeddings
      for (node in 1:nrow(embeddings)) {
        neighbors <- which(adjacency[node, ] > 0)
        if (length(neighbors) > 0) {
          neighbor_avg <- colMeans(embeddings[neighbors, , drop = FALSE])
          new_embeddings[node, ] <- (embeddings[node, ] + k * neighbor_avg) / (1 + k)
        }
        # if no neighbors, just keep its own embedding
      }
      return(new_embeddings)
    }
    
    # Trying k = 0.5, k = 1, and k = 1.33
    result_k_0.5 <- message_passing(embeddings, A, k = 0.5)
    result_k_1   <- message_passing(embeddings, A, k = 1)
    result_k_1.33 <- message_passing(embeddings, A, k = 1.33)
    
    # Printing the results for each k
    print(result_k_0.5)
    print(result_k_1)
    print(result_k_1.33)
```

</details>

</details>

<details>
<summary>

## 46.6.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Perform label percolation community discovery on the network at
    # http://www.networkatlas.eu/exercises/46/1/data.txt. Use the
    # detected communities to summarize the graph via aggregation.
    
    library(igraph)
    library(here)
    
    # Reading the edge list from the data.txt file in the script folder
    edges <- read.table(here("data.txt"), header = FALSE)
    
    # Building the graph from the edge list
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Perform label percolation community discovery on the network at
    # http://www.networkatlas.eu/exercises/46/1/data.txt. Use the
    # detected communities to summarize the graph via aggregation.
    
    library(igraph)
    library(here)
    
    # Reading the edge list from the data.txt file in the script folder
    edges <- read.table(here("data.txt"), header = FALSE)
    
    # Building the graph from the edge list
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Solution 
    
    # Performing label propagation community detection
    communities <- cluster_label_prop(g)
    
    # Getting the membership vector
    membership <- membership(communities)
    
    # Aggregating the graph by summarizing nodes within the same community
    # Creating a new graph where each node is a community and edges represent links between communities
    # Getting the community membership for each node
    V(g)$community <- membership
    
    # Contracting the graph based on community membership
    contracted <- contract.vertices(g, membership)
    
    # Simplifying the contracted graph by merging multiple edges between communities
    agg_graph <- simplify(contracted, remove.loops = TRUE)
    
    # Printing the community membership for each original node
    print(membership)
    
    # Printing the summary of the aggregated graph
    print(agg_graph)
```

</details>

</details>

<details>
<summary>

## 46.6.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # The table at http://www.networkatlas.eu/exercises/46/2/
    # diffusion.txt contains the information of which node (first
    # column) influenced which other node (second column). Use it
    # to summarize the graph by keeping only the edges used by the
    # spreading process.
    
    library(igraph)
    library(here)
    
    # Loading the diffusion edge list from the file in the script folder
    diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)
    
    # Building the graph using the edges from the diffusion process
    diffusion_graph <- graph_from_edgelist(as.matrix(diffusion_edges), directed = TRUE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # The table at http://www.networkatlas.eu/exercises/46/2/
    # diffusion.txt contains the information of which node (first
    # column) influenced which other node (second column). Use it
    # to summarize the graph by keeping only the edges used by the
    # spreading process.
    
    library(igraph)
    library(here)
    
    # Loading the diffusion edge list from the file in the script folder
    diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)
    
    # Building the graph using the edges from the diffusion process
    diffusion_graph <- graph_from_edgelist(as.matrix(diffusion_edges), directed = TRUE)
    
    # Solution 
    
    # Printing the summary of the diffusion graph to show only the edges used by the spreading process
    print(diffusion_graph)
```

</details>

</details>

<details>
<summary>

## 46.6.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Summarize the summary you generated answering question #1
    # with the data from question #2. Do you still obtain a connected
    # graph?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Detecting communities using label propagation
    communities <- cluster_label_prop(g)
    membership <- membership(communities)
    
    # Loading the diffusion edge list
    diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)
    
    # Mapping diffusion edges to communities
    comm_from <- membership[as.character(diffusion_edges$V1)]
    comm_to <- membership[as.character(diffusion_edges$V2)]
    community_edges <- cbind(comm_from, comm_to)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Summarize the summary you generated answering question #1
    # with the data from question #2. Do you still obtain a connected
    # graph?
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Detecting communities using label propagation
    communities <- cluster_label_prop(g)
    membership <- membership(communities)
    
    # Loading the diffusion edge list
    diffusion_edges <- read.table(here("diffusion.txt"), header = FALSE)
    
    # Mapping diffusion edges to communities
    comm_from <- membership[as.character(diffusion_edges$V1)]
    comm_to <- membership[as.character(diffusion_edges$V2)]
    community_edges <- cbind(comm_from, comm_to)
    
    # Solution 
    
    # Removing possible NA edges between communities
    community_edges <- community_edges[complete.cases(community_edges),]
    
    # Building the community-level graph from mapped diffusion edges
    community_graph <- graph_from_edgelist(community_edges, directed = TRUE)
    
    # Checking if the community graph is strongly connected
    cat("Checking if the community graph is strongly connected\n")
    print(is.connected(community_graph, mode = "strong"))
```

</details>

</details>

<details>
<summary>

## 47.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the distance between the node vectors in http://www.
    # networkatlas.eu/exercises/47/1/vector1.txt and http://
    # www.networkatlas.eu/exercises/47/1/vector2.txt over the
    # network in http://www.networkatlas.eu/exercises/47/1/data.
    # txt, using the Laplacian approach. The vector files have two
    # columns: the first column is the id of the node, the second column
    # is the corresponding value in the vector. Normalize the vectors so
    # that they both sum to one.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the distance between the node vectors in http://www.
    # networkatlas.eu/exercises/47/1/vector1.txt and http://
    # www.networkatlas.eu/exercises/47/1/vector2.txt over the
    # network in http://www.networkatlas.eu/exercises/47/1/data.
    # txt, using the Laplacian approach. The vector files have two
    # columns: the first column is the id of the node, the second column
    # is the corresponding value in the vector. Normalize the vectors so
    # that they both sum to one.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Solution 
    
    # Normalizing the vectors so that they both sum to one
    vec1$value <- vec1$value / sum(vec1$value)
    vec2$value <- vec2$value / sum(vec2$value)
    
    # Getting all node ids from the graph
    all_nodes <- as.numeric(V(g)$name)
    
    # Creating full vectors with zeros for missing nodes
    vec1_full <- setNames(rep(0, length(all_nodes)), all_nodes)
    vec2_full <- setNames(rep(0, length(all_nodes)), all_nodes)
    
    # Filling the vectors with values
    vec1_full[as.character(vec1$id)] <- vec1$value
    vec2_full[as.character(vec2$id)] <- vec2$value
    
    # Getting the Laplacian matrix
    laplacian <- laplacian_matrix(g, sparse = FALSE)
    
    # Calculating the difference vector
    diff_vec <- vec1_full - vec2_full
    
    # Calculating the Laplacian distance
    distance <- sqrt(as.numeric(t(diff_vec) %*% laplacian %*% diff_vec))
    
    # Printing the result
    cat("Laplacian distance between the vectors is:", distance, "\n")
```

</details>

</details>

<details>
<summary>

## 47.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the distance using the same data as the previous ques-
    # tion, this time with the average linkage shortest path approach.
    # Normalize the vectors so that they both sum to one.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the distance using the same data as the previous ques-
    # tion, this time with the average linkage shortest path approach.
    # Normalize the vectors so that they both sum to one.
    
    library(igraph)
    library(here)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_data_frame(edges, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Solution 
    
    # Normalizing the vectors so that they both sum to one
    vec1$value <- vec1$value / sum(vec1$value)
    vec2$value <- vec2$value / sum(vec2$value)
    
    # Getting all node ids from the graph
    all_nodes <- as.numeric(V(g)$name)
    
    # Creating full vectors with zeros for missing nodes
    vec1_full <- setNames(rep(0, length(all_nodes)), all_nodes)
    vec2_full <- setNames(rep(0, length(all_nodes)), all_nodes)
    
    # Filling the vectors with values
    vec1_full[as.character(vec1$id)] <- vec1$value
    vec2_full[as.character(vec2$id)] <- vec2$value
    
    # Getting the node ids with nonzero values in each vector
    nodes1 <- as.character(names(vec1_full[vec1_full > 0]))
    nodes2 <- as.character(names(vec2_full[vec2_full > 0]))
    
    # Calculating the distance matrix using the correct vertex names
    distance_matrix <- distances(g, v = nodes1, to = nodes2)
    
    # Calculating the weights for each node pair
    weights <- outer(vec1_full[nodes1], vec2_full[nodes2], FUN = "*")
    
    # Calculating the average linkage distance
    average_distance <- sum(distance_matrix * weights)
    
    cat("Average linkage shortest path distance between the vectors is:", average_distance, "\n")
```

</details>

</details>

<details>
<summary>

## 47.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the distance using the same vectors as the previous ques-
    # tions, this time on the http://www.networkatlas.eu/exercises/
    # 47/3/data.txt network, with both the average linkage shortest
    # path and the Laplacian approaches. Are these vectors closer or
    # farther in this network than in the previous one?
    
    library(igraph)
    library(here)
    
    # Loading the new edge list and building the graph
    edges_new <- read.table(here("data.txt"), header = FALSE)
    g_new <- graph_from_data_frame(edges_new, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the distance using the same vectors as the previous ques-
    # tions, this time on the http://www.networkatlas.eu/exercises/
    # 47/3/data.txt network, with both the average linkage shortest
    # path and the Laplacian approaches. Are these vectors closer or
    # farther in this network than in the previous one?
    
    library(igraph)
    library(here)
    
    # Loading the new edge list and building the graph
    edges_new <- read.table(here("data.txt"), header = FALSE)
    g_new <- graph_from_data_frame(edges_new, directed = FALSE)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Solution 
    
    # Normalizing the vectors so that they both sum to one
    vec1$value <- vec1$value / sum(vec1$value)
    vec2$value <- vec2$value / sum(vec2$value)
    
    # Getting all node ids from the new graph
    all_nodes_new <- as.numeric(V(g_new)$name)
    
    # Creating full vectors with zeros for missing nodes
    vec1_full_new <- setNames(rep(0, length(all_nodes_new)), all_nodes_new)
    vec2_full_new <- setNames(rep(0, length(all_nodes_new)), all_nodes_new)
    
    # Filling the vectors with values
    vec1_full_new[as.character(vec1$id)] <- vec1$value
    vec2_full_new[as.character(vec2$id)] <- vec2$value
    
    # Getting the node ids with nonzero values in each vector
    nodes1_new <- as.character(names(vec1_full_new[vec1_full_new > 0]))
    nodes2_new <- as.character(names(vec2_full_new[vec2_full_new > 0]))
    
    # Calculating the average linkage shortest path distance
    distance_matrix_new <- distances(g_new, v = nodes1_new, to = nodes2_new)
    weights_new <- outer(vec1_full_new[nodes1_new], vec2_full_new[nodes2_new], FUN = "*")
    average_distance_new <- sum(distance_matrix_new * weights_new)
    
    # Printing the average linkage result
    cat("Average linkage shortest path distance in the new network is:", average_distance_new, "\n")
    
    # Calculating the Laplacian distance
    laplacian_new <- laplacian_matrix(g_new, sparse = FALSE)
    diff_vec_new <- vec1_full_new - vec2_full_new
    laplacian_distance_new <- sqrt(as.numeric(t(diff_vec_new) %*% laplacian_new %*% diff_vec_new))
    
    cat("Laplacian distance in the new network is:", laplacian_distance_new, "\n")
```

</details>

</details>

<details>
<summary>

## 47.7.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the variances of the vectors used in the previous exer-
    # cises on both networks used in the previous exercises.
    
    library(here)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Normalizing the vectors so that they both sum to one
    vec1$value <- vec1$value / sum(vec1$value)
    vec2$value <- vec2$value / sum(vec2$value)
    
    # Loading the first network
    edges1 <- read.table(here("data.txt"), header = FALSE)
    node_ids1 <- unique(c(edges1$V1, edges1$V2))
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the variances of the vectors used in the previous exer-
    # cises on both networks used in the previous exercises.
    
    library(here)
    
    # Loading vector1 and vector2
    vec1 <- read.table(here("vector1.txt"), header = FALSE)
    vec2 <- read.table(here("vector2.txt"), header = FALSE)
    
    # Renaming columns for clarity
    colnames(vec1) <- c("id", "value")
    colnames(vec2) <- c("id", "value")
    
    # Normalizing the vectors so that they both sum to one
    vec1$value <- vec1$value / sum(vec1$value)
    vec2$value <- vec2$value / sum(vec2$value)
    
    # Loading the first network
    edges1 <- read.table(here("data.txt"), header = FALSE)
    node_ids1 <- unique(c(edges1$V1, edges1$V2))
    
    # Solution 
    
    # Creating full vectors with zeros for missing nodes in network 1
    vec1_full_1 <- setNames(rep(0, length(node_ids1)), node_ids1)
    vec2_full_1 <- setNames(rep(0, length(node_ids1)), node_ids1)
    vec1_full_1[as.character(vec1$id)] <- vec1$value
    vec2_full_1[as.character(vec2$id)] <- vec2$value
    
    # Calculating variances for network 1
    variance_vec1_net1 <- var(vec1_full_1)
    variance_vec2_net1 <- var(vec2_full_1)
    
    cat("Variance of vector1 on network 1:", variance_vec1_net1, "\n")
    cat("Variance of vector2 on network 1:", variance_vec2_net1, "\n")
    
    # Loading the second network
    edges2 <- read.table(here("data.txt"), header = FALSE)
    node_ids2 <- unique(c(edges2$V1, edges2$V2))
    
    # Creating full vectors with zeros for missing nodes in network 2
    vec1_full_2 <- setNames(rep(0, length(node_ids2)), node_ids2)
    vec2_full_2 <- setNames(rep(0, length(node_ids2)), node_ids2)
    vec1_full_2[as.character(vec1$id)] <- vec1$value
    vec2_full_2[as.character(vec2$id)] <- vec2$value
    
    # Calculating variances for network 2
    variance_vec1_net2 <- var(vec1_full_2)
    variance_vec2_net2 <- var(vec2_full_2)
    
    cat("Variance of vector1 on network 2:", variance_vec1_net2, "\n")
    cat("Variance of vector2 on network 2:", variance_vec2_net2, "\n")
```

</details>

</details>

<details>
<summary>

## 48.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

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
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

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
```

</details>

</details>

<details>
<summary>

## 48.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the structural similarities of all pairs of nodes for all
    # pairs of networks used in the previous question. Derive a network
    # similarity value by averaging the node-node similarities. Since
    # the networks are aligned, the node-node similarity is the Jaccard
    # coefficient of their neighbor sets, and you should only calculate
    # them for pairs of nodes with the same id. Which pair of networks
    # are more similar to each other?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph for data1.txt
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
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
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the structural similarities of all pairs of nodes for all
    # pairs of networks used in the previous question. Derive a network
    # similarity value by averaging the node-node similarities. Since
    # the networks are aligned, the node-node similarity is the Jaccard
    # coefficient of their neighbor sets, and you should only calculate
    # them for pairs of nodes with the same id. Which pair of networks
    # are more similar to each other?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph for data1.txt
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
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
    
    # Getting all node ids as characters
    all_ids <- as.character(sort(unique(c(V(graph1)$name, V(graph2)$name, V(graph3)$name))))
    
    # Defining a function for calculating Jaccard similarity
    jaccard_sim <- function(neigh1, neigh2) {
      if(length(neigh1) == 0 & length(neigh2) == 0) return(1)
      intersect_len <- length(intersect(neigh1, neigh2))
      union_len <- length(union(neigh1, neigh2))
      if(union_len == 0) return(1)
      return(intersect_len / union_len)
    }
    
    # Calculating node-node similarities for each pair of graphs
    # Calculating similarities between graph1 and graph2
    sim12 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
      n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
      sim12[i] <- jaccard_sim(as.character(n1$name), as.character(n2$name))
    }
    network_sim12 <- mean(sim12)
    
    # Calculating similarities between graph1 and graph3
    sim13 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
      n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
      sim13[i] <- jaccard_sim(as.character(n1$name), as.character(n3$name))
    }
    network_sim13 <- mean(sim13)
    
    # Calculating similarities between graph2 and graph3
    sim23 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
      n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
      sim23[i] <- jaccard_sim(as.character(n2$name), as.character(n3$name))
    }
    network_sim23 <- mean(sim23)
    
    # Printing the network similarity values
    print(paste("Network similarity between 1 and 2:", network_sim12))
    print(paste("Network similarity between 1 and 3:", network_sim13))
    print(paste("Network similarity between 2 and 3:", network_sim23))
    
    # Printing which pair is most similar
    if(network_sim12 >= network_sim13 & network_sim12 >= network_sim23){
      print("Network 1 and Network 2 are the most similar.")
    } else if(network_sim13 >= network_sim12 & network_sim13 >= network_sim23){
      print("Network 1 and Network 3 are the most similar.")
    } else{
      print("Network 2 and Network 3 are the most similar.")
    }
```

</details>

</details>

<details>
<summary>

## 48.5.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Calculate the graph edit distances between the networks used in
    # the previous questions. Remember that the networks are aligned,
    # thus you just need to iterate over nodes and compare their neigh-
    # borhoods. Which pair of networks are more similar to each other?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph for data1.txt
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
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
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Calculate the graph edit distances between the networks used in
    # the previous questions. Remember that the networks are aligned,
    # thus you just need to iterate over nodes and compare their neigh-
    # borhoods. Which pair of networks are more similar to each other?
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph for data1.txt
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
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
    
    # Getting all node ids as characters
    all_ids <- as.character(sort(unique(c(V(graph1)$name, V(graph2)$name, V(graph3)$name))))
    
    # Defining a function for calculating edit distance between neighborhoods
    edit_dist <- function(neigh1, neigh2) {
      diff <- setdiff(neigh1, neigh2)
      diff2 <- setdiff(neigh2, neigh1)
      return(length(diff) + length(diff2))
    }
    
    # Calculating node-wise edit distances for each pair of graphs
    dist12 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
      n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
      dist12[i] <- edit_dist(as.character(n1$name), as.character(n2$name))
    }
    ged12 <- mean(dist12)
    
    dist13 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n1 <- if(id %in% V(graph1)$name) neighbors(graph1, id) else c()
      n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
      dist13[i] <- edit_dist(as.character(n1$name), as.character(n3$name))
    }
    ged13 <- mean(dist13)
    
    dist23 <- numeric(length(all_ids))
    for(i in seq_along(all_ids)) {
      id <- all_ids[i]
      n2 <- if(id %in% V(graph2)$name) neighbors(graph2, id) else c()
      n3 <- if(id %in% V(graph3)$name) neighbors(graph3, id) else c()
      dist23[i] <- edit_dist(as.character(n2$name), as.character(n3$name))
    }
    ged23 <- mean(dist23)
    
    # Printing the graph edit distances
    print(paste("Graph edit distance between Network 1 and 2:", ged12))
    print(paste("Graph edit distance between Network 1 and 3:", ged13))
    print(paste("Graph edit distance between Network 2 and 3:", ged23))
    
    # Indicating which pair is most similar
    if(ged12 <= ged13 & ged12 <= ged23){
      print("Network 1 and Network 2 are the most similar.")
    } else if(ged13 <= ged12 & ged13 <= ged23){
      print("Network 1 and Network 3 are the most similar.")
    } else{
      print("Network 2 and Network 3 are the most similar.")
    }
```

</details>

</details>

<details>
<summary>

## 48.5.4

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Fuse the three networks together to produce a consensus network.
    # You can keep an edge in the consensus network only if it appears
    # in two out of three networks – assume that their are aligned and
    # that nodes with the same id are the same node.
    
    library(here)
    library(igraph)
    
    # Loading the edge lists and building the graphs
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
    g1_char <- apply(g1, 2, as.character)
    graph1 <- graph_from_edgelist(g1_char, directed = FALSE)
    
    g2 <- read.table(here("data2.txt"))
    g2 <- as.matrix(g2)
    g2_char <- apply(g2, 2, as.character)
    graph2 <- graph_from_edgelist(g2_char, directed = FALSE)
    
    g3 <- read.table(here("data3.txt"))
    g3 <- as.matrix(g3)
    g3_char <- apply(g3, 2, as.character)
    graph3 <- graph_from_edgelist(g3_char, directed = FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Fuse the three networks together to produce a consensus network.
    # You can keep an edge in the consensus network only if it appears
    # in two out of three networks – assume that their are aligned and
    # that nodes with the same id are the same node.
    
    library(here)
    library(igraph)
    
    # Loading the edge lists and building the graphs
    g1 <- read.table(here("data1.txt"))
    g1 <- as.matrix(g1)
    g1_char <- apply(g1, 2, as.character)
    graph1 <- graph_from_edgelist(g1_char, directed = FALSE)
    
    g2 <- read.table(here("data2.txt"))
    g2 <- as.matrix(g2)
    g2_char <- apply(g2, 2, as.character)
    graph2 <- graph_from_edgelist(g2_char, directed = FALSE)
    
    g3 <- read.table(here("data3.txt"))
    g3 <- as.matrix(g3)
    g3_char <- apply(g3, 2, as.character)
    graph3 <- graph_from_edgelist(g3_char, directed = FALSE)
    
    # Solution 
    
    # Getting all edges as sorted character pairs
    edges1 <- apply(g1_char, 1, function(x) paste(sort(x), collapse = "-"))
    edges2 <- apply(g2_char, 1, function(x) paste(sort(x), collapse = "-"))
    edges3 <- apply(g3_char, 1, function(x) paste(sort(x), collapse = "-"))
    
    # Combining all edges to count their occurrences
    all_edges <- c(edges1, edges2, edges3)
    edge_table <- table(all_edges)
    
    # Keeping edges that appear in at least two networks
    cons_edges <- names(edge_table)[edge_table >= 2]
    
    # Splitting edge names back into node pairs for the consensus edge list
    cons_edge_list <- t(sapply(cons_edges, function(e) unlist(strsplit(e, "-"))))
    
    # Building the consensus graph
    cons_graph <- graph_from_edgelist(cons_edge_list, directed = FALSE)
    
    # Printing the consensus graph summary
    print(cons_graph)
```

</details>

</details>

<details>
<summary>

## 49.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Import the network at http://www.networkatlas.eu/exercises/
    # 49/1/data.txt, calculate the nodes’ degrees and use them to set
    # the node size. Make sure you scale it logarithmically. This can be
    # performed entirely via Cytoscape. (The solution will be provided
    # as a Cytoscape session file)
    
    library(here)
    library(igraph)
    
    # Reading the edge list from the local file
    edges <- read.table(here("data.txt"), header = FALSE)
    
    # Building the network graph from the edge list
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R


```

</details>

</details>

<details>
<summary>

## 49.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Import the community information from http://www.networkatlas.
    # eu/exercises/49/2/nodes.txt and use it to set the node color.
    # (The solution will be provided as a Cytoscape session file)
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Reading the community information
    node_community <- read.table(here("nodes.txt"), header = FALSE)
    communities <- node_community$V2
    names(communities) <- node_community$V1
    
    # Assigning community info to nodes
    V(g)$community <- communities[as.character(V(g)$name)]
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Import the community information from http://www.networkatlas.
    # eu/exercises/49/2/nodes.txt and use it to set the node color.
    # (The solution will be provided as a Cytoscape session file)
    
    library(here)
    library(igraph)
    
    # Reading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Reading the community information
    node_community <- read.table(here("nodes.txt"), header = FALSE)
    communities <- node_community$V2
    names(communities) <- node_community$V1
    
    # Assigning community info to nodes
    V(g)$community <- communities[as.character(V(g)$name)]
    
    # Solution 
    
    # Generating a color palette based on the number of unique communities
    unique_communities <- sort(unique(communities))
    palette <- rainbow(length(unique_communities))
    
    # Mapping the communities to colors
    node_color <- palette[match(V(g)$community, unique_communities)]
    
    # Plotting the network with node colors based on community
    plot(g, vertex.color = node_color, vertex.label = NA)
    
    # Saving the plot for visual inspection
    png(filename = here("network_community_plot.png"))
    plot(g, vertex.color = node_color, vertex.label = NA)
    dev.off()
    
    # Exporting the graph in a format compatible with Cytoscape
    write_graph(g, file = here("network_community_for_cytoscape.graphml"), format = "graphml")
```

</details>

</details>

<details>
<summary>

## 50.5.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Build on top of you visualization from exercise #2 in Chapter 49.
    # Assign to edges a sequential color gradient and a transparency
    # proportional to the logarithm of their edge betweenness (the
    # higher the edge betweenness the more opaque the edge).
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Reading the community information
    node_community <- read.table(here("nodes.txt"), header = FALSE)
    communities <- node_community$V2
    names(communities) <- as.character(node_community$V1)
    
    # Assigning a community to each node in the graph
    all_communities <- rep(NA, vcount(g))
    names(all_communities) <- V(g)$name
    for (i in V(g)$name) {
      if (!is.na(communities[i])) {
        all_communities[i] <- communities[i]
      } else {
        all_communities[i] <- 0
      }
    }
    
    # Setting the community attribute for all nodes
    V(g)$community <- all_communities
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Build on top of you visualization from exercise #2 in Chapter 49.
    # Assign to edges a sequential color gradient and a transparency
    # proportional to the logarithm of their edge betweenness (the
    # higher the edge betweenness the more opaque the edge).
    
    library(here)
    library(igraph)
    
    # Loading the edge list and building the graph
    edges <- read.table(here("data.txt"), header = FALSE)
    g <- graph_from_edgelist(as.matrix(edges), directed = FALSE)
    
    # Reading the community information
    node_community <- read.table(here("nodes.txt"), header = FALSE)
    communities <- node_community$V2
    names(communities) <- as.character(node_community$V1)
    
    # Assigning a community to each node in the graph
    all_communities <- rep(NA, vcount(g))
    names(all_communities) <- V(g)$name
    for (i in V(g)$name) {
      if (!is.na(communities[i])) {
        all_communities[i] <- communities[i]
      } else {
        all_communities[i] <- 0
      }
    }
    
    # Setting the community attribute for all nodes
    V(g)$community <- all_communities
    
    # Solution 
    
    # Generating a color palette for communities
    unique_communities <- sort(unique(V(g)$community))
    palette <- rainbow(length(unique_communities))
    node_color <- palette[match(V(g)$community, unique_communities)]
    
    # Calculating edge betweenness
    eb <- edge_betweenness(g)
    
    # Scaling edge betweenness logarithmically for transparency
    edge_alpha <- log(eb + 1)
    edge_alpha <- (edge_alpha - min(edge_alpha)) / (max(edge_alpha) - min(edge_alpha))
    edge_alpha <- 0.2 + edge_alpha * 0.8
    
    # Creating a sequential color gradient for edges
    num_edges <- ecount(g)
    edge_palette <- colorRampPalette(c("blue", "red"))(num_edges)
    
    # Assigning colors and transparency to edges
    edge_colors <- sapply(1:num_edges, function(i) {
      rgb_val <- col2rgb(edge_palette[i])
      rgb(rgb_val[1]/255, rgb_val[2]/255, rgb_val[3]/255, alpha = edge_alpha[i])
    })
    
    E(g)$color <- edge_colors
    
    # Plotting the network with node colors and edge gradient/transparency
    plot(g, vertex.color = node_color, vertex.label = NA, edge.width = 2, edge.color = E(g)$color)
    
    # Saving the plot for visual inspection
    png(filename = here("network_edge_betweenness_gradient.png"))
    plot(g, vertex.color = node_color, vertex.label = NA, edge.width = 2, edge.color = E(g)$color)
    dev.off()
    
    # Exporting the graph in a format compatible with Cytoscape
    write_graph(g, file = here("network_edge_gradient_for_cytoscape.graphml"), format = "graphml")
```

</details>

</details>

<details>
<summary>

## 50.5.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Import edge data from http://www.networkatlas.eu/exercises/
    # 50/2/edges.txt and use the attribute for the edge’s width.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and edge attribute
    edges_data <- read.table(here("edges.txt"), header = FALSE, sep = "\t", stringsAsFactors = FALSE)
    
    # Splitting the first column to extract node names
    nodes <- strsplit(edges_data$V1, " \\(interacts with\\) ")
    edge_list <- t(sapply(nodes, function(x) c(x[1], x[2])))
    
    # Building the graph
    g <- graph_from_edgelist(edge_list, directed = FALSE)
    
    # Assigning edge width from the attribute
    E(g)$width <- edges_data$V2
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Import edge data from http://www.networkatlas.eu/exercises/
    # 50/2/edges.txt and use the attribute for the edge’s width.
    
    library(here)
    library(igraph)
    
    # Loading the edge list and edge attribute
    edges_data <- read.table(here("edges.txt"), header = FALSE, sep = "\t", stringsAsFactors = FALSE)
    
    # Splitting the first column to extract node names
    nodes <- strsplit(edges_data$V1, " \\(interacts with\\) ")
    edge_list <- t(sapply(nodes, function(x) c(x[1], x[2])))
    
    # Building the graph
    g <- graph_from_edgelist(edge_list, directed = FALSE)
    
    # Assigning edge width from the attribute
    E(g)$width <- edges_data$V2
    
    # Solution 
    
    # Using colors for edges and nodes
    E(g)$color <- "darkorange"
    V(g)$color <- "lightblue"
    
    # Plotting the network with improved colors and edge width
    plot(g, edge.width = E(g)$width, vertex.label = NA)
    
    # Saving the plot for visual inspection
    png(filename = here("network_edge.png"))
    plot(g, edge.width = E(g)$width, vertex.label = NA)
    dev.off()
    
    # Exporting the graph in a format compatible with Cytoscape
    write_graph(g, file = here("network_edge_for_cytoscape.graphml"), format = "graphml")
```

</details>

</details>

<details>
<summary>

## 51.7.1

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/1/data.txt? Choose
    # between hierarchical, force directed, and circular. Visualize it using
    # all three alternatives and motivate your answer based on the result
    # and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list from the file
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph object
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/1/data.txt? Choose
    # between hierarchical, force directed, and circular. Visualize it using
    # all three alternatives and motivate your answer based on the result
    # and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list from the file
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph object
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution
    
    # Plotting the network using hierarchical layout
    # Using the Reingold-Tilford tree layout for hierarchical visualization
    layout_hierarchical <- layout_as_tree(g)
    plot(g, layout=layout_hierarchical, main="Hierarchical Layout")
    
    # Plotting the network using force-directed layout
    # Applying the Fruchterman-Reingold algorithm
    layout_force <- layout_with_fr(g)
    plot(g, layout=layout_force, main="Force-directed Layout")
    
    # Plotting the network using circular layout
    layout_circular <- layout_in_circle(g)
    plot(g, layout=layout_circular, main="Circular Layout")
    
    # Motivating the choice of layout
    # Hierarchical layouts are best for networks with clear parent-child or layered structures, which is not apparent here.
    # Circular layouts are good for showing cycles and equal importance, but may clutter when there are many edges or hubs.
    # Force-directed layouts are usually most suitable for general networks, as they help reveal clusters and hubs. 
    # In this network, the presence of nodes with many connections (like node 26 and 27) is better highlighted with the force-directed layout,
    # making it easier to see central nodes and overall structure.
```

</details>

</details>

<details>
<summary>

## 51.7.2

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/2/data.txt? Choose
    # between hierarchical, force directed, and circular. You might
    # want to use the node attributes at http://www.networkatlas.
    # eu/exercises/51/2/nodes.txt to enhance your visualization.
    # Visualize it using all three alternatives and motivate your answer
    # based on the result and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Loading the node attributes
    nodes <- read.table(here("nodes.txt"), sep="\t", header=FALSE)
    colnames(nodes) <- c("name", "region")
    
    # Building the graph
    g <- graph_from_data_frame(edges, vertices=nodes, directed=FALSE)
    
    # Write here the solution 
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/2/data.txt? Choose
    # between hierarchical, force directed, and circular. You might
    # want to use the node attributes at http://www.networkatlas.
    # eu/exercises/51/2/nodes.txt to enhance your visualization.
    # Visualize it using all three alternatives and motivate your answer
    # based on the result and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Loading the node attributes
    nodes <- read.table(here("nodes.txt"), sep="\t", header=FALSE)
    colnames(nodes) <- c("name", "region")
    
    # Building the graph
    g <- graph_from_data_frame(edges, vertices=nodes, directed=FALSE)
    
    # Solution 
    
    # Assigning colors to regions for visualization
    regions <- unique(nodes$region)
    region_colors <- setNames(rainbow(length(regions)), regions)
    V(g)$color <- region_colors[V(g)$region]
    
    # Plotting the network using hierarchical layout
    # Using a tree layout for hierarchical visualization
    layout_hierarchical <- layout_as_tree(g)
    plot(g, layout=layout_hierarchical, main="Hierarchical Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)
    
    # Plotting the network using force-directed layout
    layout_force <- layout_with_fr(g)
    plot(g, layout=layout_force, main="Force-directed Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)
    
    # Plotting the network using circular layout
    layout_circular <- layout_in_circle(g)
    plot(g, layout=layout_circular, main="Circular Layout", vertex.label=V(g)$name, vertex.color=V(g)$color)
    
    # Motivating the choice of layout
    # Using the hierarchical layout shows a branching structure, but this network is not a clear hierarchy.
    # Using the circular layout helps display all nodes around a circle but makes it harder to see clusters or central nodes.
    # Using the force-directed layout reveals the hub structure and clusters by region, especially with node colors.
    # Concluding that the force-directed layout is the most suitable for showing central nodes and regional groupings in this network.
```

</details>

</details>

<details>
<summary>

## 51.7.3

</summary>

<details>
<summary>

### Problem

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/3/data.txt? Choose
    # between hierarchical, force directed, and circular. Visualize it using
    # all three alternatives and motivate your answer based on the result
    # and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Write here the solution
```

</details>

<details>
<summary>

### Solution

</summary>

```R

    # Which network layout is more suitable to visualize the network at
    # http://www.networkatlas.eu/exercises/51/3/data.txt? Choose
    # between hierarchical, force directed, and circular. Visualize it using
    # all three alternatives and motivate your answer based on the result
    # and the characteristics of the network.
    
    library(here)
    library(igraph)
    
    # Loading the edge list
    edges <- read.table(here("data.txt"), sep="\t", header=FALSE)
    colnames(edges) <- c("from", "to")
    
    # Building the graph
    g <- graph_from_data_frame(edges, directed=FALSE)
    
    # Solution 
    
    # Plotting using hierarchical layout
    layout_hierarchical <- layout_as_tree(g)
    plot(g, layout=layout_hierarchical, main="Hierarchical Layout")
    
    # Plotting using force-directed layout
    layout_force <- layout_with_fr(g)
    plot(g, layout=layout_force, main="Force-directed Layout")
    
    # Plotting using circular layout
    layout_circular <- layout_in_circle(g)
    plot(g, layout=layout_circular, main="Circular Layout")
    
    # Motivating the choice of layout
    # Looking at the result, the hierarchical layout does not clearly show the structure because the network is not tree-like.
    # Observing the circular layout, it is less effective in highlighting central nodes or clusters in this network.
    # Viewing the force-directed layout, it best reveals the overall structure and shows the central connections and clusters, making it the most suitable for this network.
```

</details>

</details>

