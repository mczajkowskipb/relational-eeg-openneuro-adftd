#!/usr/bin/env bash
set -euo pipefail
cat >&2 <<'MSG'
[rel-eeg] Full auxiliary Tier 2-4 reruns are not bundled as single-command public scripts in this compact repository snapshot.

Use the frozen paper outputs in:
  results/paper_final/

For reproducibility scope and rerun requirements, see:
  docs/REPRODUCIBILITY_SCOPE.md
  docs/reproducibility_guide.md
  docs/result_files.md
  docs/REVIEWER_QUICKSTART.md
MSG
exit 2
