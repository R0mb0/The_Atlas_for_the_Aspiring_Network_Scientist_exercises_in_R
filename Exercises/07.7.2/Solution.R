# Create the graph
g <- graph_from_data_frame(data[,c("source","target")], directed=FALSE)

E(g)$color <- ifelse(data$type == "C", "red", "grey")
E(g)$lty <- ifelse(data$type == "C", 2, 1)

sources_inter <- unique(inter_layer$source)
targets_inter <- unique(inter_layer$target)
V(g)$color <- ifelse(V(g)$name %in% sources_inter, "skyblue",
                     ifelse(V(g)$name %in% targets_inter, "palegreen", "white"))

# --- Plot with legend below ---


# Plot the graph, leaving space at the bottom
plot(
  g,
  vertex.size=30,
  vertex.label.cex=1.2,
  vertex.label.color="black",
  edge.width=2,
  main=sprintf("Multilayer network (%s coupling)", coupling_type),
  margin=0.2
)

# Add the legend below the plot
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
  xpd = TRUE # allow drawing outside plot region
)
