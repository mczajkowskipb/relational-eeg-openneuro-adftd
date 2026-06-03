#!/usr/bin/env bash
set -euo pipefail
cat >&2 <<'MSG'
[rel-eeg] Full public-data download is not bundled as a one-command script in this compact repository snapshot.

This repository provides frozen manuscript outputs, configurations, documentation, smoke examples,
and scripts used around the benchmark workflow. Large OpenNeuro/ADSZ resources are not redistributed.

See:
  docs/reproducibility_guide.md
  docs/code_availability_statement.md
  docs/REVIEWER_QUICKSTART.md
MSG
exit 2
