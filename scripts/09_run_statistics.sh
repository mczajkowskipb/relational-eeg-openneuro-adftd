#!/usr/bin/env bash
set -euo pipefail
Rscript R/scripts/run_statistical_tests.R --input results/example_outputs/ktsp_vs_all_delta_long.csv --out results/stat_tests
