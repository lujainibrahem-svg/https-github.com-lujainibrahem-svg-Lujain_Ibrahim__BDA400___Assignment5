# Simple Linear Regression
# Follows the supplied regressionSource / regressionLength / regressionOffset pseudocode.

linreg <- function(regressionSource, regressionLength, regressionOffset) {
  if (!is.numeric(regressionSource) || length(regressionSource) == 0 ||
      anyNA(regressionSource) || any(!is.finite(regressionSource))) {
    stop("regressionSource must be a non-empty finite numeric vector")
  }
  if (length(regressionLength) != 1 || is.na(regressionLength) ||
      regressionLength < 2 || regressionLength != as.integer(regressionLength)) {
    stop("regressionLength must be an integer of at least 2")
  }
  if (length(regressionOffset) != 1 || is.na(regressionOffset) ||
      regressionOffset < 0 || regressionOffset != as.integer(regressionOffset)) {
    stop("regressionOffset must be a non-negative integer")
  }

  n <- length(regressionSource)
  regressionLength <- as.integer(regressionLength)
  regressionOffset <- as.integer(regressionOffset)

  if (regressionLength > n) {
    stop("regressionLength cannot be greater than the number of elements in regressionSource")
  }
  if (regressionOffset >= regressionLength) {
    stop("regressionOffset must be less than regressionLength")
  }

  start_index <- max(1, n - regressionLength + regressionOffset)
  end_index <- min(n, n - regressionOffset)
  source_subset <- regressionSource[start_index:end_index]

  index_values <- seq_along(source_subset)
  mean_index <- mean(index_values)
  mean_source <- mean(source_subset)

  numerator <- sum((index_values - mean_index) *
                     (source_subset - mean_source))
  denominator <- sum((index_values - mean_index)^2)

  if (denominator == 0) {
    stop("Regression requires at least two distinct index positions")
  }

  slope <- numerator / denominator
  intercept <- mean_source - slope * mean_index
  predicted_values <- slope * index_values + intercept

  result <- list(
    slope = slope,
    intercept = intercept,
    predicted_values = predicted_values
  )

  return(result)
}
