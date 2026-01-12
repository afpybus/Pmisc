# Pmisc

Personal R package containing utility functions for data analysis, visualization, statistics, survival analysis, and more.

## Installation

```r
# Install pacman if you don't have it
install.packages("pacman")

# Install and load Pmisc from GitHub
pacman::p_load_gh("afpybus/Pmisc")
```

## Usage

Load the package in any R script or project:

```r
pacman::p_load_gh("afpybus/Pmisc")

# Now all functions are available
# Examples:

# Get significance notation
add_sig(0.03)  # Returns "*"

# length(unique(x))
lu(c("a", "a", "b", "c", "c", "c"))  # Returns 3



```

## Vignettes

The package includes detailed vignettes demonstrating key functions using common training datasets:

- **[Statistical Comparisons with comp_means](vignettes/comp_means.Rmd)**: Learn how to compare means across groups, perform statistical tests, and create volcano plots using the iris dataset.

- **[Set Visualization with Upset Plots](vignettes/upset_plots.Rmd)**: Create publication-quality upset plots for visualizing set intersections and combinations using mtcars and iris datasets.

- **[Survival Analysis](vignettes/survival_analysis.Rmd)**: Perform Cox proportional hazards analysis, create Kaplan-Meier curves, and visualize survival results using the lung cancer dataset.

To browse all vignettes after installing the package:

```r
# Install with vignettes
devtools::install_github("afpybus/Pmisc", build_vignettes = TRUE)

# Browse vignettes
browseVignettes("Pmisc")

# Open a specific vignette
vignette("comp_means", package = "Pmisc")
vignette("upset_plots", package = "Pmisc")
vignette("survival_analysis", package = "Pmisc")
```

## Function Categories

- **Utility Functions**: `add_sig()`, `lu()`, `tibble_to_mat()`, `slope()`, `earliest()`, `latest()`
- **Figure Helpers**: `scm()`, `sfm()`, `geom_vb()`, `title_format()`, `bar.counts()`, `make_grid()`, `png_pdf()`, `ggplotColours()`
- **Data Manipulation**: `rm_from_array()`, `gsub_colnames()`, `get_upper_tri()`, `get_lower_tri()`, `reorder_cormat()`
- **Stat Functions**: `comp_means()`, `p.readjust()`, `volcano_cm()`, `corr_across()`, `remove_outliers()`, `DEF_boxplot()`
- **Spatial Analysis**: `make_pairs()`
- **Survival Analysis**: `coxph_all()`, `survival_volcano()`, `KM_categorical()`, `gene_OS_scatter()`
- **Heatmaps**: `cor_hm()`, `color.bar()`
- **Upset Plots**: `upset_plot()`, `upset_side()`
- **OPLS**: `rotate_opls()`

## Updating the Package

To update to the latest version from GitHub:

```r
pacman::p_load_gh("afpybus/Pmisc")
```

## Acknowledgments

This package wraps and extends functionality from several excellent R packages. Special credit to the core packages powering these utilities:

- **[ggpubr](https://rpkgs.datanovia.com/ggpubr/)**: Powers the statistical comparisons and visualization foundations.
- **[ggupset](https://github.com/const-ae/ggupset)**: The engine behind the upset plot visualizations.
- **[survival](https://cran.r-project.org/package=survival)**, **[tidycmprsk](https://github.com/MSKCC-Epi-Bio/tidycmprsk)**, & **[ggsurvfit](https://github.com/pharmaverse/ggsurvfit)**: Provide the robust statistical engines for survival analysis.
