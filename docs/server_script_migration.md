# Server script migration

Bind the existing server-side scripts in this order:

1. P0 amplitude-decile extraction -> `python/extract_p0_amplitude_deciles.py`
2. P1 PSD/bandpower extraction -> `python/extract_p1_psd_bandpower.py`
3. task and fold generation -> `R/scripts/build_tasks.R`, `R/scripts/make_subject_folds.R`
4. switchBox adapter -> `R/lib/switchbox_adapter.R`
5. classic baselines -> `R/lib/classic_models.R`
6. job runner -> `R/scripts/run_single_job.R`, `R/scripts/run_grid_parallel.R`
7. collectors and statistics -> `R/scripts/collect_results.R`, `R/scripts/run_statistical_tests.R`
8. figures -> `R/scripts/make_basic_figures.R`

Do not move raw EEG, private tables, or old exploratory job logs into the public repo.
