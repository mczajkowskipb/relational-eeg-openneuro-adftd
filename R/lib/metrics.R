safe_div <- function(num, den) {
  ifelse(is.na(den) | den == 0, NA_real_, num / den)
}

binary_confusion <- function(y_true, y_pred, positive = "pos", negative = "neg") {
  y_true <- as.character(y_true)
  y_pred <- as.character(y_pred)
  tp <- sum(y_true == positive & y_pred == positive, na.rm = TRUE)
  tn <- sum(y_true == negative & y_pred == negative, na.rm = TRUE)
  fp <- sum(y_true == negative & y_pred == positive, na.rm = TRUE)
  fn <- sum(y_true == positive & y_pred == negative, na.rm = TRUE)
  list(TP = tp, TN = tn, FP = fp, FN = fn)
}

auc_rank <- function(y_true, y_score, positive = "pos", negative = "neg") {
  if (is.null(y_score)) return(NA_real_)
  ok <- !is.na(y_true) & !is.na(y_score)
  y_true <- as.character(y_true[ok])
  y_score <- as.numeric(y_score[ok])
  n_pos <- sum(y_true == positive)
  n_neg <- sum(y_true == negative)
  if (n_pos == 0 || n_neg == 0) return(NA_real_)
  ranks <- rank(y_score, ties.method = "average")
  sum_pos <- sum(ranks[y_true == positive])
  (sum_pos - n_pos * (n_pos + 1) / 2) / (n_pos * n_neg)
}

compute_binary_metrics <- function(y_true, y_pred, y_score = NULL, positive = "pos", negative = "neg") {
  c <- binary_confusion(y_true, y_pred, positive, negative)
  TP <- c$TP; TN <- c$TN; FP <- c$FP; FN <- c$FN
  n <- TP + TN + FP + FN
  accuracy <- safe_div(TP + TN, n)
  precision_pos <- safe_div(TP, TP + FP)
  recall_pos <- safe_div(TP, TP + FN)
  specificity <- safe_div(TN, TN + FP)
  f1_pos <- safe_div(2 * precision_pos * recall_pos, precision_pos + recall_pos)

  precision_neg <- safe_div(TN, TN + FN)
  recall_neg <- safe_div(TN, TN + FP)
  f1_neg <- safe_div(2 * precision_neg * recall_neg, precision_neg + recall_neg)
  macro_f1 <- mean(c(f1_pos, f1_neg), na.rm = FALSE)
  balanced_accuracy <- mean(c(recall_pos, specificity), na.rm = FALSE)
  mcc_den <- sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN))
  MCC <- safe_div(TP * TN - FP * FN, mcc_den)
  auc <- auc_rank(y_true, y_score, positive, negative)

  data.frame(
    TP = TP, TN = TN, FP = FP, FN = FN,
    accuracy = accuracy,
    balanced_accuracy = balanced_accuracy,
    precision_pos = precision_pos,
    recall_pos = recall_pos,
    specificity = specificity,
    f1_pos = f1_pos,
    precision_neg = precision_neg,
    recall_neg = recall_neg,
    f1_neg = f1_neg,
    macro_f1 = macro_f1,
    MCC = MCC,
    auc = auc,
    stringsAsFactors = FALSE
  )
}
