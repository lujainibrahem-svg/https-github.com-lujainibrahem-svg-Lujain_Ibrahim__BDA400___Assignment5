# Moving Average Convergence Divergence (MACD)
# Requires 02_ema.R to be sourced first, or source it from this file's folder.

if (!exists("ema", mode = "function")) {
  source(file.path("R", "02_ema.R"))
}

macd <- function(data, short_period, long_period, signal_period) {
  short_ema <- ema(data, short_period)
  long_ema <- ema(data, long_period)

  macd_line <- short_ema - long_ema
  signal_line <- ema(macd_line, signal_period)
  histogram <- macd_line - signal_line

  result <- list(
    macd_line = macd_line,
    signal_line = signal_line,
    histogram = histogram
  )

  return(result)
}
