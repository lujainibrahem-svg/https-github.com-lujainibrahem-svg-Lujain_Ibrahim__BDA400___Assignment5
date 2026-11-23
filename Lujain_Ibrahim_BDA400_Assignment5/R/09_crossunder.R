# Crossunder
# Returns "True" at points where arr1 crosses below arr2, otherwise "False".

crossunder <- function(arr1, arr2) {
  if (length(arr1) != length(arr2)) {
    stop("Both arrays should have the same length")
  }
  if (!is.numeric(arr1) || !is.numeric(arr2) ||
      anyNA(arr1) || anyNA(arr2)) {
    stop("Both arrays must contain numeric values without NA")
  }

  crossunder_signals <- rep("False", length(arr1))

  if (length(arr1) >= 2) {
    for (i in 2:length(arr1)) {
      if (arr1[i] < arr2[i] && arr1[i - 1] >= arr2[i - 1]) {
        crossunder_signals[i] <- "True"
      }
    }
  }

  return(crossunder_signals)
}
