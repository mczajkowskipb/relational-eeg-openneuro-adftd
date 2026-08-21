# Exact compactness read-only closure

Status: **PASS (read-only; no model fitting or replay performed).**

## Scope and lineage

The closure used frozen `fit$TSPs`-derived summaries already present in the accepted evidence. The key sources were:

- `compactness_frontier_checked.csv` — SHA-256 `e42bed05f6bf2340527e9cc83aaf4b43cd37d9cb92b0a983f7b35f977ddce444`;
- `compactness_model_size_summary_checked.csv` — SHA-256 `2bfa9b44b9988eddf066839e00d8af30fd690c86d444e50e70af3e616528759f`;
- `compactness_auditability_summary.csv` — SHA-256 `87a6df4f888f61f776b5529e478fdef007c0e7a0b3daa98d3a26ad77dbfc3eaa`;
- `compactness_auditability_summary_main_aggregate.csv` — SHA-256 `9404dd2cef02bd820ebc6a52da7e9707e55df794fcab20ee27cef2151e62a2a4`.

## Exact best-compact-envelope summaries

| Condition | Task | Mean selected relations | Mean feature mentions | Mean macro-F1 |
|---|---|---:|---:|---:|
| EC | AD vs CN | 4.000 | 8.000 | 0.7992 |
| EC | AD+FTD vs CN | 2.740 | 5.480 | 0.7698 |
| EC | FTD vs CN | 2.920 | 5.840 | 0.7759 |
| EO/photo | AD vs CN | 4.000 | 8.000 | 0.8154 |
| EO/photo | AD+FTD vs CN | 2.555 | 5.110 | 0.7738 |
| EO/photo | FTD vs CN | 3.000 | 6.000 | 0.8094 |

The unweighted means across these six descriptive, post-selection setting summaries are 3.2025 relations and 6.405 feature mentions. They are **not** properties of the prespecified main comparison and are not used in the revised Abstract. Figure 4 reports the exact setting-level values and labels the configurations as descriptive best-compact-envelope results.

The prespecified main disease-versus-control k-TSP records comprise 3,000 fitted models across 30 representation × task × condition settings, with mean selected K 6.3917 and 12.7833 feature mentions. These figures are kept separate from the descriptive best-compact envelope.

## Editorial decision

- The unsupported wording “about three selected pairs and six feature descriptors” was removed from the Abstract.
- The Abstract states only that K was selected from `{1,3,5,9}`, i.e. at most nine pairwise rules.
- Figure 4 and its associated tables use exact setting-level values and explicitly identify post-selection/descriptive status.

