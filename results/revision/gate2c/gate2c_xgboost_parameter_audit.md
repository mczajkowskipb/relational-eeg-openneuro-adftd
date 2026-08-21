# Gate 2C XGBoost effective-parameter audit

Generated: 2026-08-11T10:58:02+0200
Production job used for the probe: tier1_main_000002
Runtime XGBoost version: 3.2.1.1

## Scope

The probe deliberately preserves the submitted `xgboost(data=, label=, params=, nrounds=, verbose=)` call. It does not rewrite the baseline with `xgb.train`. Effective booster configuration is captured with `xgb.config`, flattened, and compared with the intended list in the accompanying CSV.

## Reproduction of submitted behavior

- `xgboost_shallow`: submitted-vs-probe class predictions = **match**; mismatches = 0; effective boosted rounds = 50.
- `xgboost_default`: submitted-vs-probe class predictions = **match**; mismatches = 0; effective boosted rounds = 100.

## API warnings

Warnings captured: 8
See `gate2c_xgboost_warnings.csv`. Warnings about removed, unrecognized, or renamed arguments are material: A/B determinism alone does not prove that the intended parameter list was applied.

## Interpretation rule

- If probe predictions match submitted predictions, the observed submitted behavior is reproduced for this fold.
- Intended hyperparameters are verified only when the effective configuration evidence supports them.
- Any intended/effective discrepancy is a baseline-provenance problem, not evidence of a kTSP prediction change.
- Do not modernize or rerun the full standard-ML benchmark without master-chat approval.
