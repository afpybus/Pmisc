# Pmisc: Pybus Miscellaneous

[Documentation](https://afpybus.github.io/Pmisc/) \| [GitHub
Repository](https://github.com/afpybus/Pmisc)

A comprehensive collection of utility functions for bioinformatics and
data analysis. Key features include statistical comparisons, survival
analysis workflows, publication-ready visualizations (heatmaps, upset
plots), and general data manipulation tools.

## Installation

``` r
# Install pacman if you don't have it
install.packages("pacman")

# Install and load Pmisc from GitHub
pacman::p_load_gh("afpybus/Pmisc")
```

## Usage

Load the package in any R script or project:

``` r
pacman::p_load_gh("afpybus/Pmisc")

# Now all functions are available
# Examples:

# Get significance notation
add_sig(0.03)  # Returns "*"

# length(unique(x))
lu(c("a", "a", "b", "c", "c", "c"))  # Returns 3
```

## Vignettes

The package includes detailed vignettes demonstrating key functions
using common training datasets:

- **[Statistical Comparisons with
  comp_means](https://afpybus.github.io/Pmisc/articles/comp_means.html)**:
  Learn how to compare means across groups, perform statistical tests,
  and create volcano plots using the iris dataset.

- **[Set Visualization with Upset
  Plots](https://afpybus.github.io/Pmisc/articles/upset_plots.html)**:
  Create publication-quality upset plots for visualizing set
  intersections and combinations using mtcars and iris datasets.

- **[Survival
  Analysis](https://afpybus.github.io/Pmisc/articles/survival_analysis.html)**:
  Perform Cox proportional hazards analysis, create Kaplan-Meier curves,
  and visualize survival results using the lung cancer dataset.

To browse all vignettes after installing the package:

``` r
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

- **Utility Functions**:
  [`add_sig()`](https://afpybus.github.io/Pmisc/reference/add_sig.md),
  [`lu()`](https://afpybus.github.io/Pmisc/reference/lu.md),
  [`tibble_to_mat()`](https://afpybus.github.io/Pmisc/reference/tibble_to_mat.md),
  [`slope()`](https://afpybus.github.io/Pmisc/reference/slope.md),
  [`earliest()`](https://afpybus.github.io/Pmisc/reference/earliest.md),
  [`latest()`](https://afpybus.github.io/Pmisc/reference/latest.md)
- **Figure Helpers**:
  [`scm()`](https://afpybus.github.io/Pmisc/reference/scm.md),
  [`sfm()`](https://afpybus.github.io/Pmisc/reference/sfm.md),
  [`geom_vb()`](https://afpybus.github.io/Pmisc/reference/geom_vb.md),
  [`title_format()`](https://afpybus.github.io/Pmisc/reference/title_format.md),
  [`bar.counts()`](https://afpybus.github.io/Pmisc/reference/bar.counts.md),
  [`make_grid()`](https://afpybus.github.io/Pmisc/reference/make_grid.md),
  [`png_pdf()`](https://afpybus.github.io/Pmisc/reference/png_pdf.md),
  [`ggplotColours()`](https://afpybus.github.io/Pmisc/reference/ggplotColours.md)
- **Data Manipulation**:
  [`rm_from_array()`](https://afpybus.github.io/Pmisc/reference/rm_from_array.md),
  [`gsub_colnames()`](https://afpybus.github.io/Pmisc/reference/gsub_colnames.md),
  [`get_upper_tri()`](https://afpybus.github.io/Pmisc/reference/get_upper_tri.md),
  [`get_lower_tri()`](https://afpybus.github.io/Pmisc/reference/get_lower_tri.md),
  [`reorder_cormat()`](https://afpybus.github.io/Pmisc/reference/reorder_cormat.md)
- **Stat Functions**:
  [`comp_means()`](https://afpybus.github.io/Pmisc/reference/comp_means.md),
  [`p.readjust()`](https://afpybus.github.io/Pmisc/reference/p.readjust.md),
  [`volcano_cm()`](https://afpybus.github.io/Pmisc/reference/volcano_cm.md),
  [`corr_across()`](https://afpybus.github.io/Pmisc/reference/corr_across.md),
  [`remove_outliers()`](https://afpybus.github.io/Pmisc/reference/remove_outliers.md),
  [`DEF_boxplot()`](https://afpybus.github.io/Pmisc/reference/DEF_boxplot.md)
- **Spatial Analysis**:
  [`make_pairs()`](https://afpybus.github.io/Pmisc/reference/make_pairs.md)
- **Survival Analysis**:
  [`coxph_all()`](https://afpybus.github.io/Pmisc/reference/coxph_all.md),
  [`survival_volcano()`](https://afpybus.github.io/Pmisc/reference/survival_volcano.md),
  [`KM_categorical()`](https://afpybus.github.io/Pmisc/reference/KM_categorical.md),
  [`gene_OS_scatter()`](https://afpybus.github.io/Pmisc/reference/gene_OS_scatter.md)
- **Heatmaps**:
  [`cor_hm()`](https://afpybus.github.io/Pmisc/reference/cor_hm.md),
  [`color.bar()`](https://afpybus.github.io/Pmisc/reference/color.bar.md)
- **Upset Plots**:
  [`upset_plot()`](https://afpybus.github.io/Pmisc/reference/upset_plot.md),
  [`upset_side()`](https://afpybus.github.io/Pmisc/reference/upset_side.md)
- **OPLS**:
  [`rotate_opls()`](https://afpybus.github.io/Pmisc/reference/rotate_opls.md)

## Updating the Package

To update to the latest version from GitHub:

``` r
pacman::p_load_gh("afpybus/Pmisc")
```

## Acknowledgments

This package wraps and extends functionality from several excellent R
packages. Special credit to the core packages powering these utilities:

- **[ggpubr](https://rpkgs.datanovia.com/ggpubr/)**: Powers the
  statistical comparisons and visualization foundations.
- **[ggupset](https://github.com/const-ae/ggupset)**: The engine behind
  the upset plot visualizations.
- **[survival](https://cran.r-project.org/package=survival)**,
  **[tidycmprsk](https://github.com/MSKCC-Epi-Bio/tidycmprsk)**, &
  **[ggsurvfit](https://github.com/pharmaverse/ggsurvfit)**: Provide the
  robust statistical engines for survival analysis.
