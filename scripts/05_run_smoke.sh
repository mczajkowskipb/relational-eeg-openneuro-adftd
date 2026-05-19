#!/usr/bin/env bash
set -euo pipefail
Rscript R/scripts/run_single_job.R --features examples/smoke_feature_tables/features_small.csv --folds examples/smoke_feature_tables/folds_small.csv --job_grid examples/smoke_feature_tables/job_grid_small.csv --out results/jobs/smoke
