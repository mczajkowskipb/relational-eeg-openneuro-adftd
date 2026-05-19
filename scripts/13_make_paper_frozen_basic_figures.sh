#!/usr/bin/env bash
set -euo pipefail
SRC="results/paper_final"
OUT="paper_outputs/figures"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SRC="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 2 ;;
  esac
done
Rscript R/scripts/make_paper_frozen_basic_figures.R --input_dir "$SRC" --out "$OUT"
