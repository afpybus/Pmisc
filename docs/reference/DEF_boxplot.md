# Boxplot for differentially expressed features

Create violin + boxplot with p-value annotation

## Usage

``` r
DEF_boxplot(data, DE, feature, grouping)
```

## Arguments

- data:

  Data frame

- DE:

  Output from comp_means

- feature:

  Feature name to plot

- grouping:

  Grouping variable name

## Value

ggplot object

## See also

[`DEF_boxplot_sig`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot_sig.md),
[`comp_means`](https://afpybus.github.io/Pmisc/reference/comp_means.md)

[`vignette("comp_means")`](https://afpybus.github.io/Pmisc/articles/comp_means.md)
