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
