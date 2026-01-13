# Compare means between two groups with statistical testing

Perform pairwise statistical comparisons for multiple features between
TWO groups. For comparing more than two groups, filter your data to two
groups at a time.

## Usage

``` r
comp_means(
  df,
  feature_column_names,
  group_column_name = NA,
  compare_means_method = "t.test",
  p.adjust_method = "fdr"
)
```

## Arguments

- df:

  Data frame with feature columns and a grouping column

- feature_column_names:

  Character vector of column names to compare

- group_column_name:

  Column name for grouping variable (must have exactly 2 unique values)

- compare_means_method:

  Statistical test: "t.test" or "wilcox.test" (for two groups)

- p.adjust_method:

  P-value adjustment: "fdr", "bonferroni", "holm"

## Value

Data frame with p-values, fold changes, and group means

## See also

[`p.readjust`](https://afpybus.github.io/Pmisc/reference/p.readjust.md),
[`volcano_cm`](https://afpybus.github.io/Pmisc/reference/volcano_cm.md),
[`volcano_cm_labelall`](https://afpybus.github.io/Pmisc/reference/volcano_cm_labelall.md),
[`DEF_boxplot`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot.md)

[`vignette("comp_means")`](https://afpybus.github.io/Pmisc/articles/comp_means.md)
