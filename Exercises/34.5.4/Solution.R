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