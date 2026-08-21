# Manuscript output map

Canonical frozen output directory:

    results/paper_final/

## Main manuscript

| Manuscript element | Repository output |
|---|---|
| Representation-aware classifier landscape | results/paper_final/tables/main_best_ktsp_vs_classic_across_worlds.csv |
| Primary k-TSP versus standard ML summaries | results/paper_final/tables/tier1_main_best_ktsp_vs_classic.csv |
| Cross-condition diagnostic summaries | results/paper_final/tables/tier2_cross_condition_best_ktsp_vs_classic.csv |
| Pooled grouped-validation summaries | results/paper_final/tables/tier4_pooled_best_ktsp_vs_classic.csv |
| Win / near-tie / loss summaries | results/paper_final/tables/win_tie_loss_summary.csv |
| Classifier ranking summaries | results/paper_final/tables/classifier_ranking_selected_cases.csv |
| Post-hoc selected-pair recurrence summaries | results/paper_final/tables/main_top_relation_stability.csv |
| k-TSP versus all-model delta table | results/paper_final/tables/ktsp_vs_all_delta_long.csv |

## Supplementary outputs

| Supplementary evidence layer | Repository output |
|---|---|
| Best k-TSP vs best classic per task/condition/world | results/paper_final/analysis_tables/01_best_ktsp_vs_best_classic_per_task_condition_world.csv |
| k-TSP minus classic delta matrix | results/paper_final/analysis_tables/02_ktsp_minus_classic_delta_matrix.csv |
| Post-hoc selected-pair recurrence summaries | results/paper_final/analysis_tables/04_relation_stability_best_ktsp_disease_models.csv |
| Band occurrence summaries | results/paper_final/analysis_tables/05_band_frequency_best_ktsp.csv |
| Channel occurrence summaries | results/paper_final/analysis_tables/05_channel_frequency_best_ktsp.csv |
| Region occurrence summaries | results/paper_final/analysis_tables/05_region_frequency_best_ktsp.csv |
| Statistical test outputs | results/paper_final/stat_tests/ |
| Key frozen files | results/paper_final/key_files/ |

## Integrity files

| File | Purpose |
|---|---|
| results/paper_final/MANIFEST_files.txt | Frozen output file list |
| results/paper_final/SHA256SUMS.txt | Checksums for frozen paper outputs |
| checksums/SHA256SUMS.txt | Repository-level checksums generated after public-audit cleanup |
| docs/FILE_SIZE_MANIFEST.tsv | Repository file-size manifest |

## Revision-specific outputs

| Revision evidence layer | Repository output |
|---|---|
| Gate 2C final handoff and metric lineage | `results/revision/gate2c/` |
| Intended-versus-effective XGBoost audit | `results/revision/gate2c/gate2c_xgboost_intended_vs_effective.csv` |
| WP1A effect sizes | `results/revision/wp1a/gate3_wp1a_demographic_effect_sizes.csv` |
| WP1A P0/P1 summaries and repeat metrics | `results/revision/wp1a/gate3_wp1a_split_family_sensitivity.csv`; `gate3_wp1a_repeat_metrics.csv` |
| WP1B setting-level performance | `results/revision/wp1b/gate3_wp1b_setting_summary.csv` |
| WP1B repeat-level class metrics and prediction transitions | `results/revision/wp1b/gate3_wp1b_repeat_metrics.csv` |
| WP1B setting-level exact-relation agreement | `results/revision/wp1b/gate3_wp1b_relation_setting_summary.csv` |
| WP1B exact K by fold, relation agreement, reversals, and tie rates | `results/revision/wp1b/gate3_wp1b_repeat_relation_summary.csv` |

WP1B relation-agreement fields compare frozen original and age/sex-adjusted fits in corresponding folds. They are not cross-fold stability estimates.
