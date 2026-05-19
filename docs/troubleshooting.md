# Troubleshooting

If `make smoke` fails, first check that `Rscript` is available and that file paths are run from the repository root.

If full extraction fails, verify OpenNeuro snapshots and derivative `.set` paths.

If leakage tests fail, inspect `split_id`, `subject_id`, `condition`, and `split` columns in the fold file.
