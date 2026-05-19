source("R/lib/io.R")
source("R/lib/plotting_helpers.R")
args <- parse_args(list(input_dir = "results/example_outputs", out = "paper_outputs/figures"))
dir.create(args$out, recursive = TRUE, showWarnings = FALSE)
summary <- read_csv_base(file.path(args$input_dir, "summary_best_ktsp_vs_classic.csv"))
save_delta_heatmap(summary, file.path(args$out, "delta_heatmap.pdf"), file.path(args$out, "delta_heatmap.svg"))
rankings <- read_csv_base(file.path(args$input_dir, "classifier_rankings_selected_cases.csv"))
agg <- aggregate(rankings$macro_f1, by = list(model = rankings$model), FUN = mean)
save_barplot(agg$x, agg$model, "Average example macro-F1 by model", file.path(args$out, "classifier_ranking_example.pdf"), file.path(args$out, "classifier_ranking_example.svg"), ylab = "macro-F1")
rel <- read_csv_base(file.path(args$input_dir, "relation_stability_top.csv"))
save_barplot(rel$selected_frequency, rel$relation_text, "Example relation stability", file.path(args$out, "relation_stability_example.pdf"), file.path(args$out, "relation_stability_example.svg"), ylab = "selected frequency")
for (nm in c("channel_frequency", "band_frequency", "region_frequency")) {
  x <- read_csv_base(file.path(args$input_dir, paste0(nm, ".csv")))
  label_col <- setdiff(names(x), c("frequency", "is_example"))[[1]]
  save_barplot(x$frequency, x[[label_col]], paste("Example", nm), file.path(args$out, paste0(nm, ".pdf")), file.path(args$out, paste0(nm, ".svg")), ylab = "frequency")
}
message_step("wrote basic figures to ", args$out)
