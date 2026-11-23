# Simple Moving Average (SMA)
# Implements the assignment template using base R only.

sma <- function(data, period) {
  if (!is.numeric(data) || length(data) == 0) {
    stop("data must be a non-empty numeric vector")
  }
  if (anyNA(data) || any(!is.finite(data))) {
    stop("data must contain finite numeric values")
  }
  if (length(period) != 1 || is.na(period) || period < 1 ||
      period != as.integer(period)) {
    stop("period must be a positive integer")
  }
  period <- as.integer(period)

  if (length(data) < period) {
    stop("Data length should be greater than or equal to the period")
  }

  sma_values <- numeric(length(data) - period + 1)

  for (i in seq_len(length(data) - period + 1)) {
    current_window <- data[i:(i + period - 1)]
    sma_values[i] <- sum(current_window) / period
  }

  return(sma_values)
}
