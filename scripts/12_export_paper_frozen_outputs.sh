#!/usr/bin/env bash
set -euo pipefail
SRC="results/paper_final"
OUT_TABLES="paper_outputs/tables"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SRC="$2"; shift 2 ;;
    --out-tables) OUT_TABLES="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 2 ;;
  esac
done
if [[ ! -d "$SRC" ]]; then
  echo "[rel-eeg] missing frozen output directory: $SRC" >&2
  exit 1
fi
mkdir -p "$OUT_TABLES" "$OUT_TABLES/stat_tests" "$OUT_TABLES/analysis_tables" results/stat_tests/paper_final results/analysis_tables/paper_final
cp "$SRC"/tables/*.csv "$OUT_TABLES"/
cp "$SRC"/stat_tests/*.csv "$OUT_TABLES/stat_tests"/
cp "$SRC"/analysis_tables/*.csv "$OUT_TABLES/analysis_tables"/
cp "$SRC"/stat_tests/*.csv results/stat_tests/paper_final/
cp "$SRC"/analysis_tables/*.csv results/analysis_tables/paper_final/
{
  echo "Paper-final frozen outputs exported on $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Source: $SRC"
  echo "Tables:"
  find "$OUT_TABLES" -maxdepth 3 -type f | sort
} > "$OUT_TABLES/PAPER_FINAL_EXPORT_MANIFEST.txt"
echo "[rel-eeg] exported paper-final tables and statistical summaries from $SRC"
