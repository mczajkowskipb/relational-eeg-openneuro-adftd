# Reviewer quickstart

This repository accompanies the manuscript:

Compact Relative-Ordering Models for Interpretable EEG-Based Dementia Classification

It contains scripts, configuration files, documentation, tests, and frozen machine-readable result outputs used to support the manuscript and Supplementary Material.

## What is included

The most important frozen outputs are in:

    results/paper_final/

This directory contains:
- summary tables used for the manuscript and Supplementary Material,
- selected-pair and recurrence summaries,
- statistical comparison tables,
- file manifests and checksums.

Closed revision analyses are in `results/revision/`:

- `gate2c/`: final handoff, metric lineage, Wilcoxon-filter provenance, and effective XGBoost configuration audit;
- `wp1a/`: demographic effect sizes, age/sex-only repeat metrics, P0/P1 sensitivity summaries, protocol, and validation report;
- `wp1b/`: original-versus-adjusted performance and exact-relation summaries at repeat and setting level, protocol, and validation report.

The canonical frozen-output path is:

    results/paper_final/

Other output copies, such as paper_outputs/, are retained for convenience or backward compatibility with earlier manuscript export scripts.

## What is not included

Large raw EEG files are not stored in this repository. The source datasets are public OpenNeuro / ADSZ-derived resources described in the manuscript and Supplementary Material. The repository provides scripts and documentation for reproducing the benchmark workflow from those public resources.

## Quick inspection

To inspect the frozen outputs:

    ls -lh results/paper_final
    find results/paper_final -maxdepth 3 -type f | sort

To verify checksums:

    cd results/paper_final
    sha256sum -c SHA256SUMS.txt

To inspect repository file sizes:

    head -50 docs/FILE_SIZE_MANIFEST.tsv

## Smoke tests

The repository includes lightweight tests and example outputs. These are intended to validate structure and schema, not to rerun the full benchmark.

    python -m pytest tests

R-based tests may require the R packages listed in the repository documentation.

## Full benchmark rerun

A full rerun requires downloading public EEG resources and executing the configured feature extraction, fold construction, model fitting, result collection, and paper-output export scripts. See:

    docs/reproducibility_guide.md
    docs/result_files.md
    docs/validation_and_leakage.md
    configs/
    scripts/

## Interpretation boundary

The frozen outputs support the manuscript's reported benchmark. Selected feature pairs are fitted model outputs and exploratory computational patterns. They should not be interpreted as validated clinical biomarkers or source-localised neurophysiological mechanisms.

For the revision, read WP1B as a **sensitivity analysis using training-fold-only linear additive adjustment for age and sex**. Its Jaccard fields measure original-versus-adjusted exact-relation agreement in corresponding folds, not general cross-fold stability. P0 and P1 share cohorts and repeated-CV design but use different fold assignments, so cross-representation paired tests are not supported.

The frozen standard-ML outputs include legacy XGBoost baselines whose effective configuration was audited after submission. See `results/revision/gate2c/gate2c_xgboost_parameter_audit.md`; no corrected XGBoost rerun is part of this package.
