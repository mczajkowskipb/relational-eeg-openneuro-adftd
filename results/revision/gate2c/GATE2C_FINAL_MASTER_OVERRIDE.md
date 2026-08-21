# Gate 2C — final master override

Date: 2026-08-17

Status: **CONDITIONAL PASS — CLOSED**

This file supersedes only the obsolete XGBoost interpretation in the automatically generated `MASTER_HANDOFF_GATE2C_ARCHIVED.md`. It does not alter any model result or authorize a new replay.

## Verified Gate 2C core

- 4,000/4,000 k-TSP replays completed; 0 failed.
- No differences in predictions, confusion matrices, corrected macro-F1, balanced accuracy, or MCC.
- 4,000/4,000 replay-selected K values agreed with the independent exact-relation replay.
- No unexpected train/test subject leakage was found.
- Stage 8 XGBoost probe completed with exit code 0.
- The final post-resume validator passed.
- No evidence of manipulation, leakage, or cherry-picking was found.

## Final XGBoost resolution

The probe reproduced the frozen predictions of both submitted XGBoost baselines without differences. However, under XGBoost 3.2.1.1 the old-interface `params=` argument was ignored.

The effective settings were:

- objective: `reg:squarederror`, not `binary:logistic`;
- max_depth: 6, not 2 or 4;
- eta: approximately 0.3, not 0.1 or 0.05;
- subsample: 1, not 0.9;
- colsample_bytree: 1, not 0.9;
- nthread: 30, not 1;
- seed: 0;
- nrounds: 50 and 100, respectively; this parameter was applied.

Therefore, manuscript labels such as `xgboost_shallow` and `xgboost_default`, and descriptions of their intended hyperparameters, do not describe the models that actually produced the frozen predictions. Report them as **legacy XGBoost baselines with audited effective configuration**. Do not present them as correctly tuned shallow/default baselines.

XGBoost was the best standard-ML model in 3/40 configurations and the overall best standard-ML model in 1/8 aggregate comparisons: EC, AD versus FTD, `DERIVED_DECILES_ALL`, macro-F1 = 0.6406. This issue does not change the k-TSP results but limits interpretation of standard-ML comparisons.

## Other mandatory manuscript corrections

1. The historical raw `macro_f1` column was not a correct macro-F1 implementation. The main tables and rankings used correctly reconstructed metrics and showed zero discrepancies. Describe this lineage accurately.
2. P0 and P1 used the same cohorts and repeated-CV design but not identical participant-to-fold assignments. Do not use paired cross-representation-fold language.
3. `featureNo=100` in switchBox 1.48.0 allowed up to 101 descriptors in the effective filter output.
4. Replace approximate compactness/model-size values with exact `fit$TSPs` results.
5. AUC lacks a common stored continuous-score lineage and must be removed from the main methods, results, abstract, tables, and conclusions.
6. Do not rerun the 4,000 k-TSP models.

## Evidence

- `gate2c_xgboost_parameter_audit.md`
- `gate2c_xgboost_intended_vs_effective.csv`
- selected audit summaries under `selected_audits/`
- original Gate 2C evidence archive and checksum

