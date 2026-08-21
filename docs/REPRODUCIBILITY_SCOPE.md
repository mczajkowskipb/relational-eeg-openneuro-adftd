# Reproducibility scope

This repository is a compact public reproducibility package for the manuscript:

Compact Relative-Ordering Models for Interpretable EEG-Based Dementia Classification

## Directly verifiable content

The canonical frozen manuscript outputs are stored in:

    results/paper_final/

These files include machine-readable result tables, selected-pair summaries, statistical summaries, manifests, and checksums supporting the manuscript and Supplementary Material.

Closed revision evidence is stored separately in:

    results/revision/gate2c/
    results/revision/wp1a/
    results/revision/wp1b/

The WP1A and WP1B directories contain the final summary and repeat-level CSVs, protocols, validation reports, validation markers, and hard-stop markers. The Gate 2C directory contains the final handoff, metric-lineage and Wilcoxon-filter audits, and the intended-versus-effective XGBoost audit.

## Scope boundary

This compact repository snapshot does not provide a single-command raw-to-paper rerun from downloaded EEG files.

Large public EEG resources are not redistributed. Source-level preprocessing was inherited from public OpenNeuro/derivative resources, as described in the manuscript and Supplementary Material. Full benchmark reruns require the public source resources, the appropriate computing environment, and the original large feature-table workflow.

Therefore, the repository should be cited as a frozen-output and workflow-documentation package, not as a fully containerised raw-EEG reprocessing pipeline.

The repository does not by itself permit a complete raw-input-to-fit replay of WP1A or WP1B because public source datasets and large fold-level feature tables are not redistributed. Their evidence packages record paths, hashes, protocols, and validated outputs. No claim of demographic independence or confound-free performance follows from these sensitivity analyses.

## Canonical outputs

When checking results reported in the manuscript or Supplementary Material, use:

    results/paper_final/

Other output copies, such as paper_outputs/, results/analysis_tables/paper_final/, and results/stat_tests/paper_final/, are retained for export compatibility and convenience.

Do not treat historical probability-score/AUC fields in legacy outputs as manuscript endpoints. The revised manuscript reports macro-F1 reconstructed from confusion counts with zero-division=0, balanced accuracy, MCC, and class-specific metrics. The erroneous legacy raw macro-F1 field was not used in manuscript tables.
