source("R/lib/metrics.R")

m <- compute_binary_metrics(
  y_true = c("pos", "pos", "pos", "neg", "neg", "neg"),
  y_pred = c("pos", "neg", "pos", "neg", "pos", "neg")
)
stopifnot(m$TP == 2, m$TN == 2, m$FP == 1, m$FN == 1)
stopifnot(abs(m$macro_f1 - mean(c(m$f1_pos, m$f1_neg))) < 1e-12)
expected_mcc <- (2*2 - 1*1) / sqrt((2+1)*(2+1)*(2+1)*(2+1))
stopifnot(abs(m$MCC - expected_mcc) < 1e-12)

# division by zero must yield NA, not crash
z <- compute_binary_metrics(y_true = c("pos", "pos"), y_pred = c("pos", "pos"))
stopifnot(is.na(z$specificity))
stopifnot(is.na(z$precision_neg))
cat("test_metric_consistency.R passed
")
