#!/usr/bin/env bash
set -euo pipefail
Rscript R/scripts/collect_results.R --jobs results/jobs/smoke --out results/summaries/smoke_collected_metrics.csv --structure_out results/analysis_tables/smoke_model_structure.csv
