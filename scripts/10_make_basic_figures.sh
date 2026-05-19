#!/usr/bin/env bash
set -euo pipefail
Rscript R/scripts/make_basic_figures.R --input_dir results/example_outputs --out paper_outputs/figures
