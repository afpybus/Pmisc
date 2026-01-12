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
