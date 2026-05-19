# Statistical testing

Primary metric: macro-F1. Secondary metrics: MCC and balanced accuracy.

Fold-level metrics are averaged within each repeat. The planned paper-level paired tests use n = 20 repeat-level observations rather than treating all folds as independent.

Implemented quick-mode tests include paired Wilcoxon signed-rank, paired t-test sensitivity, bootstrap confidence intervals for mean paired delta, and Holm/BH corrections when multiple comparisons are available.
