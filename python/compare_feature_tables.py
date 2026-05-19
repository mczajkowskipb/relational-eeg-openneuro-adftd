#!/usr/bin/env python3
import argparse
import pandas as pd


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument("left")
    ap.add_argument("right")
    args=ap.parse_args()
    a=pd.read_csv(args.left); b=pd.read_csv(args.right)
    print({"left_shape": a.shape, "right_shape": b.shape, "shared_columns": len(set(a.columns)&set(b.columns))})

if __name__ == "__main__":
    main()
