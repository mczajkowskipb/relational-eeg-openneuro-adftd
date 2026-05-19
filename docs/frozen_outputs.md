# Frozen paper-final outputs

`results/paper_final/` is the quick-reproduction input for manuscript-level tables and statistical summaries. It is deliberately small and curated. It is not a dump of all historical runs.

## Purpose

The frozen package allows reviewers to verify the final reported tables without downloading OpenNeuro EEG files or rerunning the full benchmark.

It should contain:

```text
results/paper_final/
├── tables/
├── stat_tests/
├── analysis_tables/
├── key_files/
├── README.md
├── MANIFEST_files.txt
└── SHA256SUMS.txt
```

## Required command sequence

```bash
make validate-frozen
make paper-frozen
```

`make paper-frozen` validates the CSV schema and exports selected tables/statistical summaries to `paper_outputs/tables/`, `results/stat_tests/paper_final/`, and `results/analysis_tables/paper_final/`.

It does **not** regenerate final manuscript figures by default. Final journal figures may be curated separately from these tables. A very small optional visual sanity check is available via:

```bash
make paper-frozen-figures
```

## What not to include

Do not include:

- raw OpenNeuro EEG,
- public derivative `.set` files,
- full job-level logs,
- old runs,
- RLR/relKNN/tree/deep-learning experiments,
- TUH experiments,
- collaborator-private development tables.

## Source-of-truth rule

Only one frozen package should be treated as the current paper source of truth. Previous folders such as early exports, metric-fix backups, or exploratory dated runs should remain outside the public quick-reproduction path.
