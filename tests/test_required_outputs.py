#!/usr/bin/env python3
from pathlib import Path
required = [
    "results/example_outputs/summary_best_ktsp_vs_classic.csv",
    "results/example_outputs/classifier_rankings_selected_cases.csv",
    "results/example_outputs/ktsp_vs_all_delta_long.csv",
    "results/example_outputs/win_tie_loss_summary.csv",
    "results/example_outputs/relation_stability_top.csv",
    "results/example_outputs/channel_frequency.csv",
    "results/example_outputs/band_frequency.csv",
    "results/example_outputs/region_frequency.csv",
]
missing = [p for p in required if not Path(p).exists()]
assert not missing, missing
print("test_required_outputs.py passed")
