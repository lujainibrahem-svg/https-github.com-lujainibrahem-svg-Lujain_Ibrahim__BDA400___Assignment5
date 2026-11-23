# Relative Strength Index (RSI)
# Uses Wilder's smoothing method described in the assignment.

rsi <- function(data, period) {
  if (!is.numeric(data) || length(data) < 2) {
    stop("data must be a numeric vector containing at least two values")
  }
  if (anyNA(data) || any(!is.finite(data))) {
    stop("data must contain finite numeric values")
  }
  if (length(period) != 1 || is.na(period) || period < 1 ||
      period != as.integer(period)) {
    stop("period must be a positive integer")
  }
  period <- as.integer(period)

  if (length(data) <= period) {
    stop("Data length must be greater than period")
  }

  diff_values <- diff(data)
  gains <- ifelse(diff_values > 0, diff_values, 0)
  losses <- ifelse(diff_values < 0, abs(diff_values), 0)

  avg_gain <- mean(gains[seq_len(period)])
  avg_loss <- mean(losses[seq_len(period)])

  rsi_values <- rep(NA_real_, length(data))

  calculate_rsi <- function(gain, loss) {
    if (loss == 0 && gain == 0) return(50)
    if (loss == 0) return(100)
    rs <- gain / loss
    100 - (100 / (1 + rs))
  }

  rsi_values[period + 1] <- calculate_rsi(avg_gain, avg_loss)

  if (period + 2 <= length(data)) {
    for (i in (period + 2):length(data)) {
      change_index <- i - 1
      avg_gain <- (avg_gain * (period - 1) + gains[change_index]) / period
      avg_loss <- (avg_loss * (period - 1) + losses[change_index]) / period
      rsi_values[i] <- calculate_rsi(avg_gain, avg_loss)
    }
  }

  return(rsi_values)
}
