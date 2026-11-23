# Crossover
# Returns Up when arr1 crosses above arr2, Down when it crosses below,
# and None when no crossover occurs.

crossover <- function(arr1, arr2) {
  if (length(arr1) != length(arr2)) {
    stop("Both arrays should have the same length")
  }
  if (!is.numeric(arr1) || !is.numeric(arr2) ||
      anyNA(arr1) || anyNA(arr2)) {
    stop("Both arrays must contain numeric values without NA")
  }

  crossover_signals <- rep("None", length(arr1))

  if (length(arr1) >= 2) {
    for (i in 2:length(arr1)) {
      if (arr1[i] > arr2[i] && arr1[i - 1] <= arr2[i - 1]) {
        crossover_signals[i] <- "Up"
      } else if (arr1[i] < arr2[i] && arr1[i - 1] >= arr2[i - 1]) {
        crossover_signals[i] <- "Down"
      }
    }
  }

  return(crossover_signals)
}
