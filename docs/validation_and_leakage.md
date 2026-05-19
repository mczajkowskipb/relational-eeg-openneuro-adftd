# Validation and leakage firewall

Subject-level separation is a hard constraint. All rows, acquisition-condition variants, and feature representations derived from a participant are assigned consistently according to the validation scenario.

Minimal fold schema:

`split_id, repeat_id, fold_id, subject_id, condition, split, task, label`

The test `tests/test_subject_leakage.R` checks ordinary CV, pooled EC+EO grouping, cross-condition transfer condition separation, non-empty train/test sets, and required train classes.
