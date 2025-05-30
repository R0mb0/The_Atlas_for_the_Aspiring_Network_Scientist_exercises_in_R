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