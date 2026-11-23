# Exponential Moving Average (EMA)
# The first EMA value is initialized with the first observation, as in the supplied pseudocode.

ema <- function(data, period) {
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

  multiplier <- 2 / (period + 1)
  ema_values <- numeric(length(data))

  for (i in seq_along(data)) {
    if (i == 1) {
      ema_values[i] <- data[i]
    } else {
      ema_values[i] <- (data[i] - ema_values[i - 1]) *
        multiplier + ema_values[i - 1]
    }
  }

  return(ema_values)
}
