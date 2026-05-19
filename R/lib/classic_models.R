predict_majority <- function(y_train, n_test) {
  tab <- sort(table(y_train), decreasing = TRUE)
  rep(names(tab)[[1]], n_test)
}

predict_simple_logistic <- function(train_x, y_train, test_x) {
  # Minimal base-R fallback for smoke usage only. Full glmnet/liblinear adapters are bound later.
  df <- data.frame(y = factor(y_train), train_x, check.names = FALSE)
  fit <- tryCatch(glm(y ~ ., data = df, family = binomial()), error = function(e) NULL, warning = function(w) invokeRestart("muffleWarning"))
  if (is.null(fit)) return(rep(names(sort(table(y_train), decreasing = TRUE))[[1]], nrow(test_x)))
  pr <- tryCatch(predict(fit, newdata = test_x, type = "response"), error = function(e) rep(NA_real_, nrow(test_x)))
  lev <- levels(df$y)
  # assume second level probability if available; map >0.5 to second level
  ifelse(pr >= 0.5, lev[[2]], lev[[1]])
}
