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
  print("Neither axis has 248 unique nodes!")
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