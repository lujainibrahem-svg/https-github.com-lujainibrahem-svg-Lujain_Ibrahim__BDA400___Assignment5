# Population Standard Deviation
# The assignment formula divides the sum of squared deviations by n.

stdev <- function(data) {
  if (!is.numeric(data) || length(data) == 0) {
    stop("data must be a non-empty numeric vector")
  }
  if (anyNA(data) || any(!is.finite(data))) {
    stop("data must contain finite numeric values")
  }

  mean_value <- sum(data) / length(data)
  diff_values <- data - mean_value
  squared_diff <- diff_values * diff_values
  variance <- sum(squared_diff) / length(squared_diff)
  standard_deviation <- sqrt(variance)

  return(standard_deviation)
}
