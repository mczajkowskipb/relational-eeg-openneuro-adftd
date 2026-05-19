# v2 executable reproducibility skeleton

This version keeps the v1 repository structure and adds a minimal executable Mode A path.

Implemented:

- base-R binary metrics with TP/TN/FP/FN, accuracy, balanced accuracy, precision/recall/specificity, class-wise F1, macro-F1, MCC, and optional rank-based AUC;
- metric consistency test;
- subject leakage firewall for ordinary CV, pooled EC+EO, and cross-condition transfer scenarios;
- synthetic smoke feature table, folds, job grid, and expected-metrics notes;
- minimal TSP/kTSP smoke runner;
- result collector;
- repeat-level statistical test script for frozen/example deltas;
- basic diagnostic figure generator using frozen/example outputs;
- P0/P1 Mode A extractors that filter P0/P1-like columns from frozen/example CSVs;
- frozen minimal example outputs for figures and statistics.

Not implemented in v2:

- full OpenNeuro derivative .set extraction;
- final server-side switchBox wrappers;
- full classic model wrappers;
- Tier 2-4 full benchmark execution;
- final paper numerical outputs.
