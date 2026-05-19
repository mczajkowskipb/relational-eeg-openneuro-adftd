#!/usr/bin/env python3
"""Minimal dataset audit.

Mode A audits the example feature table. Mode B should be extended to audit
OpenNeuro derivative .set availability, subject counts, EC/EO pairing, and class counts.
"""
import argparse
from pathlib import Path
import pandas as pd


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--features", default="examples/smoke_feature_tables/features_small.csv")
    ap.add_argument("--out", default="data/manifests/audit_example.csv")
    args = ap.parse_args()
    df = pd.read_csv(args.features)
    audit = df.groupby(["condition", "diagnosis"], dropna=False)["subject_id"].nunique().reset_index(name="n_subjects")
    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    audit.to_csv(args.out, index=False)
    print(f"[rel-eeg] wrote {args.out}")

if __name__ == "__main__":
    main()
