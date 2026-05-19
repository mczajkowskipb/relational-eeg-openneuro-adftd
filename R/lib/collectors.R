collect_metric_files <- function(jobs_dir) {
  # Use [.] instead of \\. to avoid escaping issues across R versions/shells.
  files <- list.files(
    jobs_dir,
    pattern = "^(metrics.*[.]csv|metrics[.]csv)$",
    recursive = TRUE,
    full.names = TRUE
  )
  if (length(files) == 0) stop("No metric files found in ", jobs_dir)
  tabs <- lapply(files, read.csv, stringsAsFactors = FALSE, check.names = FALSE)
  do.call(rbind, tabs)
}

collect_structure_files <- function(jobs_dir) {
  files <- list.files(
    jobs_dir,
    pattern = "^(model_structure.*[.]csv|model_structure[.]csv)$",
    recursive = TRUE,
    full.names = TRUE
  )
  if (length(files) == 0) return(data.frame())
  tabs <- lapply(files, read.csv, stringsAsFactors = FALSE, check.names = FALSE)
  do.call(rbind, tabs)
}
