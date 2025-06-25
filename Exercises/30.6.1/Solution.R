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