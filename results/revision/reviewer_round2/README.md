# Reviewer-round-2 controlled analyses

This directory contains the compact public evidence package for the additional
demographic, stability, and interpretability analyses requested during the
BSPC-D-26-12230 major revision. It does not contain raw EEG, derivative feature
tables, per-fold model objects, or the internal server work directory.

All four analyses used the accepted production runner with SHA-256
`c64ab42fbcb13e3664eab8f0ad6c638bd4661c5d778fb4f1091fe486a346e25a`
and the accepted Gate 2C source grid with SHA-256
`0abaf4e5500778c5c91f77803f2c43e62af3ef464977ad4cf4942a6758c8fb00`.

## Contents

- `exp1/`: participant-level label-permutation statistics for `B=100`, `500`,
  and `1000`; the final inference uses `B=1000`.
- `exp2/`: unrestricted versus slow-fast regional-PSD results by task and
  recording condition.
- `exp3/`: 100-solution exact-sex and nearest-age matched-cohort summaries for
  both prespecified PSD representations.
- `exp4/`: targeted relation-pattern exclusion and restricted-only summaries.
- `config/`: public design summaries and compact job grids.
- `validation/`: final server-side validation reports.
- `PROTOCOL.md`: design, inferential scope, and interpretation boundaries.
- `SHA256SUMS.txt`: checksums for this public evidence directory.

Validate the compact package without fitting models:

```bash
make validate-reviewer-round2
```

The full server archive additionally retains per-job logs, resumability state,
matching maps, raw bootstrap draws, manifests, and checksums.

