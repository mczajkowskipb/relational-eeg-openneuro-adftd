#!/usr/bin/env bash
set -euo pipefail
ROOT="results/paper_final"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --root) ROOT="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 2 ;;
  esac
done
python tests/test_frozen_outputs_schema.py --root "$ROOT"
