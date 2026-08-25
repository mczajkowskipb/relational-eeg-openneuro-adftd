# Closed revision evidence

This directory contains frozen evidence used for the BSPC-D-26-12230 manuscript revision.

- `gate2c/` records the accepted final handoff, metric lineage, Wilcoxon prefilter provenance, and intended-versus-effective XGBoost audit.
- `wp1a/` records the independently validated demographic metadata audit and age-and-sex-only baseline.
- `wp1b/` records the independently validated sensitivity analysis using training-fold-only linear additive adjustment for age and sex.

`VALIDATION_COMPLETE` and `WP1A_STOP.txt`/`WP1B_STOP.txt` retain the validated completion and hard-stop state. No WP1C, AUC analysis, permutation analysis, corrected XGBoost run, or new k-TSP replay is included.

The repeat-level WP1B performance file includes both class-specific metrics and prediction-transition counts. The repeat-level relation file retains exact selected K by fold, original-versus-adjusted agreement, reversals, and tie rates. Jaccard values are not general cross-fold stability estimates.

Verify this directory with:

```bash
cd results/revision
sha256sum -c SHA256SUMS.txt
```

## Final claim-level evidence

Additional read-only artifacts used in the final revision audit are:

- `main_comparison/main_setting_level_win_tie_fail_summary.csv` — source of the main 2 wins / 1 near tie / 3 losses comparison and macro-F1 delta range.
- `main_comparison/representation_level_summary_extended_checked.csv` — representation-level source used to reproduce the six main k-TSP and strongest-standard-ML values.
- `compactness/compactness_frontier_checked.csv` — exact compactness frontier evidence.
- `wp1b/gate3_wp1b_job_relation_comparison.csv` — job-level original-versus-adjusted relation comparison.
- `wp1b/gate3_wp1b_independent_relation_reproduction.csv` — independent 4000-job relation-metric reproduction audit.

`make validate-revision` performs read-only schema and claim-level validation. It performs no fitting, replay, AUC calculation, permutation analysis, or model selection.
