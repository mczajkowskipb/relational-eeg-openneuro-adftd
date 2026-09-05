# Protocol: demographic, stability, and interpretability sensitivity analyses

## Shared production contract

The experiments preserved the main benchmark's participant-wise repeated
five-fold cross-validation (20 repeats), class levels, `switchBox` learner,
training-fold Wilcoxon filter, voting-direction learning, disjoint relation
selection, `KbyTtest`, `K in {1,3,5,9}`, `handleTies=FALSE`, and the verified
`featureNo=100` implementation. No public smoke implementation was substituted
for the production runner.

## EXP1: participant-level label permutation

- Scope: AD versus CN, FTD versus CN, and AD+FTD versus CN in EC and EO/photo;
  regional absolute PSD/bandpower only.
- Labels were permuted at participant level with class counts retained. A given
  seed used the same participant-level permutation in EC and EO/photo.
- The complete supervised pipeline was refitted for each map.
- Final run: `B=1000`, seed `20260904`, 600,000 accepted fold fits.
- Exact-pair inference used the maximum directed-pair recurrence within each
  setting, followed by Holm correction across six settings.
- Four prespecified motifs were tested in each setting; the 24 setting-motif
  tests used global Holm correction. Six setting-level omnibus motif tests were
  corrected separately.
- Empirical p-values use `(1 + count(T_perm >= T_obs)) / (B + 1)`.

## EXP2: slow-fast restriction by setting

- The six primary regional-PSD settings were refitted with the unrestricted
  300-pair space and the 150-pair slow-fast space.
- Cross-validation splits and all learner settings were unchanged.
- Macro-F1, balanced accuracy, MCC, candidate counts, selected K, paired repeat
  differences, and participant-bootstrap intervals were retained.

## EXP3: repeated demographic matching

- Exact sex matching and nearest-neighbour age matching without replacement.
- Caliper: 0.25 pooled age standard deviations; seed `20260905`.
- 100 unique matched cohorts per task. The same participant set was used in EC
  and EO/photo and in both prespecified PSD representations.
- The primary contrast is the matched model minus the corresponding unadjusted
  model evaluated on the same matched participants and folds.
- Reported 2.5th-97.5th percentile ranges describe sensitivity across matching
  solutions; they are not sampling confidence intervals.

## EXP4: targeted relation-pattern sensitivity

- Scope: the six primary regional-PSD settings.
- Seven variants: leave out theta-alpha, slow-fast, anterior-posterior, or the
  frontal-theta/occipital-alpha pair; and theta-alpha-only, slow-fast-only, or
  anterior-posterior-only.
- Frontal-theta/occipital-alpha-only was omitted because it contains one
  eligible unordered candidate pair.
- Participant-bootstrap intervals are conditional on fixed repeated-CV
  out-of-fold predictions, marginal, and not multiplicity corrected.

## Interpretation boundary

Predictive robustness, exact-rule recurrence, pattern-level recurrence, and
biological plausibility are distinct. These analyses do not establish a
validated biomarker, demographic independence, causality, source localisation,
clinical validation, or universal classifier superiority.

