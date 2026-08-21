# Result file standard

## metrics.csv

Core manuscript metric columns:

`dataset, condition, scenario, tier, task, feature_world, model, model_family, repeat_id, fold_id, macro_f1, mcc, balanced_accuracy, f1_pos, f1_neg, precision_pos, recall_pos, specificity, runtime, status`

Some legacy files retain a probability-score/AUC field for schema compatibility. It is not an authoritative manuscript endpoint and is not used in revised Methods, Results, tables, or figures. Reported macro-F1 is reconstructed from confusion counts with zero-division=0; the known erroneous legacy raw macro-F1 column is not used in manuscript tables.

## model_structure.csv for kTSP/TSP

Required columns:

`dataset, condition, scenario, tier, task, feature_world, model, repeat_id, fold_id, relation_rank, left_feature, right_feature, left_channel, right_channel, left_region, right_region, left_band, right_band, relation_text, score, k, disjoint, selected_frequency`

## Revision evidence

`results/revision/wp1a/gate3_wp1a_repeat_metrics.csv` contains the closed demographic-only baseline at repeat level. `results/revision/wp1b/gate3_wp1b_repeat_metrics.csv` contains original and adjusted macro-F1, balanced accuracy, MCC, both class-specific precision/recall/F1/support values, prediction disagreement, and correct-to-incorrect/incorrect-to-correct transitions. `gate3_wp1b_repeat_relation_summary.csv` contains exact selected K by fold, both Jaccard definitions, overlap coefficients, reversal fields, and vote-tie rates. Setting-level summary files aggregate repeats descriptively and contain no p-values.
