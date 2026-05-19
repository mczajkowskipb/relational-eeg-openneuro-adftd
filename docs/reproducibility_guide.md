# Reproducibility guide

This repository provides a manuscript-specific reproducibility workflow for the OpenNeuro AD/FTD/CN EEG benchmark.

The recommended reproducibility path is the quick frozen-output mode. It verifies the repository structure, validates frozen manuscript-level outputs, and exports result tables and statistical summaries.

## Quick reproducibility mode

Run:

```bash
make smoke
make validate-frozen
make paper-frozen
```

Expected outputs:

```text
results/stat_tests/paper_final/
results/analysis_tables/paper_final/
paper_outputs/tables/
```

The command `make smoke` runs a small synthetic benchmark and internal tests. It is intended to verify that the repository functions correctly on a new machine.

The command `make validate-frozen` validates the schema of the frozen manuscript-level CSV outputs in `results/paper_final/`.

The command `make paper-frozen` exports the curated tables and statistical summaries used by the manuscript-level reporting workflow.

## Full EEG-derived workflow

The full EEG-derived workflow is treated as an advanced reproduction path. It starts from public OpenNeuro EEG resources and regenerates feature layers before benchmark execution.

The current recommended reviewer-facing path is the frozen-output mode, because it is lightweight, deterministic, and does not require downloading or processing EEG files.

## Integrity checks

Frozen outputs are accompanied by manifest and checksum files:

```text
results/paper_final/MANIFEST_files.txt
results/paper_final/SHA256SUMS.txt
```

Checksums should be evaluated from the repository root:

```bash
sha256sum -c results/paper_final/SHA256SUMS.txt
```

## Expected scope

This repository is focused on reproducing the analyses reported in the manuscript. It is not intended to serve as a general-purpose EEG analysis toolbox.
