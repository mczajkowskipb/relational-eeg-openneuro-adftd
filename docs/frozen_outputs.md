# Frozen manuscript-level outputs

The directory `results/paper_final/` contains selected frozen CSV outputs used by the quick reproducibility mode.

These files allow manuscript-level tables, statistical summaries, and selected diagnostic summaries to be reproduced without downloading OpenNeuro data or regenerating EEG features.

## Directory structure

```text
results/paper_final/
├── analysis_tables/
├── key_files/
├── stat_tests/
├── tables/
├── MANIFEST_files.txt
├── README.md
└── SHA256SUMS.txt
```

## Main tables

The `tables/` directory contains manuscript-level summary tables, including:

```text
tier1_main_best_ktsp_vs_classic.csv
tier2_cross_condition_best_ktsp_vs_classic.csv
tier4_pooled_best_ktsp_vs_classic.csv
main_best_ktsp_vs_classic_across_worlds.csv
classifier_ranking_selected_cases.csv
ktsp_vs_all_delta_long.csv
win_tie_loss_summary.csv
main_top_relation_stability.csv
supp_delta_by_world.csv
```

## Statistical summaries

The `stat_tests/` directory contains repeat-level statistical comparisons and classifier-ranking summaries.

The statistical workflow treats repeated observations at the appropriate repeat level rather than treating all folds as independent observations.

## Analysis tables

The `analysis_tables/` directory contains expanded summaries used for downstream reporting and diagnostic checks, including selected relation, band, channel, and region summaries.

## Data policy

Raw OpenNeuro EEG files, derivative EEG files, full job logs, and exploratory runs are not redistributed in this repository.
