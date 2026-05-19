#!/usr/bin/env python3
"""Validate the minimal paper-final frozen-output package.

This test is intentionally schema-oriented. It does not verify the scientific
validity of the benchmark; it verifies that the small frozen CSV package needed
for quick reproduction has the expected files, columns, and non-empty rows.
"""
from __future__ import annotations

import argparse
import csv
from pathlib import Path
import sys

REQUIRED_FILES = {
    "tables/tier1_main_best_ktsp_vs_classic.csv": [
        "tier", "scenario_family", "scenario_name", "condition", "task",
        "world_ktsp", "model_ktsp", "mcc_ktsp", "balanced_accuracy_ktsp", "macro_f1_ktsp",
        "world_classic", "model_classic", "mcc_classic", "balanced_accuracy_classic", "macro_f1_classic",
        "delta_mcc", "delta_balanced_accuracy", "delta_macro_f1",
    ],
    "tables/tier2_cross_condition_best_ktsp_vs_classic.csv": [
        "tier", "scenario_family", "scenario_name", "condition", "task",
        "world_ktsp", "model_ktsp", "mcc_ktsp", "balanced_accuracy_ktsp", "macro_f1_ktsp",
        "world_classic", "model_classic", "mcc_classic", "balanced_accuracy_classic", "macro_f1_classic",
        "delta_mcc", "delta_balanced_accuracy", "delta_macro_f1",
    ],
    "tables/tier4_pooled_best_ktsp_vs_classic.csv": [
        "tier", "scenario_family", "scenario_name", "condition", "task",
        "world_ktsp", "model_ktsp", "mcc_ktsp", "balanced_accuracy_ktsp", "macro_f1_ktsp",
        "world_classic", "model_classic", "mcc_classic", "balanced_accuracy_classic", "macro_f1_classic",
        "delta_mcc", "delta_balanced_accuracy", "delta_macro_f1",
    ],
    "tables/main_best_ktsp_vs_classic_across_worlds.csv": [
        "tier", "scenario_family", "scenario_name", "condition", "task",
        "world_ktsp", "model_ktsp", "mcc_ktsp", "balanced_accuracy_ktsp", "macro_f1_ktsp",
        "world_classic", "model_classic", "mcc_classic", "balanced_accuracy_classic", "macro_f1_classic",
        "delta_mcc", "delta_balanced_accuracy", "delta_macro_f1",
    ],
    "tables/classifier_ranking_selected_cases.csv": [
        "tier", "layer", "world", "scenario_family", "scenario_name", "condition", "task",
        "block", "model", "macro_f1", "mcc", "balanced_accuracy", "accuracy", "f1_pos", "f1_neg", "rank_macro_f1",
    ],
    "tables/ktsp_vs_all_delta_long.csv": [
        "comparison", "metric", "tier", "layer", "world", "scenario_family", "scenario_name",
        "condition", "task", "ktsp_model", "comparator_model", "comparator_block", "n_repeats",
        "mean_delta", "median_delta", "bootstrap_ci_low", "bootstrap_ci_high", "wilcox_p", "paired_t_p",
        "wilcox_p_holm", "wilcox_p_bh", "paired_t_p_holm", "paired_t_p_bh",
    ],
    "tables/win_tie_loss_summary.csv": [
        "metric", "tier", "layer", "world", "scenario_family", "scenario_name", "condition", "task",
        "ktsp_model", "comparator_model", "comparator_block", "n_repeats", "wins", "ties", "losses",
        "mean_delta", "median_delta",
    ],
    "tables/main_top_relation_stability.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "model", "feature", "n_jobs_selected",
    ],
    "tables/supp_delta_by_world.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task",
        "block_ktsp", "model_ktsp", "accuracy_ktsp", "balanced_accuracy_ktsp", "f1_pos_ktsp", "f1_neg_ktsp", "macro_f1_ktsp", "mcc_ktsp",
        "block_classic", "model_classic", "accuracy_classic", "balanced_accuracy_classic", "f1_pos_classic", "f1_neg_classic", "macro_f1_classic", "mcc_classic",
        "delta_accuracy", "delta_balanced_accuracy", "delta_f1_pos", "delta_f1_neg", "delta_macro_f1", "delta_mcc",
    ],
    "stat_tests/02_best_ktsp_vs_best_classic_tests.csv": [
        "comparison", "metric", "tier", "layer", "world", "scenario_family", "scenario_name", "condition", "task",
        "ktsp_model", "comparator_model", "comparator_block", "n_repeats", "mean_delta", "median_delta",
        "bootstrap_ci_low", "bootstrap_ci_high", "wilcox_p", "paired_t_p", "wilcox_p_holm", "wilcox_p_bh", "paired_t_p_holm", "paired_t_p_bh",
    ],
    "stat_tests/04_classifier_rankings_all_models.csv": [
        "tier", "layer", "world", "scenario_family", "scenario_name", "condition", "task",
        "block", "model", "macro_f1", "mcc", "balanced_accuracy", "accuracy", "f1_pos", "f1_neg", "rank_macro_f1",
    ],
    "stat_tests/05_win_tie_loss_ktsp_vs_all.csv": [
        "metric", "tier", "layer", "world", "scenario_family", "scenario_name", "condition", "task",
        "ktsp_model", "comparator_model", "comparator_block", "n_repeats", "wins", "ties", "losses", "mean_delta", "median_delta",
    ],
    "analysis_tables/01_best_ktsp_vs_best_classic_per_task_condition_world.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "block", "model",
        "accuracy", "balanced_accuracy", "f1_pos", "f1_neg", "macro_f1", "mcc",
    ],
    "analysis_tables/02_ktsp_minus_classic_delta_matrix.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task",
        "block_ktsp", "model_ktsp", "macro_f1_ktsp", "mcc_ktsp",
        "block_classic", "model_classic", "macro_f1_classic", "mcc_classic", "delta_macro_f1", "delta_mcc",
    ],
    "analysis_tables/04_relation_stability_best_ktsp_disease_models.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "model", "feature", "n_jobs_selected",
    ],
    "analysis_tables/05_band_frequency_best_ktsp.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "model", "band", "n_jobs",
    ],
    "analysis_tables/05_channel_frequency_best_ktsp.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "model", "channel", "n_jobs",
    ],
    "analysis_tables/05_region_frequency_best_ktsp.csv": [
        "tier", "scenario_family", "scenario_name", "layer", "world", "condition", "task", "model", "region", "n_jobs",
    ],
}


def read_header_and_count(path: Path) -> tuple[list[str], int]:
    with path.open("r", newline="", encoding="utf-8-sig") as f:
        reader = csv.reader(f)
        try:
            header = next(reader)
        except StopIteration as exc:
            raise AssertionError(f"Empty CSV: {path}") from exc
        n = sum(1 for _ in reader)
    return header, n


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default="results/paper_final", help="Path to frozen paper-final output directory")
    args = ap.parse_args()
    root = Path(args.root)
    if not root.exists():
        raise SystemExit(f"Missing frozen-output directory: {root}")

    errors: list[str] = []
    for rel, required_cols in REQUIRED_FILES.items():
        path = root / rel
        if not path.exists():
            errors.append(f"missing file: {path}")
            continue
        try:
            header, n_rows = read_header_and_count(path)
        except Exception as exc:  # noqa: BLE001
            errors.append(f"cannot read {path}: {exc}")
            continue
        missing = [c for c in required_cols if c not in header]
        if missing:
            errors.append(f"{path}: missing columns: {missing}; header={header}")
        if n_rows <= 0:
            errors.append(f"{path}: no data rows")

    if errors:
        print("test_frozen_outputs_schema.py failed", file=sys.stderr)
        for e in errors:
            print(" -", e, file=sys.stderr)
        return 1

    print("test_frozen_outputs_schema.py passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
