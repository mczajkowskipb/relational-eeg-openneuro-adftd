#!/usr/bin/env bash
set -euo pipefail
python python/audit_openneuro_dataset.py --features examples/smoke_feature_tables/features_small.csv --out data/manifests/audit_example.csv
