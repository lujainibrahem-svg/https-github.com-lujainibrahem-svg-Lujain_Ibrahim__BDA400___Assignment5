# Lujain Ibrahim — BDA400 Assignment 5
## Technical Analysis using R, Development Phase

### Project contents
- `R/01_sma.R` — Simple Moving Average (`sma`)
- `R/02_ema.R` — Exponential Moving Average (`ema`)
- `R/03_macd.R` — MACD (`macd`)
- `R/04_stdev.R` — Population standard deviation (`stdev`)
- `R/05_linreg.R` — Linear regression (`linreg`)
- `R/06_rsi.R` — Relative Strength Index (`rsi`)
- `R/07_stoch_rsi.R` — Stochastic RSI (`stoch_rsi`)
- `R/08_crossover.R` — Crossover (`crossover`)
- `R/09_crossunder.R` — Crossunder (`crossunder`)
- `tests/test_all.R` — Basic functional checks
- `Assignment5_Implementation_Notes.docx` — implementation explanation

### Requirements
R (base installation). No external R packages are required by the indicator implementations.

### Run the tests
Open the project folder as the working directory in RStudio, then run:

```r
source("tests/test_all.R")
```

Alternatively, from a terminal:

```bash
Rscript tests/test_all.R
```

### Run an individual indicator
Source the relevant script from the project root, then call its function. For example:

```r
source("R/01_sma.R")
prices <- c(10, 12, 15, 20, 18, 22, 25, 24, 21)
sma(prices, period = 3)
```

For MACD, source `R/02_ema.R` before `R/03_macd.R`. For StochRSI, source `R/01_sma.R`, `R/06_rsi.R`, and `R/07_stoch_rsi.R`. The test script sources all files in order.

### Implementation notes
- The EMA is initialized with the first observation, following the assignment pseudocode.
- `stdev()` uses the population formula shown in the assignment (division by n).
- `linreg()` uses the specified offset-based subset and returns predictions for that subset.
- StochRSI follows the provided pseudocode normalization using the minimum and maximum available RSI values, then applies SMA to form %K and %D.
- `crossover()` returns `Up`, `Down`, or `None`; `crossunder()` returns the `True` / `False` strings specified by its pseudocode.

### Before submission
1. Run `tests/test_all.R` in RStudio and confirm the success message.
2. Upload this project folder to the repository used for the course project.
3. Add the actual repository URL to the cover page.
4. Include the repository URL in the LMS submission as required by the assignment brief.
