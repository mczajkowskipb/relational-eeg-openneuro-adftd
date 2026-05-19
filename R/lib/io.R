parse_args <- function(defaults = list()) {
  args <- commandArgs(trailingOnly = TRUE)
  out <- defaults
  if (length(args) == 0) return(out)
  i <- 1
  while (i <= length(args)) {
    key <- args[[i]]
    if (startsWith(key, "--")) {
      name <- sub("^--", "", key)
      if (i == length(args) || startsWith(args[[i + 1]], "--")) {
        out[[name]] <- TRUE
        i <- i + 1
      } else {
        out[[name]] <- args[[i + 1]]
        i <- i + 2
      }
    } else {
      i <- i + 1
    }
  }
  out
}

read_csv_base <- function(path) {
  if (!file.exists(path)) stop("File not found: ", path)
  read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
}

write_csv_base <- function(x, path) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  write.csv(x, path, row.names = FALSE, na = "")
}

message_step <- function(...) {
  message("[rel-eeg] ", paste0(..., collapse = ""))
}
