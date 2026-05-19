#!/usr/bin/env bash
set -euo pipefail
python python/extract_p0_amplitude_deciles.py --input-csv examples/smoke_feature_tables/features_small.csv --out data/features/p0_features_example.csv
python python/extract_p1_psd_bandpower.py --input-csv examples/smoke_feature_tables/features_small.csv --out data/features/p1_features_example.csv
