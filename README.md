# relational-eeg-openneuro-adftd

Executable reproducibility skeleton for the manuscript:

**Compact Pairwise-Rank EEG Signatures for AD/FTD/CN Classification Across Acquisition Conditions**

This repository reproduces the OpenNeuro-derived benchmark reported in the manuscript. It is a paper-specific reproducible benchmark package, not a general-purpose RXA/EEG software library.

## 1. What this repository reproduces

The intended paper workflow is:

```text
public OpenNeuro derivative EEG files (.set)
  -> subject registry and EC/EO audit
  -> P0 amplitude-decile feature layer
  -> P1 PSD/bandpower feature layer
  -> subject-level folds
  -> compact pairwise-rank TSP/kTSP and conventional ML baselines
  -> collected metrics
  -> repeat-level statistical tests
  -> result tables and diagnostic figures
```

The main paper results are based on public derivative EEG files, subject-level validation, and repeat-level statistical comparisons. Raw EEG preprocessing is not claimed as the main contribution.

## 2. What this repository does not contain

This repository does **not** redistribute raw EEG files, full OpenNeuro derivative `.set` files, large job logs, private collaborator tables, or development-stage exploratory outputs. These are either downloaded from OpenNeuro or archived separately as frozen artifacts.

The repository does **not** implement RLR, relKNN, relational trees, deep learning, graph/connectivity pipelines, or new algorithms outside the paper scope.

## 3. Reproducibility modes

### Mode A1: smoke reproducibility

Technical smoke mode for reviewers and developers. It runs without downloading OpenNeuro and without full EEG feature extraction.

Inputs:

- `examples/smoke_feature_tables/features_small.csv`
- `examples/smoke_feature_tables/folds_small.csv`
- `examples/smoke_feature_tables/job_grid_small.csv`
- `results/example_outputs/*.csv`

Outputs:

- smoke benchmark results in `results/jobs/smoke/`
- collected smoke summary in `results/summaries/`
- example statistical tests in `results/stat_tests/`
- optional basic diagnostic figures in `paper_outputs/figures/`

Run:

```bash
make setup
make smoke
make collect
make stats
make figures
```

### Mode A2: frozen paper-level reproduction

This is the preferred quick mode for manuscript-level checks. It uses the curated small CSV package in `results/paper_final/` and does not regenerate the final polished manuscript figures.

Run:

```bash
make validate-frozen
make paper-frozen
```

Optional basic visual sanity checks, not final manuscript artwork:

```bash
make paper-frozen-figures
```

Expected input directory:

```text
results/paper_final/tables/
results/paper_final/stat_tests/
results/paper_final/analysis_tables/
results/paper_final/key_files/
```

### Mode B: full OpenNeuro-derived pipeline

Full reproduction from public OpenNeuro derivative EEG files. The executable wrappers are present, but full `.set` extraction still requires binding the final server-side extraction scripts.

```bash
make download
make audit
make features
make folds
make tier1
make collect
make stats
make figures
```

## 4. Dataset versions

The intended datasets are OpenNeuro `ds004504` and `ds006036`. The main paper path uses public derivative `.set` files. Exact dataset snapshots must be pinned before public release in `configs/datasets.yaml`.

## 5. Feature layers

Final paper feature layers only:

- P0: `RAW_DECILES`, `DERIVED_DECILES_ALL`, `REGION_AGGREGATES_ALL`
- P1: `PSD_ABSOLUTE_CHANNEL_BAND`, `PSD_REGION_ABSOLUTE`

Connectivity, RLR, relKNN, trees, and deep learning are intentionally disabled or absent.

## 6. Validation design

Subject-level separation is a hard constraint. All rows, acquisition-condition variants, and feature representations derived from a participant are assigned consistently according to the validation scenario.

The minimal fold schema is:

```text
split_id, repeat_id, fold_id, subject_id, condition, split, task, label
```

Optional column:

```text
scenario
```

## 7. Models

Relational core:

- TSP k=1
- kTSP k=3/5/9, disjoint and non-disjoint
- kTSP CV-selected variants

Classic fast baselines:

- majority
- glmnet ridge/lasso/elasticnet
- linear SVM/liblinear
- Euclidean kNN
- ranger random forest
- shallow/default XGBoost
- shrinkage LDA

In this v2 skeleton, Mode A executes a minimal base-R subset: `majority`, `TSP_k1`, and `kTSP_k3_disjoint`/`kTSP_k3_nondisjoint`. Full adapters are kept as integration points.

## 8. Statistical testing

Primary metric: macro-F1.

Secondary metrics: MCC and balanced accuracy.

The intended paper-level comparison uses repeat-level observations, not fold-level observations treated as independent samples. The example implementation computes paired Wilcoxon, paired t-test sensitivity, bootstrap confidence intervals, and simple multiple-testing corrections on frozen/example tables.

## 9. Output files

Key output standards are described in `docs/result_files.md`. In short:

- `metrics.csv` contains fold-level model metrics.
- `model_structure.csv` contains selected TSP/kTSP relations.
- collected files are written to `results/summaries/`.
- statistical tests are written to `results/stat_tests/`.
- diagnostic figures are written to `paper_outputs/figures/`.

## 10. Reproducing manuscript tables

The manuscript tables should be generated from collected CSVs rather than manually typed. In quick mode, example tables are regenerated from `results/example_outputs/`.

## 11. Citation

Use `CITATION.cff`. Update author list, DOI, repository URL, and manuscript DOI before release.


## 12. v3 frozen-output policy

The repository should not automatically generate many publication-style figures. The paper figures can be manually polished or regenerated from the exported CSVs. The executable quick-reproduction path focuses on:

- validating the frozen CSV schema,
- exporting final paper-level tables,
- keeping repeat-level statistical summaries visible,
- providing only optional basic diagnostic figures.

See `docs/frozen_outputs.md`.
