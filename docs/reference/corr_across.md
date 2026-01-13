# Correlate features across a predictor variable

Calculate Pearson correlations between features and a predictor

## Usage

``` r
corr_across(feature.matrix, predictor.array)
```

## Arguments

- feature.matrix:

  Matrix of feature values

- predictor.array:

  Predictor variable array

## Value

Tibble with correlation statistics (R, p, p.adj)
