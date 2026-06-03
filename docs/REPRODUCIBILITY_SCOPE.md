# Reproducibility scope

This repository is a compact public reproducibility package for the manuscript:

Compact Relative-Ordering Models for Interpretable EEG-Based Dementia Classification

## What can be verified directly

The canonical frozen manuscript outputs are stored in:

    results/paper_final/

These files include machine-readable result tables, selected-pair summaries, statistical summaries, manifests, and checksums supporting the manuscript and Supplementary Material.

The following can be checked directly from the repository:

- presence of required paper-output CSV files,
- schema and basic consistency of frozen outputs,
- checksums of the frozen output package,
- smoke/example scripts on small example tables,
- documentation and configuration files used to describe the benchmark.

## What is not a one-command rerun

This compact repository snapshot does not provide a single-command raw-to-paper rerun from downloaded EEG files.

Large public EEG resources are not redistributed. Source-level preprocessing was inherited from public OpenNeuro/derivative resources, as described in the manuscript and Supplementary Material. Full benchmark reruns require the public source resources, the appropriate computing environment, and the original large feature-table workflow.

Therefore, the repository should be cited as a frozen-output and workflow-documentation package, not as a fully containerised raw-EEG reprocessing pipeline.

## Canonical outputs

When checking results reported in the manuscript or Supplementary Material, use:

    results/paper_final/

Other output copies, such as:

    paper_outputs/
    results/analysis_tables/paper_final/
    results/stat_tests/paper_final/

are retained for export compatibility and convenience.
