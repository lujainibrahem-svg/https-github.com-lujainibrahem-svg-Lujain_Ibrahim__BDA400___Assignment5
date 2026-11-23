# Stochastic RSI (StochRSI)
# Follows the supplied pseudocode: normalize RSI using its overall min/max,
# then calculate %K and %D with the SMA function.

if (!exists("rsi", mode = "function")) {
  source(file.path("R", "06_rsi.R"))
}
if (!exists("sma", mode = "function")) {
  source(file.path("R", "01_sma.R"))
}

stoch_rsi <- function(data, period, k_period, d_period) {
  rsi_values <- rsi(data, period)

  valid_rsi <- rsi_values[!is.na(rsi_values)]
  if (length(valid_rsi) == 0) {
    stop("Not enough RSI values to calculate StochRSI")
  }

  min_rsi <- min(valid_rsi)
  max_rsi <- max(valid_rsi)

  if (max_rsi == min_rsi) {
    k_values <- rep(NA_real_, length(rsi_values))
  } else {
    k_values <- (rsi_values - min_rsi) / (max_rsi - min_rsi)
  }

  k_line <- rep(NA_real_, max(0, length(k_values) - as.integer(k_period) + 1))
  if (length(k_values) >= k_period) {
    for (i in seq_len(length(k_values) - k_period + 1)) {
      window <- k_values[i:(i + k_period - 1)]
      if (all(!is.na(window))) {
        k_line[i] <- mean(window)
      }
    }
  }

  d_line <- rep(NA_real_, max(0, length(k_line) - as.integer(d_period) + 1))
  if (length(k_line) >= d_period) {
    for (i in seq_len(length(k_line) - d_period + 1)) {
      window <- k_line[i:(i + d_period - 1)]
      if (all(!is.na(window))) {
        d_line[i] <- mean(window)
      }
    }
  }

  result <- list(k_line = k_line, d_line = d_line)
  return(result)
}
