## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 7,
    fig.height = 5
)


## ----load---------------------------------------------------------------------
library(Pmisc)
library(dplyr)
library(ggplot2)


## ----basic_comparison---------------------------------------------------------
# Filter to two species for simplicity
iris_subset <- iris %>%
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


## ----volcano_plot-------------------------------------------------------------
# Create volcano plot
volcano_cm(
    comp_means_output = results,
    x = "mean_dif",
    max_overlaps = 20
) +
    ggtitle("Setosa vs Versicolor: Feature Differences")


## ----all_species--------------------------------------------------------------
# Use the full iris dataset
results_all <- comp_means(
    df = iris,
    feature_column_names = features,
    group_column_name = "Species",
    compare_means_method = "anova",
    p.adjust_method = "fdr"
)

# View results
results_all %>%
    select(feature, p, p.adj, p.adj.signif) %>%
    knitr::kable(digits = 10)


## ----wilcoxon-----------------------------------------------------------------
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


## ----boxplot, fig.height=4----------------------------------------------------
# Create boxplot for Petal.Length
DEF_boxplot(
    data = iris_subset,
    DE = results,
    feature = "Petal.Length",
    grouping = "Species"
) +
    ggtitle("Petal Length: Setosa vs Versicolor")


## ----adjustment_methods-------------------------------------------------------
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

