# Frozen candidate-pair restriction output search

Status: **CANNOT VERIFY task × condition restriction results from auditable frozen outputs.**

No model fitting, replay, AUC calculation, permutation analysis, or other experiment was run. This was a filename-, schema-, and content-level read-only search.

## Sources searched

| Source | Files searched | Integrity identifier |
|---|---:|---|
| Integration bundle, including Gate 2C/WP1A/WP1B and repository snapshot | 273 archive entries | ZIP SHA-256 `21e17cbbbc82f3ad6c894994d242f8a7b57d53cffd05169baefd0ed5936b76a8` |
| Gate 2C final evidence | packaged archive | SHA-256 `1e53aebfc6c6be245ab2bd35ba41942def99d935870d7d4e83c507853228275b` |
| Recovered tier1--4 frozen export | 77 files | sorted file-hash tree digest `17483d8f9b1e5aefa77da2da709bb4f19b18c547e59529e7dd8758b781c28db2` |
| Full canonical exact-relation replay | 19 files | sorted file-hash tree digest `95c67cf42bf3089e9f26073cbe68ced8689c38f10d1e437e9297fe3bdb6ad4ba` |
| A--L final evidence segments | 162 extracted files | sorted file-hash tree digest `6fd19087d7c813a18ec5abfa771010447d3d82532df0122051b18584428b472f` |
| Manuscript-support CSV set | 20 files | sorted file-hash tree digest `8dd32eb0e0e1a827b52e67ed212a3de0611c13c66574cb1ff5e8f644f42fec80` |
| Public repository snapshot | full tracked tree | original commit `d6d317264e4502c0133aa3c4baf153cc53dcfb47` |

Search terms included filename and content variants of `restriction`, `restricted`, `candidate pair`, `slow-fast`, `slow_fast`, internal IDs `A0`--`A7`, `eligible pairs`, `retention`, task names, conditions, macro-F1 and MCC deltas. The selected-pair “candidate EEG slowing” files were inspected and are not restriction-performance outputs.

## What is available

Frozen aggregate summaries support:

- overall macro-F1 and MCC differences versus the unrestricted reference;
- overall candidate-space retention by representation/restriction;
- overall, non-mutually-exclusive restriction-category membership of unrestricted selected pairs.

## What is missing

No auditable frozen source table was found that simultaneously retains:

- task × condition × restriction performance;
- EC and EO/photo strata;
- macro-F1 delta and MCC delta;
- exact selected-pair category counts or reconstructible regional/band combinations;
- unambiguous lineage back to the frozen restriction fits.

## Consequence for the revision

The revised manuscript and supplement report only the auditable aggregate restriction result. Slow--fast is described as **most competitive and approximately performance-preserving**, not uniformly best or beneficial. The granular task- and condition-specific structural effects are explicitly marked `cannot verify` and are listed as a limitation. No fabricated breakdown is supplied.

