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