# MASTER HANDOFF REPORT

## Gate 2C verdict

**Gate 2 remains CONDITIONAL PASS. Main kTSP predictive replay passed; full benchmark validation remains partial.**

No single global `full PASS` is issued because standard ML, full feature reconstruction, restrictions, ADSZ, AUC, and some auxiliary metric lineages remain partial or unsupported.

| Layer | Status | Evidence boundary |
|---|---|---|
| Main adaptive kTSP fitting | **PASS** | 4000 production-versus-replay predictions and corrected metrics |
| Fixed-K/non-disjoint envelope | **PARTIAL** | full exact-relation extraction exists; full prediction replay was intentionally not run |
| Real subject splits | **PARTIAL** | direct train/test CSV audit; subject separation and coverage pass, but exact P0/P1 fold assignments are not identical |
| EEG feature construction | **PARTIAL** | code timing and exported-table granularity audited; derivative-to-feature numerical replay not performed |
| Standard ML | **PARTIAL** | submitted predictions/metric lineage and code audited; full model rerun prohibited; XGBoost effective config separate |
| Metric lineage | **PARTIAL** | main tables/rankings verified if PASS; auxiliary restrictions/ADZS/ratio layers remain partial |
| Exact relations | **PARTIAL** | main 4000 exact relations independently reproduced; envelope and biological stability claims remain bounded |
| Model-size summaries | **PARTIAL** | exact rederived sizes supersede submitted heuristic structural summaries; manuscript not yet patched |
| Restrictions | **PARTIAL** | existing fits require output-specific lineage closure in Gate 3/WP5 |
| ADSZ | **PARTIAL** | external scope/provenance audit still required; no FTD |
| AUC | **NOT SUPPORTED** | no common frozen continuous score across production model families |

## Newly verified

- Main expected jobs: **4000**.
- Production-versus-replay prediction-mismatch jobs: **0**; mismatched prediction rows: **0**.
- Confusion-count mismatch jobs: **0**.
- Corrected macro-F1 mismatch jobs: **0**; balanced-accuracy mismatches: **0**; MCC mismatches: **0**.
- Direct representation-fold rows audited: **5224**; unexpected subject-overlap records: **0**.
- Representation-specific participant-universe failures: **0**; exact cross-representation fold-assignment mismatches: **1200**.
- Job-model metric rows independently reconstructed from frozen predictions: **76000**.
- The main Wilcoxon description is now evidence-based per fold: `featureNo=100` was requested on each outer-training fold; with `switchBox 1.48.0` and default `UpDown=TRUE`, the effective implementation retained up to 101 unique descriptors (or all available when fewer existed).
- Cross-condition outputs are explicitly classified as same-subject condition transfer, not generalization to new participants.

## Confirmed problems

- Raw submitted fold-level macro-F1 differs from the zero-division-safe reconstruction in **68019** job-model rows. Main downstream tables/rankings are accepted only if the Gate 2C comparisons above show zero downstream mismatches.
- Historical helper fold-assignment artifacts with duplicated keys: **1** file(s). They are non-authoritative; direct train/test files determine leakage status.
- Exact subject assignments differ between the P0 and P1 representation families in **1200** task/condition/repeat/fold groups, despite identical participant universes and complete 20-repeat coverage. This is a cross-representation comparability/design limitation, not train/test subject leakage; identical cross-representation folds must not be claimed.
- The nominal Wilcoxon setting was `featureNo=100`, but `switchBox 1.48.0` with default bidirectional (`UpDown=TRUE`) filtering uses an inclusive lower-tail index and therefore effectively returns up to 101 unique descriptors. This is preserved as submitted behavior and must be described as requested 100/effective up to 101 rather than silently truncating the fitted models.
- The submitted structural extractor used a noncanonical `krange=3:9`, and heuristic `capture.output(str(...))` feature counting was not a valid model-size extractor. Exact `fit$TSPs` outputs supersede it.
- Old approximate compactness statements (~3.3 pairs/~6.3 descriptors) must be replaced after final cross-check by exact summaries; working values for six best-performing predefined configurations are ~7.3 pairs, 14.7 feature mentions, and 11.9 unique descriptors.
- XGBoost submitted-API warnings captured in the effective-parameter probe: **8**. Determinism does not establish intended-parameter application; inspect `gate2c_xgboost_intended_vs_effective.csv` and the raw configs.
- AUC has no common frozen continuous-score lineage and is not supported for the submitted benchmark.

## Cannot verify

- Exact production selected K was not stored authoritatively for **4000** main jobs. The Gate 2C replay K is compared with the independent 4000-fit exact replay, but that is not equivalent to recovering old production K objects.
- Full derivative-EEG-to-feature numerical reconstruction for every subject.
- Full prediction equality for fixed-K/non-disjoint envelope models and for all standard-ML models across all settings.
- Complete restriction, recording-condition, recurrence/stability, ADSZ, and fixed-ratio metric lineage.
- External FTD validation, biological stability significance, and any model-selection-unbiased best-of-grid estimate.

## Prediction and metric comparison

Tolerance was fixed at **1e-12**. Prediction mismatches: **0 rows / 0 jobs**. Truth mismatches: **0**. Confusion mismatches: **0 jobs**. Corrected macro-F1 mismatches: **0 jobs**.

The authoritative row-level evidence is `audit/gate2c_main_4000_comparison.csv`; the summary is `audit/gate2c_main_4000_summary.csv`. A mismatch in predictions, confusion, corrected main macro-F1, balanced accuracy, MCC, or status is a stop condition.

## Leakage audit

Direct-fold failures: **0**; unexpected train/test subject overlaps: **0**; participant-universe failures across representations: **0**; exact representation-split mismatches: **1200**; once-per-repeat coverage failures: **0**; 20-total coverage failures: **0**; kTSP/ML paired-grid failures: **0**.

Within each representation, train/test subject separation and repeated-CV coverage pass. P0 and P1 use two different fold-assignment families, so cross-representation paired-fold wording is unsupported. Feature extraction and within-row deterministic transforms are distinguished from supervised fold operations. Representation/best-configuration selection from outer results is labelled **model-selection bias risk**, not subject leakage. See `audit/gate2c_transform_timing_audit.csv`.

## Baseline audit

| Model | Code/config status | Tuning | Continuous score saved |
|---|---|---|---|
| `majority` | VERIFIED_IN_SUBMITTED_CODE | fixed null baseline | False |
| `glmnet_ridge` | VERIFIED_IN_SUBMITTED_CODE | alpha fixed; lambda tuned by inner CV | False |
| `glmnet_lasso` | VERIFIED_IN_SUBMITTED_CODE | alpha fixed; lambda tuned by inner CV | False |
| `glmnet_elasticnet` | VERIFIED_IN_SUBMITTED_CODE | alpha fixed; lambda tuned by inner CV | False |
| `svm_linear_liblinear` | VERIFIED_IN_SUBMITTED_CODE | fixed/prespecified | False |
| `knn_euclidean` | VERIFIED_IN_SUBMITTED_CODE | fixed/prespecified | False |
| `ranger_rf` | VERIFIED_IN_SUBMITTED_CODE | fixed/prespecified | False |
| `xgboost_shallow` | CANNOT_FULLY_VERIFY_UNTIL_EFFECTIVE_CONFIG_AUDIT | intended fixed/prespecified; effective application requires audit | False |
| `xgboost_default` | CANNOT_FULLY_VERIFY_UNTIL_EFFECTIVE_CONFIG_AUDIT | intended fixed/prespecified; effective application requires audit | False |
| `sda_shrinklda` | VERIFIED_IN_SUBMITTED_CODE | shrinkage estimated internally; no outer-test tuning | False |

Standard-ML status remains **PARTIAL**: the frozen prediction/metric lineage and exact submitted code are audited, but full refitting was deliberately not performed. Glmnet and ranger showed stochastic/non-identical rerun behavior in the earlier target audit; XGBoost requires effective-configuration interpretation.

## Gate 3 protocols

The output contains `GATE3_EXPERIMENT_PROTOCOLS.md`, `GATE3_COST_ESTIMATE.csv`, and `GATE3_DECISION_MATRIX.csv`. No Gate 3 experiment was run.

Priorities: **P1** demographic confounding, permutation stability, and the nested-selection decision; **P2** error profiles, restrictions, ADSZ provenance; **P3** MMSE/external-FTD feasibility only.

## Decisions required from master

1. Approve explicit disclosure that P0 and P1 used the same participant cohorts and repeated-CV design but not identical subject assignments to folds; prohibit paired cross-representation fold tests unless reanalysed appropriately.
2. Approve WP1 scope: six headline settings or all five representations across eight task-condition settings.
3. Approve permutation sequence: B=100 smoke, then whether to extend to B=500 or B=1000.
4. Choose claim-only handling versus kTSP representation-only nested sensitivity; do not default to the full standard-ML nested maximum.
5. Decide whether ADSZ retains only locked model-level transfer or also an explicitly exploratory multiplicity-corrected 118-pair screen.
6. Approve removal of AUC from Methods/results unless a separate all-model score-persisting rerun is authorized.

## Recommended first Gate 3 experiment

After master approval, start with **WP1 metadata audit plus the 800-fit age+sex-only baseline on the existing outer splits**. It is the least expensive experiment that directly answers Reviewer 1 and determines whether the residualization sensitivity should proceed unchanged or be narrowed because of metadata missingness.
