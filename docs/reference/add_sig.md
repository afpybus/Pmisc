# Convert p-values to significance notation

Translate numeric p-values into standard significance notation

## Usage

``` r
add_sig(x)
```

## Arguments

- x:

  Numeric vector of p-values

## Value

Character vector with significance levels: "ns", "\*", "\*\*", "\*\*\*",
"\*\*\*\*"

## Examples

``` r
add_sig(c(0.06, 0.03, 0.005, 0.0005, 0.00005))
#> Error in case_when(x >= 0.05 ~ "ns", x > 0.01 ~ "*", x > 0.001 ~ "**",     x > 1e-04 ~ "***", x <= 1e-04 ~ "****"): could not find function "case_when"
# Returns: c("ns", "*", "**", "***", "****")
```
