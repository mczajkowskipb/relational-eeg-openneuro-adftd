#!/usr/bin/env python3
"""Schema/count validation for closed Gate 2C, WP1A, and WP1B outputs.

This test is read-only and performs no fitting or replay.
"""

import csv
from pathlib import Path


ROOT = Path("results/revision")


def check_csv(relative, expected_rows, required_columns):
    path = ROOT / relative
    assert path.is_file(), path
    with path.open(newline="", encoding="utf-8-sig") as handle:
        reader = csv.DictReader(handle)
        assert reader.fieldnames is not None, path
        missing = set(required_columns) - set(reader.fieldnames)
        assert not missing, f"{path}: missing {sorted(missing)}"
        rows = list(reader)
    assert len(rows) == expected_rows, f"{path}: {len(rows)} != {expected_rows}"


for marker in (
    "wp1a/VALIDATION_COMPLETE",
    "wp1a/WP1A_STOP.txt",
    "wp1b/VALIDATION_COMPLETE",
    "wp1b/WP1B_STOP.txt",
):
    assert (ROOT / marker).is_file(), marker

check_csv(
    "wp1a/gate3_wp1a_demographic_effect_sizes.csv",
    8,
    ["condition", "task", "hedges_g_age_a_minus_b", "sex_standardized_mean_difference"],
)
check_csv(
    "wp1a/gate3_wp1a_repeat_metrics.csv",
    320,
    ["split_family", "condition", "task", "repeat_id", "macro_f1", "balanced_accuracy", "mcc"],
)
check_csv(
    "wp1a/gate3_wp1a_split_family_sensitivity.csv",
    160,
    ["split_family", "condition", "task", "metric", "repeat_mean", "comparison_policy"],
)
check_csv(
    "wp1b/gate3_wp1b_setting_summary.csv",
    40,
    [
        "split_family", "world", "condition", "task",
        "original_macro_f1_mean", "adjusted_macro_f1_mean",
        "delta_macro_f1_adjusted_minus_original_mean",
        "prediction_changed_proportion_mean",
        "correct_to_incorrect_proportion_mean",
        "incorrect_to_correct_proportion_mean",
    ],
)
check_csv(
    "wp1b/gate3_wp1b_repeat_metrics.csv",
    800,
    [
        "repeat_id", "original_macro_f1", "adjusted_macro_f1",
        "original_precision_negative", "adjusted_precision_negative",
        "original_recall_positive", "adjusted_recall_positive",
        "original_support_negative", "adjusted_support_positive",
        "prediction_changed_n", "correct_to_incorrect_n", "incorrect_to_correct_n",
    ],
)
check_csv(
    "wp1b/gate3_wp1b_relation_setting_summary.csv",
    40,
    [
        "original_selected_k_mean_mean", "adjusted_selected_k_mean_mean",
        "direction_sensitive_jaccard_mean_mean",
        "direction_insensitive_jaccard_mean_mean",
        "direction_sensitive_overlap_coefficient_mean_mean",
        "reversal_rate_among_common_unordered_pairs_mean",
    ],
)
check_csv(
    "wp1b/gate3_wp1b_repeat_relation_summary.csv",
    800,
    [
        "original_selected_k_by_fold", "adjusted_selected_k_by_fold",
        "direction_sensitive_jaccard_mean", "direction_insensitive_jaccard_mean",
        "reversal_rate_among_common_unordered_pairs",
        "original_train_tie_rate", "adjusted_test_tie_rate",
    ],
)
check_csv(
    "gate2c/gate2c_xgboost_intended_vs_effective.csv",
    18,
    ["model", "parameter", "intended_value", "effective_config_evidence", "verification_status"],
)

print("test_revision_outputs.py passed (read-only; no fitting or replay)")
