validate_fold_schema <- function(folds) {
  required <- c("split_id", "repeat_id", "fold_id", "subject_id", "condition", "split", "task", "label")
  missing <- setdiff(required, names(folds))
  if (length(missing) > 0) stop("Missing fold columns: ", paste(missing, collapse = ", "))
  invisible(TRUE)
}

validate_no_subject_overlap <- function(folds) {
  validate_fold_schema(folds)
  errors <- character()
  for (sid in unique(folds$split_id)) {
    sub <- folds[folds$split_id == sid, ]
    tr <- unique(sub$subject_id[sub$split == "train"])
    te <- unique(sub$subject_id[sub$split == "test"])
    bad <- intersect(tr, te)
    scenario <- unique(if ("scenario" %in% names(sub)) sub$scenario else "cv")
    if (length(bad) > 0 && !any(grepl("transfer", scenario))) {
      errors <- c(errors, paste0(sid, ": subject overlap in train/test: ", paste(bad, collapse = ",")))
    }
  }
  if (length(errors) > 0) stop(paste(errors, collapse = "
"))
  TRUE
}

validate_pooled_condition_grouping <- function(folds) {
  if (!("scenario" %in% names(folds))) return(TRUE)
  pooled <- folds[grepl("pooled", folds$scenario), ]
  if (nrow(pooled) == 0) return(TRUE)
  errors <- character()
  for (sid in unique(pooled$split_id)) {
    sub <- pooled[pooled$split_id == sid, ]
    for (subject in unique(sub$subject_id)) {
      splits <- unique(sub$split[sub$subject_id == subject])
      if (length(splits) > 1) {
        errors <- c(errors, paste0(sid, ": pooled subject ", subject, " appears on both sides"))
      }
    }
  }
  if (length(errors) > 0) stop(paste(errors, collapse = "
"))
  TRUE
}

validate_cross_condition_transfer <- function(folds) {
  if (!("scenario" %in% names(folds))) return(TRUE)
  transfer <- folds[grepl("transfer", folds$scenario), ]
  if (nrow(transfer) == 0) return(TRUE)
  errors <- character()
  for (sid in unique(transfer$split_id)) {
    sub <- transfer[transfer$split_id == sid, ]
    train_cond <- unique(sub$condition[sub$split == "train"])
    test_cond <- unique(sub$condition[sub$split == "test"])
    if (length(intersect(train_cond, test_cond)) > 0) {
      errors <- c(errors, paste0(sid, ": train/test conditions overlap in transfer scenario"))
    }
    sc <- unique(sub$scenario)
    if (any(grepl("ec_to_eo", sc, ignore.case = TRUE))) {
      if (!all(train_cond == "EC") || !all(test_cond %in% c("EO", "EO_or_photomark"))) {
        errors <- c(errors, paste0(sid, ": expected EC train -> EO test"))
      }
    }
  }
  if (length(errors) > 0) stop(paste(errors, collapse = "
"))
  TRUE
}

validate_nonempty_and_train_classes <- function(folds) {
  errors <- character()
  for (sid in unique(folds$split_id)) {
    sub <- folds[folds$split_id == sid, ]
    tr <- sub[sub$split == "train", ]
    te <- sub[sub$split == "test", ]
    if (nrow(tr) == 0) errors <- c(errors, paste0(sid, ": empty train"))
    if (nrow(te) == 0) errors <- c(errors, paste0(sid, ": empty test"))
    if (length(unique(tr$label)) < 2) errors <- c(errors, paste0(sid, ": train lacks required classes"))
  }
  if (length(errors) > 0) stop(paste(errors, collapse = "
"))
  TRUE
}

validate_leakage_firewall <- function(folds) {
  validate_fold_schema(folds)
  validate_no_subject_overlap(folds)
  validate_pooled_condition_grouping(folds)
  validate_cross_condition_transfer(folds)
  validate_nonempty_and_train_classes(folds)
  TRUE
}
