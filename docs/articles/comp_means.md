# Statistical Comparisons with comp_means

**[GitHub Repository](https://github.com/afpybus/Pmisc)**

## Introduction

The
[`comp_means()`](https://afpybus.github.io/Pmisc/reference/comp_means.md)
function in Pmisc provides a streamlined way to perform **pairwise
statistical comparisons** across multiple features **between two
groups**. It automatically handles:

- Statistical tests for two-group comparisons (t-test, Wilcoxon)
- P-value adjustment for multiple testing
- Calculation of fold changes and mean differences
- Sample size validation

**Important:** This function is designed for comparing exactly **two
groups**. For multi-group comparisons, filter your data to two groups at
a time.

It wraps the powerful **`ggpubr`** package functions to provide a more
opinionated, high-throughput workflow.

This vignette demonstrates the function using the classic `iris`
dataset, comparing two species at a time.

## Load Package

``` r
library(Pmisc)
library(dplyr)
#> Warning: package 'dplyr' was built under R version 4.5.2
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(ggplot2)
#> Warning: package 'ggplot2' was built under R version 4.5.2
library(tibble)
#> Warning: package 'tibble' was built under R version 4.5.2
```

## Basic Usage: Comparing Two Groups

Let’s compare petal and sepal measurements between two species: setosa
and versicolor.

``` r
# Filter to two species for simplicity
iris_subset <- iris %>%
    mutate(Species = as.character(Species)) %>% # Convert factor to character
    filter(Species %in% c("setosa", "versicolor"))

# Define features to compare
features <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")

# Compare means between species
results <- comp_means(
    df = iris_subset,
    feature_column_names = features,
    group_column_name = "Species",
    compare_means_method = "t.test",
    p.adjust_method = "fdr"
)

# View results
results %>%
    select(
        feature, group1, group2, mean.group1, mean.group2,
        mean_dif, p, p.adj, p.adj.signif
    ) %>%
    knitr::kable(digits = 3)
```

| feature | group1 | group2 | mean.group1 | mean.group2 | mean_dif | p | p.adj | p.adj.signif |
|:---|:---|:---|---:|---:|---:|---:|---:|:---|
| Sepal.Length | setosa | versicolor | 5.006 | 5.936 | -0.930 | 0 | 0 | \*\*\*\* |
| Sepal.Width | setosa | versicolor | 3.428 | 2.770 | 0.658 | 0 | 0 | \*\*\*\* |
| Petal.Length | setosa | versicolor | 1.462 | 4.260 | -2.798 | 0 | 0 | \*\*\*\* |
| Petal.Width | setosa | versicolor | 0.246 | 1.326 | -1.080 | 0 | 0 | \*\*\*\* |

## Understanding the Output

The
[`comp_means()`](https://afpybus.github.io/Pmisc/reference/comp_means.md)
function returns a data frame with:

- **feature**: The variable being compared
- **group1**, **group2**: The two groups being compared
- **mean.group1**, **mean.group2**: Mean values for each group
- **mean_dif**: Difference between means (group1 - group2)
- **log2fc**: Log2 fold change
- **p**: Raw p-value from statistical test
- **p.adj**: Adjusted p-value (FDR correction)
- **p.adj.signif**: Significance level notation (ns, *, **,*** ,
  \*\*\*\*)
- **sig_increased_in**: Which group has higher values (if significant)

## Volcano Plot Visualization

The companion function
[`volcano_cm()`](https://afpybus.github.io/Pmisc/reference/volcano_cm.md)
creates volcano plots to visualize the results:

``` r
# Define colors for significance
# "ns" is gray, significant groups get specific colors
sig_colors <- data.frame(
    breaks = c("setosa", "versicolor", "ns"),
    values = c("#FF9999", "#99CC99", "grey80"),
    stringsAsFactors = FALSE
)

# Create volcano plot with custom colors
volcano_cm(
    comp_means_output = results,
    x = "mean_dif",
    max_overlaps = 20
) +
    scm(sig_colors) + # Apply custom color scale
    ggtitle("Setosa vs Versicolor: Feature Differences")
#> Warning in geom_text(aes(x = max(x_var) - 0.07 * sum(range(abs(x_var))), : All aesthetics have length 1, but the data has 4 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](figures/comp_means-volcano_plot-1.png)

The plot shows:

- X-axis: Mean difference between groups
- Y-axis: -log10(adjusted p-value)
- Horizontal line: p = 0.05 significance threshold
- Colors: Which group has higher values
- Labels: Features that are significantly different

## Wilcoxon Test for Non-Parametric Data

For non-normal distributions, use the Wilcoxon rank-sum test:

``` r
# Compare using Wilcoxon test
results_wilcox <- comp_means(
    df = iris_subset,
    feature_column_names = features,
    group_column_name = "Species",
    compare_means_method = "wilcox.test",
    p.adjust_method = "bonferroni"
)

# Compare p-values from t-test vs Wilcoxon
comparison <- data.frame(
    feature = features,
    t_test_p = results$p.adj,
    wilcox_p = results_wilcox$p.adj
)

knitr::kable(comparison, digits = 5)
```

| feature      | t_test_p | wilcox_p |
|:-------------|---------:|---------:|
| Sepal.Length |        0 |        0 |
| Sepal.Width  |        0 |        0 |
| Petal.Length |        0 |        0 |
| Petal.Width  |        0 |        0 |

## Visualizing Individual Features

Use
[`DEF_boxplot()`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot.md)
to visualize specific features with p-value annotations:

``` r
# Create boxplot for Petal.Length
DEF_boxplot(
    data = iris_subset,
    DE = results,
    feature = "Petal.Length",
    grouping = "Species"
) +
    ggtitle("Petal Length: Setosa vs Versicolor")
```

![](figures/comp_means-boxplot-1.png)

## Customizing Colors with sfm()

Similar to [`scm()`](https://afpybus.github.io/Pmisc/reference/scm.md),
the [`sfm()`](https://afpybus.github.io/Pmisc/reference/sfm.md) (Scale
Fill Manual) helper allows you to easily apply custom fill colors using
the same tibble format.

``` r
# Define color scheme for the species (reusing similar colors)
my_colors <- data.frame(
    breaks = c("setosa", "versicolor", "virginica"),
    values = c("#FF9999", "#99CC99", "#9999CC"),
    stringsAsFactors = FALSE
)

# 2. Apply to DEF_boxplot using sfm()
DEF_boxplot(
    data = iris_subset,
    DE = results,
    feature = "Petal.Length",
    grouping = "Species"
) +
    sfm(my_colors) + # Apply custom fill colors
    ggtitle("Petal Length with Custom Colors")
```

![](figures/comp_means-custom_colors-1.png)

## P-Value Adjustment Methods

The function supports multiple adjustment methods:

``` r
# Compare different adjustment methods
adj_methods <- c("fdr", "bonferroni", "holm")

adjustment_comparison <- lapply(adj_methods, function(method) {
    res <- comp_means(
        df = iris_subset,
        feature_column_names = "Petal.Length",
        group_column_name = "Species",
        compare_means_method = "t.test",
        p.adjust_method = method
    )
    data.frame(
        method = method,
        raw_p = res$p,
        adj_p = res$p.adj
    )
}) %>% bind_rows()

knitr::kable(adjustment_comparison, digits = 10)
```

| method     | raw_p | adj_p |
|:-----------|------:|------:|
| fdr        |     0 |     0 |
| bonferroni |     0 |     0 |
| holm       |     0 |     0 |

**Note**: For a single comparison, all methods give the same result. The
differences appear when comparing multiple features simultaneously.

## Summary

The
[`comp_means()`](https://afpybus.github.io/Pmisc/reference/comp_means.md)
function provides:

1.  **Flexible testing**: Support for t-test, Wilcoxon, and ANOVA
2.  **Multiple testing correction**: FDR, Bonferroni, Holm, and others
3.  **Rich output**: Means, fold changes, p-values, and significance
    labels
4.  **Integration**: Works seamlessly with volcano plots and boxplots
5.  **Sample size checking**: Automatically removes features with
    insufficient data

This makes it ideal for exploratory analysis, differential expression
studies, and comparing measurements across experimental groups.

## Related Functions

- [`p.readjust()`](https://afpybus.github.io/Pmisc/reference/p.readjust.md):
  Re-adjust p-values from comp_means output
- [`volcano_cm()`](https://afpybus.github.io/Pmisc/reference/volcano_cm.md):
  Create volcano plots
- [`volcano_cm_labelall()`](https://afpybus.github.io/Pmisc/reference/volcano_cm_labelall.md):
  Volcano plot labeling all points
- [`DEF_boxplot()`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot.md):
  Boxplot with p-value annotations
- [`DEF_boxplot_sig()`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot_sig.md):
  Boxplot with significance stars
