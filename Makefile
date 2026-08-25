SHELL := /bin/bash
PYTHON ?= python3

.PHONY: setup download audit features folds smoke tier1 auxiliary collect stats figures validate-frozen validate-revision paper-frozen paper-frozen-figures clean-intermediate test-python test-r

setup:
	bash scripts/00_setup_project.sh

download:
	bash scripts/01_download_openneuro.sh

audit:
	bash scripts/02_audit_openneuro.sh

features:
	bash scripts/03_extract_features_p0_p1.sh

folds:
	bash scripts/04_build_tasks_and_folds.sh

smoke: setup test-python test-r
	bash scripts/05_run_smoke.sh

tier1:
	bash scripts/06_run_tier1_main.sh

auxiliary:
	bash scripts/07_run_auxiliary_tiers.sh

collect:
	bash scripts/08_collect_results.sh

stats:
	bash scripts/09_run_statistics.sh

figures:
	bash scripts/10_make_basic_figures.sh

validate-frozen:
	$(PYTHON) tests/test_frozen_outputs_schema.py --root results/paper_final

validate-revision:
	$(PYTHON) tests/test_revision_outputs.py
	$(PYTHON) tests/test_revision_numeric_claims.py

paper-frozen: validate-frozen
	bash scripts/12_export_paper_frozen_outputs.sh --source results/paper_final --out-tables paper_outputs/tables

paper-frozen-figures: paper-frozen
	bash scripts/13_make_paper_frozen_basic_figures.sh --source results/paper_final --out paper_outputs/figures

test-python:
	$(PYTHON) tests/test_feature_shapes.py
	$(PYTHON) tests/test_required_outputs.py

test-r:
	Rscript tests/test_metric_consistency.R
	Rscript tests/test_subject_leakage.R

clean-intermediate:
	rm -rf data/features/*.csv data/manifests/*.csv results/jobs/smoke results/summaries/*.csv results/stat_tests/*.csv paper_outputs/figures/*.pdf paper_outputs/figures/*.svg
