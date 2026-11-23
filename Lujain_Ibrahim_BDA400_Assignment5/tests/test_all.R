# Run this file from the project root with:
# Rscript tests/test_all.R

script_files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
for (script in script_files) {
  source(script)
}

# SMA: expected rolling averages are 12.3333, 15.6667, 17.6667, ...
x <- c(10, 12, 15, 20, 18, 22, 25, 24, 21)
sma_result <- sma(x, 3)
stopifnot(length(sma_result) == length(x) - 2)
stopifnot(isTRUE(all.equal(sma_result[1], 37 / 3)))

# EMA: first value follows the supplied initialization rule.
ema_result <- ema(x, 3)
stopifnot(length(ema_result) == length(x), ema_result[1] == x[1])

# MACD: all returned series align with the input data.
macd_result <- macd(x, 3, 5, 2)
stopifnot(length(macd_result$macd_line) == length(x))
stopifnot(length(macd_result$signal_line) == length(x))
stopifnot(length(macd_result$histogram) == length(x))

# Population standard deviation: population variance for c(2, 4, 6) is 8/3.
stopifnot(isTRUE(all.equal(stdev(c(2, 4, 6)), sqrt(8 / 3))))

# Linear regression: a perfectly linear series has slope 2 and intercept 1.
lr <- linreg(c(3, 5, 7, 9, 11), 5, 0)
stopifnot(isTRUE(all.equal(lr$slope, 2)))
stopifnot(isTRUE(all.equal(lr$intercept, 1)))

# RSI: values are within 0..100 once initialized.
rsi_result <- rsi(c(45, 50, 48, 55, 52, 49, 58, 60, 65, 62), 5)
valid_rsi <- rsi_result[!is.na(rsi_result)]
stopifnot(length(valid_rsi) > 0, all(valid_rsi >= 0 & valid_rsi <= 100))

# StochRSI: both lines are returned.
stoch_result <- stoch_rsi(c(45, 50, 48, 55, 52, 49, 58, 60, 65, 62,
                            64, 61, 67, 70, 68, 72, 69, 74, 71, 76), 5, 3, 3)
stopifnot(is.list(stoch_result), all(c("k_line", "d_line") %in% names(stoch_result)))

# Crossover and crossunder signal checks.
a <- c(1, 2, 4, 1, 0)
b <- c(2, 2, 3, 2, 1)
stopifnot(identical(crossover(a, b), c("None", "None", "Up", "Down", "None")))
stopifnot(identical(crossunder(a, b), c("False", "False", "False", "True", "False")))

cat("All Assignment 5 checks passed.\\n")
