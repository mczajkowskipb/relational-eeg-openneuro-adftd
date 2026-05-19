source("R/lib/io.R")
source("R/lib/plotting_helpers.R")

args <- parse_args(list(input_dir = "results/paper_final", out = "paper_outputs/figures"))
dir.create(args$out, recursive = TRUE, showWarnings = FALSE)

# Optional diagnostic figures only. These are not intended to reproduce the
# final manuscript artwork 1:1. They provide quick visual checks for reviewers.

best_path <- file.path(args$input_dir, "tables", "main_best_ktsp_vs_classic_across_worlds.csv")
rel_path <- file.path(args$input_dir, "tables", "main_top_relation_stability.csv")

if (file.exists(best_path)) {
  best <- read_csv_base(best_path)
  label <- paste(best$tier, best$condition, best$task, sep = " | ")
  delta <- suppressWarnings(as.numeric(best$delta_macro_f1))
  ok <- !is.na(delta)
  if (sum(ok) > 0) {
    save_barplot(delta[ok], label[ok], "Frozen paper-final: kTSP minus best classic (macro-F1)",
                 file.path(args$out, "paper_final_delta_macro_f1.pdf"),
                 file.path(args$out, "paper_final_delta_macro_f1.svg"),
                 ylab = "delta macro-F1")
  }
}

if (file.exists(rel_path)) {
  rel <- read_csv_base(rel_path)
  if (all(c("feature", "n_jobs_selected") %in% names(rel))) {
    rel$n_jobs_selected <- suppressWarnings(as.numeric(rel$n_jobs_selected))
    rel <- rel[order(-rel$n_jobs_selected), ]
    rel <- head(rel, 20)
    save_barplot(rel$n_jobs_selected, rel$feature,
                 "Frozen paper-final: top stable kTSP relations",
                 file.path(args$out, "paper_final_top_relation_stability.pdf"),
                 file.path(args$out, "paper_final_top_relation_stability.svg"),
                 ylab = "selected jobs")
  }
}

message_step("wrote optional paper-final basic figures to ", args$out)
