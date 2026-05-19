# Benchmark design

This repository supports the reproducibility workflow for a subject-wise OpenNeuro AD/FTD/CN EEG benchmark.

## Main benchmark idea

The benchmark evaluates compact relational EEG signatures and conventional machine-learning baselines under subject-level validation.

The focus is not on producing the largest possible headline accuracy, but on transparent, leakage-conscious, and reproducible evaluation across acquisition conditions and feature layers.

## Validation principle

Subject-level separation is a hard constraint.

All rows, acquisition-condition variants, and feature representations derived from the same participant must be assigned consistently according to the validation scenario.

## Main scenarios

The frozen outputs summarize several benchmark scenarios, including:

- main disease benchmark;
- cross-condition transfer summaries;
- pooled acquisition-condition evaluation with subject grouping.

## Metrics

Primary and secondary metrics include:

- macro-F1;
- MCC;
- balanced accuracy;
- class-specific F1;
- accuracy.

The exact exported metrics are stored in the frozen CSV outputs.

## Statistical comparison

The statistical summaries are exported from repeat-level comparisons. This avoids treating all folds as independent observations.
