# Code availability statement

All source code required for the quick reproducibility mode is provided in this repository.

The repository contains scripts for validating frozen manuscript-level outputs, checking metric consistency, checking subject-level leakage constraints, exporting statistical summaries, and regenerating manuscript-level result tables.

Raw OpenNeuro EEG files and derivative EEG files are not redistributed. The frozen-output mode uses curated CSV outputs stored under `results/paper_final/` to allow rapid verification of the manuscript-level results.

The repository includes a smoke-test mode based on synthetic feature tables, allowing users to verify the benchmark structure and core reproducibility scripts on a new machine.
