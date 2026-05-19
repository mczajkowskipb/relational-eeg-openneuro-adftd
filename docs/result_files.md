# Result file standard

## metrics.csv

Required columns:

`dataset, condition, scenario, tier, task, feature_world, model, model_family, repeat_id, fold_id, macro_f1, mcc, balanced_accuracy, f1_pos, f1_neg, precision_pos, recall_pos, specificity, auc, runtime, status`

## model_structure.csv for kTSP/TSP

Required columns:

`dataset, condition, scenario, tier, task, feature_world, model, repeat_id, fold_id, relation_rank, left_feature, right_feature, left_channel, right_channel, left_region, right_region, left_band, right_band, relation_text, score, k, disjoint, selected_frequency`
