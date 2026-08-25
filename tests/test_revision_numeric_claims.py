#!/usr/bin/env python3
"""Read-only validation of final BSPC revision claim-level evidence."""

import csv
import math
import statistics
from collections import Counter
from pathlib import Path

ROOT = Path("results/revision")


def read_csv(path):
    with path.open(newline="", encoding="utf-8-sig") as f:
        return list(csv.DictReader(f))


def close(a, b, tol=5e-6):
    assert math.isclose(float(a), float(b), rel_tol=0, abs_tol=tol), (a, b)


main = read_csv(ROOT / "main_comparison/main_setting_level_win_tie_fail_summary.csv")
land = read_csv(ROOT / "main_comparison/representation_level_summary_extended_checked.csv")

assert len(main) == 6
assert len(land) == 648

directions = Counter(r["direction_primary"] for r in main)
assert directions == {
    "rank_rule_better": 2,
    "near_tie": 1,
    "standard_better": 3,
}

deltas = [float(r["delta_primary_vs_best_standard"]) for r in main]
close(min(deltas), -0.0297538)
close(max(deltas), 0.0348994)

for row in main:
    key = (row["condition"], row["task"])

    primary = [
        r for r in land
        if (r["condition"], r["task"]) == key
        and r["analysis_scope"] == "all_representations"
        and r["model_role"] == "primary_kTSP"
    ]
    standard = [
        r for r in land
        if (r["condition"], r["task"]) == key
        and r["analysis_scope"] == "all_representations"
        and r["model_role"] == "standard_ML"
    ]

    primary_best = max(primary, key=lambda r: float(r["mean_macroF1"]))
    standard_best = max(standard, key=lambda r: float(r["mean_macroF1"]))

    close(primary_best["mean_macroF1"], row["primary_ktsp_macroF1_mean"])
    close(standard_best["mean_macroF1"], row["best_standard_macroF1_mean"])
    assert standard_best["method"] == row["best_standard_method_name"]

compact = read_csv(ROOT / "compactness/compactness_frontier_checked.csv")
assert len(compact) == 18
best_compact = [r for r in compact if r["model_role"] == "best_compact_rank_rule"]
assert len(best_compact) == 6

expected_relations = sorted([4.000, 2.740, 2.920, 4.000, 2.555, 3.000])
expected_mentions = sorted([8.000, 5.480, 5.840, 8.000, 5.110, 6.000])

assert sorted(round(float(r["mean_n_relations"]), 3) for r in best_compact) == expected_relations
assert sorted(round(float(r["mean_n_feature_mentions"]), 3) for r in best_compact) == expected_mentions

relation_settings = read_csv(ROOT / "wp1b/gate3_wp1b_relation_setting_summary.csv")
assert len(relation_settings) == 40
median_jaccard = statistics.median(
    float(r["direction_sensitive_jaccard_mean_mean"])
    for r in relation_settings
)
close(median_jaccard, 0.054020393, 5e-7)

jobs = read_csv(ROOT / "wp1b/gate3_wp1b_job_relation_comparison.csv")
assert len(jobs) == 4000
assert sum(int(r["direction_sensitive_intersection_n"]) == 0 for r in jobs) == 1931

independent = read_csv(ROOT / "wp1b/gate3_wp1b_independent_relation_reproduction.csv")
assert len(independent) == 4000
assert all(r["status"] == "PASS" for r in independent)
assert max(float(r["max_abs_relation_metric_error"]) for r in independent) == 0.0

print("PASS: main comparison = 2 wins / 1 near tie / 3 losses.")
print("PASS: delta macro-F1 range = -0.0297538 to +0.0348994.")
print("PASS: main k-TSP and strongest-standard values reproduce representation-level source.")
print("PASS: compactness evidence reproduces six reported compact-model sizes.")
print("PASS: median directed Jaccard = 0.054020393.")
print("PASS: 1931/4000 jobs have zero shared directed relations.")
print("PASS: 4000/4000 independent relation reproductions pass exactly.")
