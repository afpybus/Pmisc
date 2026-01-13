# Create all pairs from feature list

Generate data frame with all pairwise combinations

## Usage

``` r
make_pairs(feature_list)
```

## Arguments

- feature_list:

  Character vector of feature names

## Value

Tibble with feature1 and feature2 columns

## Examples

``` r
make_pairs(c("A", "B", "C"))
#> Error in tibble(feature1 = rep(feature_list, times = seq(length(feature_list),     1, -1)), feature2 = unlist(map(1:length(feature_list), function(x) {    feature_list[x:length(feature_list)]}))): could not find function "tibble"
# Returns tibble with all combinations: (A,A), (A,B), (A,C), (B,B), (B,C), (C,C)
```
