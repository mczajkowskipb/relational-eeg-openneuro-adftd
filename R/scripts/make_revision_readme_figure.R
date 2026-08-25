input <- "results/revision/main_comparison/main_setting_level_win_tie_fail_summary.csv"
output <- "docs/figures/revision_main_delta_macro_f1.svg"

d <- read.csv(input, stringsAsFactors = FALSE, check.names = FALSE)

labels <- paste(d$condition, d$task, sep = " | ")
delta <- as.numeric(d$delta_primary_vs_best_standard)

dir.create(dirname(output), recursive = TRUE, showWarnings = FALSE)

lim <- max(abs(delta)) * 1.35

svg(output, width = 9, height = 5.5)
par(mar = c(5, 11, 3, 2))

bp <- barplot(
  rev(delta),
  names.arg = rev(labels),
  horiz = TRUE,
  las = 1,
  xlim = c(-lim, lim),
  xlab = "Delta macro-F1 (primary k-TSP minus strongest standard ML)",
  main = "Main benchmark comparison across six prespecified settings"
)

abline(v = 0, lty = 2)

vals <- rev(delta)
text(
  x = vals,
  y = bp,
  labels = sprintf("%+.3f", vals),
  pos = ifelse(vals >= 0, 4, 2),
  offset = 0.35,
  cex = 0.85,
  xpd = TRUE
)

dev.off()
