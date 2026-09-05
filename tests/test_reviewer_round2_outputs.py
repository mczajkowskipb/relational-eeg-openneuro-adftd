#!/usr/bin/env python3
"""Read-only validation of compact reviewer-round-2 evidence."""

import csv
import json
import math
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1] / "results" / "revision" / "reviewer_round2"
RUNNER_SHA = "c64ab42fbcb13e3664eab8f0ad6c638bd4661c5d778fb4f1091fe486a346e25a"
GRID_SHA = "0abaf4e5500778c5c91f77803f2c43e62af3ef464977ad4cf4942a6758c8fb00"


def rows(relative):
    with (ROOT / relative).open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def close(value, target, tol=1e-4):
    return math.isclose(value, target, rel_tol=0, abs_tol=tol)


required = [
    "PROTOCOL.md",
    "exp1/exp1_observed_statistics.csv",
    "exp1/exp1_empirical_pvalues_B1000.csv",
    "exp1/exp1_permutation_statistics_B1000.csv",
    "exp2/exp2_setting_summary.csv",
    "exp3/exp3_setting_summary.csv",
    "exp3/exp3_matching_level_summary.csv",
    "exp4/exp4_setting_summary.csv",
    "config/design_summary_B1000.json",
    "config/exp34_design_summary.json",
    "validation/VALIDATION_REPORT_exp1_B1000.json",
    "validation/VALIDATION_REPORT_exp3.json",
    "validation/VALIDATION_REPORT_exp4.json",
]
missing = [name for name in required if not (ROOT / name).is_file()]
assert not missing, f"missing reviewer-round-2 files: {missing}"

for config_name in ("config/design_summary_B1000.json", "config/exp34_design_summary.json"):
    config = json.loads((ROOT / config_name).read_text(encoding="utf-8"))
    assert config["status"] == "PASS"
    assert config["canonical_runner_sha256"] == RUNNER_SHA
    assert config["gate2c_grid_sha256"] == GRID_SHA

for report_name in (
    "validation/VALIDATION_REPORT_exp1_B1000.json",
    "validation/VALIDATION_REPORT_exp3.json",
    "validation/VALIDATION_REPORT_exp4.json",
):
    assert json.loads((ROOT / report_name).read_text(encoding="utf-8"))["status"] == "PASS"

exp1 = rows("exp1/exp1_empirical_pvalues_B1000.csv")
assert len(exp1) == 36
exact = [r for r in exp1 if r["family"] == "six_setting_exact_pair_maxima"]
motifs = [r for r in exp1 if r["family"] == "24_prespecified_setting_motif_tests"]
omnibus = [r for r in exp1 if r["family"] == "six_setting_omnibus_motif_tests"]
assert len(exact) == 6 and len(motifs) == 24 and len(omnibus) == 6
assert all(float(r["empirical_p_holm"]) > 0.05 for r in exact)
assert sum(float(r["empirical_p_holm"]) <= 0.05 for r in motifs) == 4
assert sum(float(r["empirical_p_holm"]) <= 0.05 for r in omnibus) == 2

exp2 = rows("exp2/exp2_setting_summary.csv")
assert len(exp2) == 6
exp2_delta = [float(r["mean_delta_macro_f1"]) for r in exp2]
assert all(value > 0 for value in exp2_delta)
assert min(exp2_delta) >= 0.0029 and max(exp2_delta) <= 0.0532
assert all(float(r["bootstrap_delta_macro_f1_q025"]) <= 0 <= float(r["bootstrap_delta_macro_f1_q975"]) for r in exp2)

exp3 = rows("exp3/exp3_setting_summary.csv")
assert len(exp3) == 12 and all(int(r["matching_solutions"]) == 100 for r in exp3)
exp3_delta = [float(r["median_mean_delta_vs_original_same_participants_macro_f1"]) for r in exp3]
assert close(sum(exp3_delta) / len(exp3_delta), -0.0030, 5e-4)
assert all(float(r["q025_mean_delta_vs_original_same_participants_macro_f1"]) <= 0 <= float(r["q975_mean_delta_vs_original_same_participants_macro_f1"]) for r in exp3)

exp4 = rows("exp4/exp4_setting_summary.csv")
assert len(exp4) == 42
for variant, expected_mean in (("R2_without_slow_fast", -0.0743), ("R2_without_theta_alpha", -0.0736)):
    selected = [float(r["mean_delta_macro_f1"]) for r in exp4 if r["variant"] == variant]
    assert len(selected) == 6 and all(value < 0 for value in selected)
    assert close(sum(selected) / len(selected), expected_mean, 5e-4)

for csv_path in ROOT.rglob("*.csv"):
    with csv_path.open(newline="", encoding="utf-8") as handle:
        header = next(csv.reader(handle))
    assert not any(name.strip().lower() == "auc" for name in header), f"AUC column: {csv_path}"

print("PASS reviewer-round-2 public evidence validation")

