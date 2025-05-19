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

# Separating intra-layer and inter-layer edges
intra_layer <- subset(data, type != "C")
inter_layer <- subset(data, type == "C")

# Checking inter-layer edges
print(inter_layer)

# Looking how many times each source and target appears in inter-layer connections
table(inter_layer$source)
table(inter_layer$target)

# Grouping by source to see which targets each connects to
split_by_source <- split(inter_layer, inter_layer$source)
lapply(split_by_source, function(df) df$target)

# Checking if each source connects to more than one unique target, and if target sets overlap
unique_targets_per_source <- lapply(split_by_source, function(df) unique(df$target))
overlap <- Reduce(intersect, unique_targets_per_source)

# Output checks results
cat("Number of unique targets per source:\n")
print(sapply(unique_targets_per_source, length))
cat("Overlap between target sets of each source:\n")
print(overlap)

# Determining coupling type
if (all(sapply(unique_targets_per_source, length) > 1) && length(overlap) == 0) {
  cat("The coupling is STAR: Each group of 'central' nodes connects to a unique set of targets (no overlap).\n")
} else if (all(sapply(unique_targets_per_source, length) == length(unique(unlist(unique_targets_per_source))))) {
  cat("The coupling is CLIQUE: Each source connects to every target.\n")
} else if (all(sapply(unique_targets_per_source, length) == 1) && length(overlap) == 0) {
  cat("The coupling is CHAIN: Each source connects to exactly one unique target.\n")
} else {
  cat("The coupling does not fit standard star, clique, or chain patterns, further analysis needed.\n")
}