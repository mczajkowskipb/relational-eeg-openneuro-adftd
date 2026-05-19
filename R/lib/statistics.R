bootstrap_ci_mean <- function(x, n_boot = 1000, conf = 0.95, seed = 1) {
  x <- x[!is.na(x)]
  if (length(x) == 0) return(c(NA_real_, NA_real_))
  set.seed(seed)
  vals <- replicate(n_boot, mean(sample(x, replace = TRUE)))
  alpha <- (1 - conf) / 2
  as.numeric(quantile(vals, c(alpha, 1 - alpha), names = FALSE))
}

paired_delta_tests <- function(delta_df, metric_col = "delta", group_cols = c("task", "feature_world")) {
  rows <- list()
  keys <- unique(delta_df[, group_cols, drop = FALSE])
  for (i in seq_len(nrow(keys))) {
    idx <- rep(TRUE, nrow(delta_df))
    for (g in group_cols) idx <- idx & delta_df[[g]] == keys[[g]][i]
    sub <- delta_df[idx, ]
    x <- as.numeric(sub[[metric_col]])
    x <- x[!is.na(x)]
    if (length(x) < 2) next
    wil <- tryCatch(wilcox.test(x, mu = 0, paired = FALSE, exact = FALSE), error = function(e) NULL)
    tt <- tryCatch(t.test(x, mu = 0), error = function(e) NULL)
    ci <- bootstrap_ci_mean(x)
    row <- as.data.frame(keys[i, , drop = FALSE], stringsAsFactors = FALSE)
    row$n_repeats <- length(x)
    row$mean_delta <- mean(x)
    row$median_delta <- median(x)
    row$wilcoxon_p <- if (is.null(wil)) NA_real_ else wil$p.value
    row$paired_t_p <- if (is.null(tt)) NA_real_ else tt$p.value
    row$bootstrap_ci_low <- ci[[1]]
    row$bootstrap_ci_high <- ci[[2]]
    rows[[length(rows) + 1]] <- row
  }
  out <- if (length(rows)) do.call(rbind, rows) else data.frame()
  if (nrow(out) > 0) {
    out$wilcoxon_p_holm <- p.adjust(out$wilcoxon_p, method = "holm")
    out$wilcoxon_p_bh <- p.adjust(out$wilcoxon_p, method = "BH")
  }
  out
}
