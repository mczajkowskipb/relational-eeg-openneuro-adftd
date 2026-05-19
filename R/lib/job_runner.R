run_one_job <- function(job, features, folds) {
  source("R/lib/metrics.R")
  source("R/lib/switchbox_adapter.R")
  source("R/lib/classic_models.R")
  feature_cols <- get_feature_columns(features)
  out_metrics <- list()
  out_structure <- list()
  job_id <- job$job_id
  task <- job$task
  scenario <- job$scenario
  model <- job$model
  model_family <- job$model_family
  k <- suppressWarnings(as.integer(job$k)); if (is.na(k)) k <- ifelse(model == "TSP_k1", 1, 3)
  disjoint <- tolower(as.character(job$disjoint)) == "true"

  eligible_folds <- folds[folds$task == task & folds$scenario == scenario, ]
  for (sid in unique(eligible_folds$split_id)) {
    f <- eligible_folds[eligible_folds$split_id == sid, ]
    train_keys <- f[f$split == "train", c("subject_id", "condition", "label", "repeat_id", "fold_id")]
    test_keys <- f[f$split == "test", c("subject_id", "condition", "label", "repeat_id", "fold_id")]
    train <- merge(train_keys, features, by = c("subject_id", "condition"), all.x = TRUE)
    test <- merge(test_keys, features, by = c("subject_id", "condition"), all.x = TRUE)
    y_train <- train$label.x
    y_test <- test$label.x
    pred <- NULL
    selected <- NULL
    start_time <- Sys.time()
    status <- "ok"
    err <- ""
    tryCatch({
      if (model == "majority") {
        pred <- predict_majority(y_train, nrow(test))
      } else if (grepl("TSP", model)) {
        selected <- select_tsp_pairs(train[, feature_cols, drop = FALSE], y_train, k = k, disjoint = disjoint, feature_cols = feature_cols)
        pred <- predict_tsp_pairs(test[, feature_cols, drop = FALSE], selected)
      } else {
        pred <- predict_majority(y_train, nrow(test))
        status <- "fallback_majority"
      }
    }, error = function(e) {
      pred <<- rep(NA_character_, nrow(test)); status <<- "error"; err <<- conditionMessage(e)
    })
    runtime <- as.numeric(difftime(Sys.time(), start_time, units = "secs"))
    m <- compute_binary_metrics(y_test, pred)
    m$dataset <- job$dataset
    m$condition <- job$condition
    m$scenario <- scenario
    m$tier <- job$tier
    m$task <- task
    m$feature_world <- job$feature_world
    m$model <- model
    m$model_family <- model_family
    m$repeat_id <- unique(f$repeat_id)[[1]]
    m$fold_id <- unique(f$fold_id)[[1]]
    m$split_id <- sid
    m$runtime <- runtime
    m$status <- status
    m$error_message <- err
    out_metrics[[length(out_metrics) + 1]] <- m
    if (!is.null(selected)) {
      selected$dataset <- job$dataset
      selected$condition <- job$condition
      selected$scenario <- scenario
      selected$tier <- job$tier
      selected$task <- task
      selected$feature_world <- job$feature_world
      selected$model <- model
      selected$repeat_id <- unique(f$repeat_id)[[1]]
      selected$fold_id <- unique(f$fold_id)[[1]]
      selected$relation_text <- paste(selected$left_feature, ">", selected$right_feature)
      selected$k <- k
      selected$disjoint <- disjoint
      selected$selected_frequency <- NA_real_
      out_structure[[length(out_structure) + 1]] <- selected
    }
  }
  list(metrics = do.call(rbind, out_metrics), structure = if (length(out_structure)) do.call(rbind, out_structure) else data.frame())
}
