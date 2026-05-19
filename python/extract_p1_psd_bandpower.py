#!/usr/bin/env python3
"""Minimal P1 extractor for Mode A.

Full Mode B TODO: compute PSD/bandpower from public derivative .set files.
In Mode A this script filters/copies P1-like columns from an existing CSV table.
"""
import argparse
from pathlib import Path
import pandas as pd

META = ["subject_id", "condition", "diagnosis", "label"]
P1_PREFIXES = ("PSD_ABSOLUTE_CHANNEL_BAND", "PSD_REGION_ABSOLUTE")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input-csv", default="examples/smoke_feature_tables/features_small.csv")
    ap.add_argument("--out", default="data/features/p1_features_example.csv")
    args = ap.parse_args()
    df = pd.read_csv(args.input_csv)
    cols = [c for c in df.columns if c in META or c.startswith(P1_PREFIXES)]
    if not cols:
        raise SystemExit("No P1-like columns found")
    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    df[cols].to_csv(args.out, index=False)
    print(f"[rel-eeg] wrote {args.out} ({len(df)} rows, {len(cols)} columns)")

if __name__ == "__main__":
    main()
