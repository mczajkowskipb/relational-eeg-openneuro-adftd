#!/usr/bin/env python3
"""Minimal P0 extractor for Mode A.

Full Mode B TODO: read public OpenNeuro derivative EEGLAB .set files and compute
amplitude-decile features. In Mode A this script filters/copies P0-like columns
from an existing CSV feature table.
"""
import argparse
from pathlib import Path
import pandas as pd

META = ["subject_id", "condition", "diagnosis", "label"]
P0_PREFIXES = ("RAW_DECILES", "DERIVED_DECILES_ALL", "REGION_AGGREGATES_ALL")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input-csv", default="examples/smoke_feature_tables/features_small.csv")
    ap.add_argument("--out", default="data/features/p0_features_example.csv")
    args = ap.parse_args()
    df = pd.read_csv(args.input_csv)
    cols = [c for c in df.columns if c in META or c.startswith(P0_PREFIXES)]
    if not cols:
        raise SystemExit("No P0-like columns found")
    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    df[cols].to_csv(args.out, index=False)
    print(f"[rel-eeg] wrote {args.out} ({len(df)} rows, {len(cols)} columns)")

if __name__ == "__main__":
    main()
