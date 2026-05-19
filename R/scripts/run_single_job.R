source("R/lib/io.R")
source("R/lib/job_runner.R")
args <- parse_args(list(
  features = "examples/smoke_feature_tables/features_small.csv",
  folds = "examples/smoke_feature_tables/folds_small.csv",
  job_grid = "examples/smoke_feature_tables/job_grid_small.csv",
  out = "results/jobs/smoke"
))
features <- read_csv_base(args$features)
folds <- read_csv_base(args$folds)
jobs <- read_csv_base(args$job_grid)
dir.create(args$out, recursive = TRUE, showWarnings = FALSE)
all_metrics <- list(); all_struct <- list()
for (i in seq_len(nrow(jobs))) {
  job <- jobs[i, ]
  message_step("running job ", job$job_id, " / ", job$model)
  res <- run_one_job(job, features, folds)
  all_metrics[[length(all_metrics) + 1]] <- res$metrics
  if (nrow(res$structure) > 0) all_struct[[length(all_struct) + 1]] <- res$structure
}
metrics <- do.call(rbind, all_metrics)
write_csv_base(metrics, file.path(args$out, "metrics.csv"))
if (length(all_struct) > 0) write_csv_base(do.call(rbind, all_struct), file.path(args$out, "model_structure.csv"))
message_step("wrote ", file.path(args$out, "metrics.csv"))
