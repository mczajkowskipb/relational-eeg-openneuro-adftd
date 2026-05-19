#!/usr/bin/env python3
from pathlib import Path
import pandas as pd

p = Path("examples/smoke_feature_tables/features_small.csv")
assert p.exists(), p
x = pd.read_csv(p)
required = {"subject_id", "condition", "diagnosis", "label"}
assert required.issubset(x.columns), x.columns
feature_cols = [c for c in x.columns if c not in required]
assert len(feature_cols) >= 5
assert x["subject_id"].nunique() >= 6
print("test_feature_shapes.py passed")
