#!/usr/bin/env python3
import argparse
from pathlib import Path
import pandas as pd


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument("--features", default="examples/smoke_feature_tables/features_small.csv")
    ap.add_argument("--out", default="data/manifests/feature_qc_example.csv")
    args=ap.parse_args()
    df=pd.read_csv(args.features)
    rows=[]
    for c in df.columns:
        rows.append({"column": c, "missing": int(df[c].isna().sum()), "dtype": str(df[c].dtype)})
    Path(args.out).parent.mkdir(parents=True, exist_ok=True)
    pd.DataFrame(rows).to_csv(args.out,index=False)
    print(f"[rel-eeg] wrote {args.out}")

if __name__ == "__main__":
    main()
