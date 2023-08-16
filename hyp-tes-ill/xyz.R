
ii <- 1
jj <- 1

# plot no 01: barplot ----
plt.nam <- paste(fig.dir, "figure_01_", ii, "_", jj, ".svg", sep = "")
svg(plt.nam)

hyp_tes_sim_pdf(1, "two_sid")

dev.off()