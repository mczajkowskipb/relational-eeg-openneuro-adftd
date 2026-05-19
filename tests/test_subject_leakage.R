source("R/lib/io.R")
source("R/lib/folds.R")
args <- parse_args(list(folds = "examples/smoke_feature_tables/folds_small.csv"))
folds <- read.csv(args$folds, stringsAsFactors = FALSE, check.names = FALSE)
validate_leakage_firewall(folds)
cat("test_subject_leakage.R passed
")
