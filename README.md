# Relational EEG OpenNeuro AD/FTD/CN benchmark

This repository is a manuscript-specific reproducibility package for the OpenNeuro AD/FTD/CN EEG benchmark.

It accompanies the manuscript:

**Compact Relative-Ordering Models for Interpretable EEG-Based Dementia Classification**

The repository focuses on a reproducible benchmark workflow built around subject-level validation, frozen benchmark outputs, statistical summaries, and manuscript-level table exports. It is designed to let reviewers and collaborators verify the main result tables without downloading the full EEG datasets or regenerating all EEG features.

## What this repository reproduces

The current workflow reproduces the quick frozen-output mode of the benchmark:

```text
frozen manuscript-level CSV outputs
        ↓
schema validation
        ↓
statistical summary export
        ↓
analysis-table export
        ↓
manuscript-table export
```

The repository also includes a small smoke-test benchmark using synthetic feature tables. This smoke mode verifies that the repository structure, metric functions, leakage checks, result collection, and table-export scripts work correctly.

Revision evidence from the closed Gate 2C, WP1A, and WP1B workflows is available under `results/revision/`. These are frozen, validated outputs. They are provided for inspection and manuscript-level verification; they are not an instruction to rerun the 4,000 primary k-TSP records.

## Data policy

Raw OpenNeuro EEG files and derivative EEG files are not redistributed in this repository.

The quick reproducibility mode uses selected frozen CSV outputs stored under:

```text
results/paper_final/
```

These files contain curated manuscript-level outputs such as result tables, statistical summaries, selected relation summaries, checksums, and analysis tables. They are small enough to remain in the repository and allow rapid verification of the reported results.

## Main quick-start commands

Clone the repository and install the minimal Python/R dependencies.

```bash
make smoke
make validate-frozen
make validate-revision
make paper-frozen
```

The expected behavior is:

- `make smoke` runs a small synthetic benchmark and internal validation tests.
- `make validate-frozen` checks the schema of the frozen manuscript-level CSV files.
- `make validate-revision` checks the closed Gate 2C/WP1A/WP1B files without fitting or replay.
- `make paper-frozen` exports manuscript-level tables and statistical summaries from `results/paper_final/`.

## Recommended setup

Python dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

The R scripts require a working `Rscript` installation. The full R package environment should be restored or installed according to the local system configuration.

## Repository layout

```text
configs/                 benchmark and dataset configuration files
scripts/                 shell wrappers for reproducibility targets
python/                  lightweight Python utilities and validators
R/                       R functions and benchmark/statistical scripts
tests/                   metric, leakage, schema, and structure tests
examples/                synthetic smoke-test feature tables
results/paper_final/     frozen manuscript-level outputs
results/revision/        frozen Gate 2C, WP1A, and WP1B revision evidence
paper_outputs/tables/    exported manuscript-level tables
docs/                    reproducibility and benchmark documentation
```

## Validation principles

The benchmark is organized around subject-level validation. All rows, feature representations, and acquisition-condition variants derived from the same participant must be assigned consistently according to the validation scenario.

The repository includes explicit checks for:

- metric consistency;
- subject leakage;
- required output files;
- frozen-output schema compatibility.

## Frozen-output mode

The frozen-output mode is the recommended quick reproducibility path. It does not regenerate EEG features. Instead, it validates and exports curated CSV files derived from the final benchmark pipeline.

This mode is useful for reviewers who want to verify the consistency of the manuscript tables and statistical summaries without running the full EEG processing workflow.

The revision analyses preserve the following interpretation boundaries:

- the prespecified main k-TSP comparison is reported as two wins, one near tie, and three losses versus the strongest setting-specific standard-ML comparator;
- XGBoost rows are legacy baselines with an audited effective configuration, not corrected reruns;
- WP1A is an age-and-sex-only baseline, and WP1B is a sensitivity analysis using training-fold-only linear additive adjustment for age and sex;
- WP1B exact-relation Jaccard values compare original with adjusted fits in corresponding folds and are not general cross-fold stability estimates;
- AUC, permutation analysis, WP1C, and additional model fitting are outside this revision package.

## Figures

This repository exports tables and diagnostic summaries. Publication-quality figures may be curated separately from the exported CSV files.

## Citation

Please cite the associated manuscript and this repository if you use the benchmark outputs, scripts, or reproducibility workflow.
