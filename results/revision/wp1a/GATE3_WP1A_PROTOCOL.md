# Gate 3, Experiment 1 — WP1A

## Status and scope

This protocol implements only the master-approved demographic metadata audit and the age-and-sex-only prediction baseline. It does not residualize EEG features, run permutation analyses, refit EEG classifiers, select EEG relations, or calculate AUC. Completion of WP1A is a mandatory stop point; WP1B requires a separate master decision.

## Frozen design

- Eight task–condition settings: four binary diagnostic tasks in each of `ds004504__EC` and `ds006036__EO_or_photomark`.
- Two independently scheduled outer-split families, P0 and P1, reported as separate strata.
- Twenty repetitions and five outer folds per family-setting.
- Total: `8 × 2 × 20 × 5 = 1600` outer age+sex model fits.
- P0 split carrier: `P0_derivative_amplitude_deciles / RAW_DECILES`.
- P1 split carrier: `P1_psd_bandpower_from_derivatives / PSD_ABSOLUTE_CHANNEL_BAND`.

The two representation tables above are used only to recover their subject schedules and task labels. They are required to contain `subject_id` and `Class`; age and sex are joined from the authoritative `participants.tsv` tables and are never expected to be embedded in a fold table. WP1A never reads or models EEG feature columns. The frozen Gate 2C main-grid input is content-pinned by SHA-256; file modification dates are not treated as evidence of identity.

## Metadata audit

The authoritative demographic inputs are the BIDS `participants.tsv` files from ds004504 and ds006036. Each must contain the known 88-person cohort (36 AD, 23 FTD, 29 CN). They are joined by exact participant identifier and must agree exactly across EC and EO/photo for participant universe, base diagnosis, age, and normalized sex.

For every split-family, task, and condition, the union of the first complete outer partition (`repeat=1`, represented by fold 1 train+test) defines the feature-table reference cohort. Its `subject_id` values are joined exactly to the task-appropriate rows of the authoritative `participants.tsv`; the task label reconstructed from the source diagnosis must equal fold `Class`. Every one of the 1600 train/test files is subsequently required to match the audited reference for participant universe, diagnosis, source-derived age, and source-derived normalized sex.

The audit checks:

- exact, nonempty and unique `subject_id` values;
- no subject overlap between outer train and test sets;
- the expected two diagnostic classes;
- completeness and numeric validity of age;
- normalization of explicit textual sex values (`F/female` and `M/male`, including Polish textual equivalents);
- exact P0/P1 agreement in participant universe, diagnosis, age, and sex within each task–condition setting;
- exact ds004504-versus-ds006036 participant linkage and agreement;
- exact feature-fold-versus-source-`participants.tsv` linkage;
- exact EC-versus-EO/photo agreement within both P0 and P1.

Unknown numeric sex encodings are not guessed. Missing age, missing/unknown sex, or any source/fold inconsistency causes a documented stop; WP1A does not silently impute or delete participants.

Before the 1600-fit grid, the workflow runs a metadata-only preflight across all 1600 outer fits and then one complete age+sex ridge smoke fit for each of the 16 split-family settings. The full grid starts only after all 1600 joins and all 16 smoke fits pass. The preflight writes a fit-level join audit, and its cohort-level audit files must be byte-identical to the corresponding audits produced by the full run.

For each condition, all participants and the AD, FTD, and CN groups are reported separately with `n`, missingness, age mean/SD, median/IQR, range, sex counts, and female proportion. A supplementary fold-level audit records the corresponding binary task cohorts in P0 and P1.

## Demographic effect sizes

For each of the eight task–condition contrasts, group A is the prespecified positive class and group B the negative class. The following descriptive quantities are reported:

- Hedges’ g for age, oriented as group A minus group B;
- female-proportion difference, oriented as group A minus group B;
- standardized mean difference for the binary female indicator;
- female odds ratio with a descriptive 95% Wald interval (Haldane–Anscombe correction if a cell is zero);
- phi coefficient for the 2×2 group-by-sex table.

No null-hypothesis p-value is used to claim that confounding is absent. Small effects or low age+sex predictive performance do not establish absence of demographic confounding.

## Age+sex-only model

For each outer split:

1. Age mean and SD are estimated exclusively from the outer-training participants.
2. Training and test ages are transformed with those training statistics.
3. Sex is represented by the prespecified indicator `male=0`, `female=1`; no category is inferred from test data.
4. A binomial ridge logistic model is fitted with `glmnet`, `alpha=0`, an intercept, and `standardize=FALSE` because age has already been scaled from the outer training fold.
5. Lambda is selected by deterministic, stratified five-fold inner CV on the outer-training fold only, minimizing binomial deviance (`lambda.min`). Inner folds are derived from a stable protocol seed and recorded in the fit audit.
6. The prespecified threshold `0.5` converts the test probability to a class label. Probabilities are not retained in the WP1A result artifact and are not used for AUC.

Each participant must receive exactly one out-of-fold class prediction in each repetition, separately within P0 and P1.

## Metrics and reporting

Metrics are reconstructed after concatenating the five outer test folds within each split-family, task, condition, and repetition:

- macro-F1 with every undefined division mapped to zero;
- balanced accuracy;
- Matthews correlation coefficient, mapped to zero when its denominator is zero;
- accuracy;
- precision, recall, F1, and support for each class.

The repeat-level table therefore contains `2 × 8 × 20 = 320` rows. Split-family sensitivity is a long, stratified descriptive table: P0 and P1 receive separate rows and summaries. Repeat identifiers are not paired across representation families, and no paired cross-representation test is performed.

## Required outputs

- `gate3_wp1a_metadata_audit.csv`
- `gate3_wp1a_demographic_effect_sizes.csv`
- `gate3_wp1a_oof_predictions.csv`
- `gate3_wp1a_repeat_metrics.csv`
- `gate3_wp1a_split_family_sensitivity.csv`
- protocol, R/Python session information, frozen grid and source hashes, preflight/model-smoke/fit/coverage audits, validation report, manifest, and archive SHA-256

## Interpretation and stop rule

WP1A estimates whether age and sex alone predict diagnostic labels under the two existing split schedules. It is not an adjusted EEG analysis and cannot, by itself, exclude confounding. After independent validation and packaging, the workflow writes an explicit stop marker and exits. It never launches WP1B, residualization, or permutation analysis.
