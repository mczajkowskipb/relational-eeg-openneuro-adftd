save_barplot <- function(values, labels, title, out_pdf, out_svg = NULL, ylab = "value") {
  dir.create(dirname(out_pdf), recursive = TRUE, showWarnings = FALSE)
  pdf(out_pdf, width = 8, height = 5)
  par(mar = c(7, 4, 3, 1))
  barplot(values, names.arg = labels, las = 2, main = title, ylab = ylab)
  dev.off()
  if (!is.null(out_svg)) {
    svg(out_svg, width = 8, height = 5)
    par(mar = c(7, 4, 3, 1))
    barplot(values, names.arg = labels, las = 2, main = title, ylab = ylab)
    dev.off()
  }
}

save_delta_heatmap <- function(df, out_pdf, out_svg = NULL) {
  tasks <- unique(df$task)
  worlds <- unique(df$feature_world)
  mat <- matrix(NA_real_, nrow = length(tasks), ncol = length(worlds), dimnames = list(tasks, worlds))
  for (i in seq_len(nrow(df))) mat[df$task[i], df$feature_world[i]] <- df$delta_macro_f1[i]
  pdf(out_pdf, width = 7, height = 5)
  par(mar = c(7, 9, 3, 2))
  image(t(mat[nrow(mat):1, , drop = FALSE]), axes = FALSE, main = "Delta macro-F1: kTSP minus classic")
  axis(1, at = seq(0, 1, length.out = ncol(mat)), labels = colnames(mat), las = 2)
  axis(2, at = seq(0, 1, length.out = nrow(mat)), labels = rev(rownames(mat)), las = 2)
  box()
  dev.off()
  if (!is.null(out_svg)) {
    svg(out_svg, width = 7, height = 5)
    par(mar = c(7, 9, 3, 2))
    image(t(mat[nrow(mat):1, , drop = FALSE]), axes = FALSE, main = "Delta macro-F1: kTSP minus classic")
    axis(1, at = seq(0, 1, length.out = ncol(mat)), labels = colnames(mat), las = 2)
    axis(2, at = seq(0, 1, length.out = nrow(mat)), labels = rev(rownames(mat)), las = 2)
    box()
    dev.off()
  }
}
