get_feature_columns <- function(features) {
  meta <- c("subject_id", "condition", "diagnosis", "label", "dataset", "task")
  setdiff(names(features), meta)
}

relation_values <- function(df, left, right) {
  df[[left]] > df[[right]]
}

score_relation <- function(train, y, left, right, positive = "pos", negative = "neg") {
  r <- relation_values(train, left, right)
  p_pos <- mean(r[y == positive], na.rm = TRUE)
  p_neg <- mean(r[y == negative], na.rm = TRUE)
  score <- abs(p_pos - p_neg)
  orientation <- ifelse(p_pos >= p_neg, positive, negative)
  list(score = score, orientation = orientation, p_pos = p_pos, p_neg = p_neg)
}

select_tsp_pairs <- function(train, y, k = 1, disjoint = FALSE, feature_cols = NULL) {
  if (is.null(feature_cols)) feature_cols <- get_feature_columns(train)
  pairs <- list()
  idx <- 1
  for (i in seq_along(feature_cols)) {
    for (j in seq_along(feature_cols)) {
      if (i == j) next
      sc <- score_relation(train, y, feature_cols[[i]], feature_cols[[j]])
      pairs[[idx]] <- data.frame(
        left_feature = feature_cols[[i]],
        right_feature = feature_cols[[j]],
        score = sc$score,
        orientation = sc$orientation,
        stringsAsFactors = FALSE
      )
      idx <- idx + 1
    }
  }
  tab <- do.call(rbind, pairs)
  tab <- tab[order(-tab$score), ]
  selected <- tab[0, ]
  used <- character()
  for (ii in seq_len(nrow(tab))) {
    row <- tab[ii, ]
    if (disjoint && (row$left_feature %in% used || row$right_feature %in% used)) next
    selected <- rbind(selected, row)
    used <- c(used, row$left_feature, row$right_feature)
    if (nrow(selected) >= k) break
  }
  selected$relation_rank <- seq_len(nrow(selected))
  selected
}

predict_tsp_pairs <- function(test, selected_pairs, positive = "pos", negative = "neg") {
  if (nrow(selected_pairs) == 0) return(rep(NA_character_, nrow(test)))
  votes <- matrix(0, nrow = nrow(test), ncol = nrow(selected_pairs))
  for (i in seq_len(nrow(selected_pairs))) {
    rel <- relation_values(test, selected_pairs$left_feature[[i]], selected_pairs$right_feature[[i]])
    votes[, i] <- ifelse(rel, ifelse(selected_pairs$orientation[[i]] == positive, 1, -1), ifelse(selected_pairs$orientation[[i]] == positive, -1, 1))
  }
  score <- rowSums(votes, na.rm = TRUE)
  ifelse(score >= 0, positive, negative)
}
