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
