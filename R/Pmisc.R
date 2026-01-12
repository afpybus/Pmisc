# UTILITY FUNCTIONS ################

#' Convert p-values to significance notation
#'
#' Translate numeric p-values into standard significance notation
#'
#' @param x Numeric vector of p-values
#' @return Character vector with significance levels: "ns", "*", "**", "***", "****"
#' @export
#' @examples
#' add_sig(c(0.06, 0.03, 0.005, 0.0005, 0.00005))
#' # Returns: c("ns", "*", "**", "***", "****")
add_sig <- function(x) {
  case_when(
    x >= 0.05 ~ "ns",
    x > 0.01 ~ "*",
    x > 0.001 ~ "**",
    x > 0.0001 ~ "***",
    x <= 0.0001 ~ "****"
  )
}

#' Length of unique values
#'
#' Calculate the number of unique values in a vector
#'
#' @param x A vector
#' @param na.rm Logical, whether to remove NA values before counting (default: FALSE)
#' @return Integer count of unique values
#' @export
#' @examples
#' lu(c(1, 1, 2, 3, 3, 3))
#' lu(c("a", NA, "b", "c"), na.rm = TRUE) # Returns 3
lu <- function(x, na.rm = FALSE) {
  if (na.rm) {
    length(na.exclude(unique(x)))
  } else {
    length(unique(x))
  }
}

#' Convert tibble to matrix with row names
#'
#' @param df A tibble or data frame
#' @param col.rownames Column name to use for row names
#' @return Matrix with specified column as row names
#' @export
tibble_to_mat <- function(df, col.rownames) {
  mat <- df %>%
    select(-col.rownames) %>%
    as.matrix()
  rownames(mat) <- df[, col.rownames] %>% unlist()
  return(mat)
}

#' Convert named numeric vector to data frame
#'
#' @param named_numeric A named numeric vector
#' @return Tibble with names and values columns
#' @export
named_num_to_df <- function(named_numeric) {
  out <- tibble(
    names = names(named_numeric),
    values = named_numeric
  )
  return(out)
}

#' Select column as array
#'
#' @param df Data frame
#' @param col Column name to select
#' @return Vector of values from specified column
#' @export
select_as_array <- function(df, col) {
  colnames(df)[colnames(df) == col] <- "placeholder"
  df$placeholder
}

#' Calculate slope of linear model
#'
#' Calculate average slope of y ~ x using linear regression
#'
#' @param x Numeric vector (predictor)
#' @param y Numeric vector (response)
#' @return Numeric slope coefficient
#' @export
slope <- function(x, y) {
  as.numeric(lm(y ~ x)$coefficients[2])
}

#' Get earliest values from time series
#'
#' @param dates Vector of dates
#' @param values Corresponding values
#' @return Mean of values at earliest date
#' @export
#' @examples
#' earliest(c(1, 2, 2, 3), c(10, 20, 30, 40)) # Returns 10
earliest <- function(dates, values) {
  mean(values[dates == min(dates)])
}

#' Get latest values from time series
#'
#' @param dates Vector of dates
#' @param values Corresponding values
#' @return Mean of values at latest date
#' @export
#' @examples
#' latest(c(1, 2, 2, 3), c(10, 20, 30, 40)) # Returns 40
latest <- function(dates, values) {
  mean(values[dates == max(dates)])
}


# FIGURE HELPERS #################

#' Scale color manual for formatted color tibbles
#'
#' @param color.df Tibble with 'values' and 'breaks' columns
#' @return ggplot2 scale_color_manual layer
#' @export
scm <- function(color.df) {
  scale_color_manual(values = color.df$values, breaks = color.df$breaks)
}

#' Scale fill manual for formatted color tibbles
#'
#' @param color.df Tibble with 'values' and 'breaks' columns
#' @return ggplot2 scale_fill_manual layer
#' @export
sfm <- function(color.df) {
  scale_fill_manual(values = color.df$values, breaks = color.df$breaks)
}

#' Combine violin and box plots
#'
#' @param box.width Width of boxplot (default: 0.2)
#' @param box.fill Fill color for boxplot (default: "gray")
#' @return List of ggplot2 geom layers
#' @export
geom_vb <- function(box.width = 0.2, box.fill = "gray") {
  list(geom_violin(), geom_boxplot(width = box.width, fill = box.fill))
}

#' Format plot titles for publication
#'
#' @param face Font face (default: "bold")
#' @param hjust Horizontal justification (default: 0.5)
#' @param size Font size (default: 11)
#' @return ggplot2 theme layer
#' @export
title_format <- function(face = "bold", hjust = 0.5, size = 11) {
  theme(plot.title = element_text(face = face, hjust = hjust, size = size))
}

#' Create color legend from formatted tibble
#'
#' @param color.df Tibble with 'values' and 'breaks' columns
#' @return Base R barplot showing color legend
#' @export
color.legend <- function(color.df) {
  barplot(rep(1, nrow(color.df)), col = color.df$values, names.arg = color.df$breaks, las = 2, horiz = TRUE)
}

#' Create horizontal bar chart with count labels
#'
#' @param df Data frame
#' @param x Variable name for x-axis
#' @param fill Variable name for fill (default: same as x)
#' @param count.display Label position: "mid" or "top"
#' @return ggplot object
#' @export
bar.counts <- function(df, x, fill = x, count.display = "mid") {
  df$x.var <- df[, colnames(df) == x]
  df$fill.var <- df[, colnames(df) == fill]
  p <- ggplot(df, aes(x = fct_rev(fct_infreq(x.var)), fill = fill.var)) +
    geom_bar() +
    coord_flip() +
    theme_bw() +
    scale_y_continuous(expand = expansion(mult = c(0, 0.09))) +
    ggtitle(paste0(x, " w/ ", fill)) +
    xlab(x) +
    labs(fill = fill) +
    ggeasy::easy_center_title() +
    ggeasy::easy_legend_at("bottom")
  if (count.display == "mid") {
    return(p + geom_text(aes(label = after_stat(count)), stat = "count", hjust = 0.5, position = position_stack(vjust = 0.5)))
  }
  if (count.display == "top") {
    return(p + geom_text(aes(label = after_stat(count)), stat = "count", hjust = 0))
  }
}

#' Arrange multiple ggplot objects in a grid
#'
#' @param ggplots_list List of ggplot objects
#' @param nrow Number of rows (default: auto-calculated)
#' @param ncol Number of columns (default: auto-calculated)
#' @return Arranged plot grid
#' @export
make_grid <- function(ggplots_list,
                      nrow = floor(sqrt(length(ggplots_list))),
                      ncol = ceiling(length(ggplots_list) / nrow)) {
  plot.list <- append(list(nrow = nrow, ncol = ncol), ggplots_list)
  p <- do.call(ggpubr::ggarrange, arg = plot.list)
  return(p)
}

#' Get default ggplot2 colors
#'
#' @param n Number of colors (default: 6)
#' @param h Hue range (default: c(0, 360) + 15)
#' @return Character vector of hex colors
#' @export
#' @examples
#' ggplotColours(3) # Returns 3 hex color codes
#' # Example output: c("#F8766D", "#00BA38", "#619CFF")
ggplotColours <- function(n = 6, h = c(0, 360) + 15) {
  if ((diff(h) %% 360) < 1) h[2] <- h[2] - 360 / n
  hcl(h = (seq(h[1], h[2], length = n)), c = 100, l = 65)
}

#' Save plot as PNG and PDF
#'
#' @param p ggplot object
#' @param filename Filename without extension
#' @param width Width in inches
#' @param height Height in inches
#' @param res Resolution for PNG (default: 1000)
#' @return List (side effect: saves files)
#' @export
png_pdf <- function(p, filename, width, height, res = 1000) {
  list(
    png(paste0(filename, ".png"), width, height, units = "in", res = res),
    print(p),
    dev.off(),
    cairo_pdf(paste0(filename, ".pdf"), width, height),
    print(p),
    dev.off()
  )
}

# DATA MANIPULATION #################

#' Remove specified values from array
#'
#' Tidy-compatible removal for use in piping operations
#'
#' @param array Input vector
#' @param values_to_remove Values to exclude
#' @return Filtered vector
#' @export
#' @examples
#' rm_from_array(1:5, c(2, 4)) # Returns c(1, 3, 5)
rm_from_array <- function(array, values_to_remove) {
  array[!array %in% values_to_remove]
}

#' Substitute pattern in column names
#'
#' Tidy-compatible column name substitution
#'
#' @param df Data frame
#' @param pattern Pattern to replace
#' @param replacement Replacement string (default: "")
#' @return Data frame with modified column names
#' @export
gsub_colnames <- function(df, pattern, replacement = "") {
  new_colnames <- gsub(pattern, replacement, colnames(df))
  colnames(df) <- new_colnames
  return(df)
}

#' Get upper triangle of matrix
#'
#' Extract upper triangle, useful for correlation heatmaps
#'
#' @param mat Matrix
#' @return Matrix with lower triangle set to NA
#' @export
#' @examples
#' m <- matrix(1:9, 3, 3)
#' get_upper_tri(m) # Returns matrix with lower triangle as NA
get_upper_tri <- function(mat) {
  mat[lower.tri(mat)] <- NA
  return(mat)
}

#' Get lower triangle of matrix
#'
#' Extract lower triangle, useful for correlation heatmaps
#'
#' @param mat Matrix
#' @return Matrix with upper triangle set to NA
#' @export
#' @examples
#' m <- matrix(1:9, 3, 3)
#' get_lower_tri(m) # Returns matrix with upper triangle as NA
get_lower_tri <- function(mat) {
  mat[upper.tri(mat)] <- NA
  return(mat)
}

#' Reorder correlation matrix by hierarchical clustering
#'
#' From STHDA, reorders correlation matrix for better visualization
#'
#' @param cormat Correlation matrix
#' @return Reordered correlation matrix
#' @export
reorder_cormat <- function(cormat) {
  # Use correlation between variables as distance
  dd <- as.dist((1 - cormat) / 2)
  hc <- hclust(dd)
  cormat <- cormat[hc$order, hc$order]
}


# STAT FUNCTIONS #########################

#' Compare means across groups with statistical testing
#'
#' Perform statistical comparisons between groups for multiple features
#'
#' @param df Data frame with feature columns and a grouping column
#' @param feature_column_names Character vector of column names to compare
#' @param group_column_name Column name for grouping variable
#' @param compare_means_method Statistical test: "t.test", "anova", "wilcox.test"
#' @param p.adjust_method P-value adjustment: "fdr", "bonferroni", "holm"
#' @return Data frame with p-values, fold changes, and group means
#' @export
comp_means <- function(df, feature_column_names, group_column_name = NA, compare_means_method = "t.test", p.adjust_method = "fdr") {
  if (!is.na(group_column_name)) {
    index_group <- which(colnames(df) == group_column_name) # find column index number of group variable
    colnames(df)[index_group] <- "group_to_compare" # rename the group variable to a standard name to be used in compare_means
    # only use feature columns with a sample size of at least 3 in each group
    sample_sizes <- df %>%
      group_by(group_to_compare) %>%
      summarise_at(all_of(feature_column_names), ~ sum(!is.na(.x)))
    ind_sufficient <- which(colSums(sample_sizes[, -1] >= 3) == 2)
  }
  DE <- lapply(feature_column_names[ind_sufficient], FUN = function(featurename) {
    index_feature <- which(colnames(df) == featurename) # find column index number of feature in iteration
    df_iter <- df # create a copy of the df for this iteration, resets with each iteration (to undo feature name change)
    colnames(df_iter)[index_feature] <- "feature_to_compare" # rename the indexed feature to a standard name to be used in compare_means
    if (!is.na(group_column_name)) {
      stat_result <- ggpubr::compare_means(data = df_iter, formula = feature_to_compare ~ group_to_compare, method = compare_means_method)
      stat_result$mean.group1 <- mean(df_iter$feature_to_compare[df_iter$group_to_compare == stat_result$group1], na.rm = TRUE) # mean of group 1
      stat_result$mean.group2 <- mean(df_iter$feature_to_compare[df_iter$group_to_compare == stat_result$group2], na.rm = TRUE) # mean of group 2
      stat_result$n.group1 <- sum(!is.na(df_iter$feature_to_compare[df_iter$group_to_compare == stat_result$group1])) # sample size of group 1
      stat_result$n.group2 <- sum(!is.na(df_iter$feature_to_compare[df_iter$group_to_compare == stat_result$group2])) # sample size of group 2
    } else {
      stat_result <- ggpubr::compare_means(data = df_iter, formula = feature_to_compare ~ 0, method = compare_means_method) %>%
        mutate(group1 = "STEP Cohort")
      stat_result$mean.group1 <- mean(df_iter$feature_to_compare, na.rm = TRUE)
      stat_result$mean.group2 <- 0
      stat_result$n.group1 <- sum(!is.na(df_iter$feature_to_compare))
      stat_result$n.group2 <- NA
    }

    # calculate stat results with compare_means
    stat_result$y.position <- max(df_iter$feature_to_compare, na.rm = TRUE) + 0.07 * {
      max(df_iter$feature_to_compare, na.rm = TRUE) - min(df_iter$feature_to_compare, na.rm = TRUE)
    }
    stat_result$.y. <- featurename # set results data frame .y. field ("feature_to_compare") to actual feature name

    return(stat_result) # return data frame row with results of stat test
  }) %>% bind_rows() # lapply returns a list of data frame rows, bind_rows() combines to one data frame
  DE$log10p <- -log10(DE$p)
  DE$p.adj <- p.adjust(DE$p, method = p.adjust_method) # calculate p.adj, adjusting for all comparisons
  # create p.adj.signif column for graphical p-val range display
  DE$p.adj.signif <- case_when(
    DE$p.adj > 0.05 ~ "ns",
    DE$p.adj <= 0.0001 ~ "****",
    DE$p.adj <= 0.001 ~ "***",
    DE$p.adj <= 0.01 ~ "**",
    DE$p.adj <= 0.05 ~ "*"
  )
  DE$p.adj.format <- format.pval(DE$p.adj, digits = 1, eps = 1e-100) # create p.adj.format column for graphical formatted p-val display
  DE$log10p.adj <- -log10(DE$p.adj)
  DE$fc <- DE$mean.group1 / DE$mean.group2
  DE$log2fc <- log2(DE$fc)
  DE$mean_dif <- DE$mean.group1 - DE$mean.group2
  DE <- mutate(DE, increased_in = case_when(mean_dif >= 0 ~ group1, mean_dif < 0 ~ group2)) %>%
    rename(feature = .y.) %>%
    mutate(sig_increased_in = case_when(p.adj.signif == "ns" ~ "ns", TRUE ~ increased_in)) %>%
    mutate(sig_increased_in = factor(sig_increased_in, levels = c(unique(as.character(group1)), unique(as.character(group2)), "ns"))) %>%
    mutate(grouping = group_column_name)
  return(DE)
}


#' Readjust p-values from comp_means output
#'
#' @param cm_out Output from comp_means
#' @param p.adjust_method Adjustment method (default: "fdr")
#' @return Data frame with updated p.adj columns
#' @export
p.readjust <- function(cm_out, p.adjust_method = "fdr") {
  cm_out <- cm_out %>%
    mutate(
      p.adj = p.adjust(p, method = p.adjust_method),
      p.adj.signif = add_sig(p.adj),
      p.adj.format = format.pval(p.adj, digits = 1, eps = 1e-100),
      log10p.adj = -log10(p.adj)
    )
}

#' Create volcano plot from comp_means results
#'
#' @param comp_means_output Output from comp_means function
#' @param x X-axis variable: "mean_dif" or "log2fc"
#' @param max_overlaps Maximum label overlaps for ggrepel
#' @return ggplot object
#' @export
volcano_cm <- function(comp_means_output, x = "mean_dif", max_overlaps = 10) {
  colnames(comp_means_output)[colnames(comp_means_output) == x] <- "x_var"
  ggplot(comp_means_output, aes(x = x_var, y = log10p.adj, color = sig_increased_in, label = feature)) +
    geom_hline(yintercept = -log10(0.05), lty = 2, color = "darkgray") +
    geom_text(aes(
      x = max(x_var) - 0.07 * sum(range(abs(x_var))),
      y = -log10(0.05) + 0.03 * sum(range(abs(log10p.adj))), label = "p=0.05"
    ), color = "darkgray") +
    geom_point(size = 2) +
    geom_point(size = 2, shape = 1, color = "black") +
    ggrepel::geom_text_repel(
      data = filter(comp_means_output, sig_increased_in != "ns"),
      mapping = aes(x = x_var, y = log10p.adj, label = feature),
      color = "black",
      max.overlaps = max_overlaps
    ) +
    theme_bw() +
    ylab("-log10p.adj") +
    xlab(x) +
    ggeasy::easy_legend_at("bottom") +
    ggeasy::easy_center_title()
}

#' Volcano plot with labels for all features
#'
#' Variant of volcano_cm that labels all points regardless of significance
#'
#' @param comp_means_output Output from comp_means
#' @param x X-axis variable
#' @param max_overlaps Maximum label overlaps
#' @return ggplot object
#' @export
volcano_cm_labelall <- function(comp_means_output, x = "mean_dif", max_overlaps = 10) {
  colnames(comp_means_output)[colnames(comp_means_output) == x] <- "x_var"
  ggplot(comp_means_output, aes(x = x_var, y = log10p.adj, color = sig_increased_in, label = feature)) +
    geom_hline(yintercept = -log10(0.05), lty = 2, color = "darkgray") +
    geom_text(aes(
      x = max(x_var) - 0.07 * sum(range(abs(x_var))),
      y = -log10(0.05) + 0.03 * sum(range(abs(log10p.adj))), label = "p=0.05"
    ), color = "darkgray") +
    geom_point(size = 2) +
    geom_point(size = 2, shape = 1, color = "black") +
    ggrepel::geom_text_repel(color = "black", max.overlaps = max_overlaps) +
    theme_bw() +
    ggeasy::easy_legend_at("bottom") +
    ggeasy::easy_center_title()
}


#' Boxplot for differentially expressed features
#'
#' Create violin + boxplot with p-value annotation
#'
#' @param data Data frame
#' @param DE Output from comp_means
#' @param feature Feature name to plot
#' @param grouping Grouping variable name
#' @return ggplot object
#' @export
DEF_boxplot <- function(data, DE, feature, grouping) {
  colnames(data)[which(colnames(data) == feature)] <- "feature"
  colnames(data)[which(colnames(data) == grouping)] <- "grouping"
  DE <- DE[which(DE$feature == feature), ]
  ggplot(data, aes(x = grouping, y = feature, fill = grouping)) +
    geom_violin() +
    geom_boxplot(width = 0.1, fill = "gray") +
    xlab(grouping) +
    ylab(feature) +
    theme_bw() +
    theme(legend.position = "none") +
    ggpubr::stat_pvalue_manual(data = DE, label = "p = {p.adj.format}", vjust = -0.3) +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)))
}

#' Boxplot with significance stars
#'
#' Variant of DEF_boxplot showing significance stars instead of p-values
#'
#' @param data Data frame
#' @param DE Output from comp_means
#' @param feature Feature name
#' @param grouping Grouping variable
#' @return ggplot object
#' @export
DEF_boxplot_sig <- function(data, DE, feature, grouping) {
  colnames(data)[which(colnames(data) == feature)] <- "feature"
  colnames(data)[which(colnames(data) == grouping)] <- "grouping"
  DE <- DE[which(DE$feature == feature), ]
  ggplot(data, aes(x = grouping, y = feature, fill = grouping)) +
    geom_violin() +
    geom_boxplot(width = 0.1, fill = "gray") +
    xlab(grouping) +
    ylab(feature) +
    theme_bw() +
    theme(legend.position = "none") +
    ggpubr::stat_pvalue_manual(data = DE, label = "{p.adj.signif}", vjust = -0.3) +
    scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)))
}

#' Correlate features across a predictor variable
#'
#' Calculate Pearson correlations between features and a predictor
#'
#' @param feature.matrix Matrix of feature values
#' @param predictor.array Predictor variable array
#' @return Tibble with correlation statistics (R, p, p.adj)
#' @export
corr_across <- function(feature.matrix, predictor.array) {
  rcorr_out <- Hmisc::rcorr(cbind(predictor.array, feature.matrix))
  tibble(
    feature = colnames(rcorr_out$P)[2:ncol(rcorr_out$P)],
    p = rcorr_out$P[1, 2:ncol(rcorr_out$P)],
    p.adj = p.adjust(p, method = "fdr"),
    p.signif = add_sig(p.adj),
    R = rcorr_out$r[1, 2:ncol(rcorr_out$r)],
    RSQ = R^2,
    n = rcorr_out$n[1, 2:ncol(rcorr_out$r)]
  )
}


#' Remove outliers based on IQR
#'
#' Remove points outside of coef*IQR from Q1/Q3
#'
#' @param df Data frame
#' @param var Variable name to check for outliers
#' @param coef Coefficient multiplier for IQR (default: 3)
#' @return Data frame with outliers removed
#' @export
remove_outliers <- function(df, var, coef = 3) {
  colnames(df)[colnames(df) == var] <- "TEMP"
  values <- df$TEMP
  q <- quantile(values) %>% unname()
  iqr <- q[4] - q[2]
  lower_limit <- q[2] - coef * iqr
  upper_limit <- q[4] + coef * iqr
  df <- filter(df, TEMP >= lower_limit, TEMP <= upper_limit)
  colnames(df)[colnames(df) == "TEMP"] <- var
  return(df)
}

# SPATIAL #######################

#' Create all pairs from feature list
#'
#' Generate data frame with all pairwise combinations
#'
#' @param feature_list Character vector of feature names
#' @return Tibble with feature1 and feature2 columns
#' @export
#' @examples
#' make_pairs(c("A", "B", "C"))
#' # Returns tibble with all combinations: (A,A), (A,B), (A,C), (B,B), (B,C), (C,C)
make_pairs <- function(feature_list) {
  tibble(
    feature1 = rep(feature_list, times = seq(length(feature_list), 1, -1)),
    feature2 = unlist(map(1:length(feature_list), function(x) {
      feature_list[x:length(feature_list)]
    }))
  )
}


# SURVIVAL ANALYSIS ####################

#' Run Cox proportional hazards model for multiple features
#'
#' @param df Data frame with time, status, and feature columns
#' @param feature.names Character vector of feature column names
#' @param time_col Name of time column (default: "time")
#' @param status_col Name of status column (default: "status")
#' @return Data frame with hazard ratios and p-values
#' @export
coxph_all <- function(df, feature.names, time_col = "time", status_col = "status") {
  colnames(df)[colnames(df) == time_col] <- "time_coxph"
  colnames(df)[colnames(df) == status_col] <- "status_coxph"
  df <- filter(df, !is.na(time_coxph), !is.na(status_coxph))
  ind_remove_5 <- which(colSums(!is.na(df[, feature.names])) < 5)
  ind_remove_fct <- which(sapply(df[, feature.names], function(x) length(na.exclude(unique(x)))) < 2)
  if (length(ind_remove_5) > 0 | length(ind_remove_fct) > 0) {
    ind_remove <- c(ind_remove_5, ind_remove_fct) %>% unique()
    if (length(ind_remove_5) > 0) {
      print(paste0(
        "Removing ", str_flatten_comma(feature.names[ind_remove_5]),
        " for having fewer than 5 measurements"
      ))
    }
    if (length(ind_remove_fct) > 0) {
      print(paste0(
        "Removing ", str_flatten_comma(feature.names[ind_remove_fct]),
        " for having only 1 unique value"
      ))
    }
    feature.names <- feature.names[-ind_remove]
  }
  out <- lapply(1:length(feature.names), function(i) {
    df_itr <- df
    colnames(df_itr)[colnames(df_itr) == feature.names[i]] <- "feature"
    tibble(
      feature = feature.names[i],
      wald_p = summary(survival::coxph(tidycmprsk::Surv(time_coxph, status_coxph) ~ feature, data = df_itr))$waldtest[3],
      hazard_ratio = summary(survival::coxph(tidycmprsk::Surv(time_coxph, status_coxph) ~ feature, data = df_itr))$coefficients[2]
    )
  }) %>% bind_rows()
  out$p.adj <- p.adjust(out$wald_p, method = "fdr")
  out$p.signif <- add_sig(out$p.adj)
  out$n <- colSums(!is.na(df[, feature.names]))
  out$result <- case_when(
    out$p.signif != "ns" & out$hazard_ratio > 1 ~ "Increased Hazard",
    out$p.signif != "ns" & out$hazard_ratio < 1 ~ "Decreased Hazard",
    TRUE ~ "ns"
  )
  return(out)
}

#' Volcano plot for survival analysis results
#'
#' @param coxph_all_out Output from coxph_all function
#' @return ggplot object
#' @export
survival_volcano <- function(coxph_all_out) {
  ggplot(coxph_all_out, aes(x = hazard_ratio, y = -log10(p.adj), label = feature, color = result)) +
    geom_point() +
    ggrepel::geom_text_repel() +
    theme_minimal() +
    geom_hline(yintercept = -log10(0.05), lty = 2, color = "darkgray") +
    geom_vline(xintercept = 1, lty = 2, color = "darkgray") +
    ggeasy::easy_legend_at("bottom") +
    ggeasy::easy_center_title()
}


#' Kaplan-Meier plot by gene expression
#'
#' @param df Data frame with time, status, and gene columns
#' @param gene Gene/feature name
#' @param time_scale Label for time axis
#' @param reclass Whether to split by median (default: TRUE)
#' @return ggsurvfit object
#' @export
KM_categorical <- function(df, gene, time_scale, reclass = TRUE) {
  if (reclass == TRUE) {
    df <- mutate(df, across(all_of(gene), ~ case_when(
      .x <= median(.x, na.rm = TRUE) ~ "low",
      .x > median(.x, na.rm = TRUE) ~ "high",
      TRUE ~ NA
    ), .names = "{.col}_cat"))
  }
  gene_index <- which(str_detect(colnames(df), paste0(gene, "_cat")))
  colnames(df)[gene_index] <- "gene_cat"
  ggsurvfit::survfit2(tidycmprsk::Surv(time, status) ~ gene_cat, data = df) %>%
    ggsurvfit::ggsurvfit() +
    labs(x = time_scale, y = "Survival Probability") +
    ggsurvfit::add_confidence_interval() +
    ggsurvfit::add_risktable() +
    ggtitle(paste0("Kaplan-Meier Survival by ", gene)) +
    ggeasy::easy_center_title()
}

#' Gene expression vs overall survival scatter plot
#'
#' @param df Data frame with time, status, and gene columns
#' @param gene Gene/feature name
#' @return ggplot object
#' @export
gene_OS_scatter <- function(df, gene) {
  gene_values <- df[, which(colnames(df) == gene)]
  df <- mutate(df, vital_status = case_when(status == 1 ~ "DEAD", status == 0 ~ "ALIVE"))
  ggplot(data = df, mapping = aes_string(x = "time", y = gene, color = "vital_status")) +
    geom_point() +
    xlab("Survival") +
    stat_ellipse(level = 0.68) +
    theme_minimal() +
    geom_hline(yintercept = median(gene_values, na.rm = TRUE), lty = 2, color = "gray") +
    geom_vline(xintercept = median(df$time, na.rm = TRUE), lty = 2, color = "gray") +
    geom_vline(xintercept = 60, lty = 2, color = "gray") +
    annotate(
      geom = "text", label = "Median Survival", color = "gray40", angle = 90, vjust = 1.3, hjust = 0,
      x = median(df$time, na.rm = TRUE),
      y = min(gene_values, na.rm = TRUE)
    ) +
    annotate(
      geom = "text", label = "Five Year Survival", color = "gray40", angle = 90, vjust = 1.3, hjust = 0,
      x = 60,
      y = min(gene_values, na.rm = TRUE)
    ) +
    annotate(
      geom = "text", label = paste0("Median ", gene), color = "gray40", vjust = 1, hjust = 1,
      x = max(df$time, na.rm = TRUE),
      y = median(gene_values, na.rm = TRUE)
    )
}


# HEATMAPS #################

#' Create color bar legend
#'
#' @param bc Vector of colors
#' @param min Minimum value
#' @param max Maximum value (default: -min)
#' @param nticks Number of ticks (default: 5)
#' @param ticks Tick positions
#' @param title Legend title (default: '')
#' @return Base plot color bar
#' @export
color.bar <- function(bc, min, max = -min, nticks = 5, ticks = seq(min, max, len = nticks), title = "") {
  scale <- (length(bc) - 1) / (max - min)
  plot(c(0, 10), c(min, max), type = "n", bty = "n", xaxt = "n", xlab = "", yaxt = "n", ylab = "", main = title)
  axis(2, ticks, las = 1)
  for (i in 1:(length(bc) - 1)) {
    y <- (i - 1) / scale + min
    rect(0, y, 10, y + 1 / scale, col = bc[i], border = NA)
  }
}


#' Correlation heatmap with clustering
#'
#' @param mat Data matrix
#' @param title Plot title (default: "")
#' @param x.str X-axis label (default: "")
#' @param y.str Y-axis label (default: "")
#' @param color1 Low correlation color (default: "black")
#' @param color2 Mid correlation color (default: "white")
#' @param color3 High correlation color (default: "purple")
#' @param cex_r Row label size (default: 1)
#' @param cex_c Column label size (default: 0.6)
#' @param mar Margins (default: c(12,13))
#' @return Heatmap plot
#' @export
cor_hm <- function(mat, title = "", x.str = "", y.str = "",
                   color1 = "black", color2 = "white", color3 = "purple",
                   cex_r = 1, cex_c = 0.6, mar = c(12, 13)) {
  if (!require("gplots")) install.packages("gplots")
  if (!require("heatmap3")) install.packages("heatmap3")
  breakBarColors <- c(-200, seq(-1, 1, 0.01), 200) # Outside numbers clip outliers. This is for zscoring.
  barColors <- colorpanel(length(breakBarColors) - 1, color1, color2, color3)

  corOut <- cor(mat)
  corOut[is.na(corOut)] <- 0
  hCor <- hclust(as.dist((1 - corOut) / 2))

  heatmap3(corOut,
    col = barColors, breaks = breakBarColors, legendfun = function() showLegend(legend = c(NA), col = c(NA)),
    Rowv = as.dendrogram(hCor), Colv = as.dendrogram(hCor), scale = "none", margins = mar,
    cexCol = cex_c, cexRow = cex_r,
    main = title, xlab = x.str, ylab = y.str
  )
}


# UPSET PLOTS #################

#' Create upset plot from binary data
#'
#' @param df Data frame with binary/logical columns
#' @param value Value to consider as TRUE (default: TRUE)
#' @param cex.text Text size multiplier
#' @return ggplot upset plot
#' @export
upset_plot <- function(df, value = TRUE, cex.text = 1) {
  df <- mutate_all(df, ~ case_when(.x == value ~ 1, TRUE ~ NA))
  df <- mutate(df, across(everything(), as.character))
  for (col in 1:ncol(df)) {
    df[, col][df[, col] == 1] <- colnames(df)[col]
  }
  df <- rowwise(df) %>% mutate(aggregate = list(c_across()))
  ggplot(df, aes(x = aggregate)) +
    geom_bar() +
    theme_minimal() +
    ylab(paste0("Count (n=", nrow(df), ")")) +
    geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.7, size = 3.88 * cex.text) +
    ggupset::scale_x_upset() +
    scale_y_continuous(expand = expansion(mult = c(0, 0.09))) +
    xlab("Combinations") +
    ggeasy::easy_center_title()
}

#' Create side panel for upset plot
#'
#' @param df Data frame with binary columns
#' @param value Value to consider TRUE (default: TRUE)
#' @param side Panel side: "left" or "right"
#' @param add_percent Show percentages (default: TRUE)
#' @param expand Expansion factor (default: 0.2)
#' @param cex.text Text size multiplier (default: 1)
#' @return ggplot object
#' @export
upset_side <- function(df, value = TRUE, side = "left", add_percent = TRUE, expand = 0.2, cex.text = 1) {
  df <- mutate_all(df, ~ case_when(.x == value ~ 1, TRUE ~ NA))
  plot_df <- colSums(df, na.rm = TRUE) %>%
    enframe(value = "count") %>%
    arrange(count) %>%
    mutate(name = factor(name, levels = name)) %>%
    mutate(perc_label = paste0("(", as.character(round(100 * count / nrow(df), 0)), "%)"))
  if (add_percent != TRUE) {
    plot_df$perc_label <- ""
  }
  if (side == "left") {
    p <- ggplot(plot_df, aes(x = name, y = count)) +
      geom_col() +
      theme_minimal() +
      coord_flip() +
      geom_text(aes(label = paste0(count, perc_label)), hjust = 1.1, size = 3.88 * cex.text) +
      scale_y_reverse(expand = expansion(mult = c(expand, 0))) +
      scale_x_discrete(name = "", position = "top") +
      ylab(paste0("Set Size (n=", nrow(df), ")"))
  }
  if (side == "right") {
    p <- ggplot(plot_df, aes(x = name, y = count)) +
      geom_col() +
      theme_minimal() +
      coord_flip() +
      geom_text(aes(label = paste0(count, perc_label)), hjust = -0.1, size = 3.88 * cex.text) +
      scale_y_continuous(expand = expansion(mult = c(0, expand))) +
      scale_x_discrete(name = "") +
      ylab(paste0("Set Size (n=", nrow(df), ")"))
  }
  return(p)
}


# OPLS #################

#' Rotate OPLS scores and loadings
#'
#' Rotate, swap, and flip OPLS-DA results for better visualization
#'
#' @param plsOut OPLS model object
#' @param degrees Rotation angle in degrees (default: 0)
#' @param swap Swap axes 1 and 2 (default: FALSE)
#' @param flip_y Flip Y-axis (default: FALSE)
#' @param flip_x Flip X-axis (default: FALSE)
#' @return List with rotated scores, loadings, and rotation matrix
#' @export
rotate_opls <- function(plsOut, degrees = 0, swap = F, flip_y = F, flip_x = F) {
  # rotate by specified degrees
  theta <- degrees * pi / 180
  rotmat <- base::rbind(c(cos(theta), -sin(theta)), c(sin(theta), cos(theta)))
  scores <- plsOut@scoreMN %*% rotmat
  T1 <- scores[, 1]
  T2 <- scores[, 2]
  loadings <- plsOut@loadingMN %*% rotmat
  P1 <- loadings[, 1]
  P2 <- loadings[, 2]

  # swap axis 1 and 2 if specified
  if (swap == TRUE) {
    P1temp <- P1
    P2temp <- P2
    P1 <- P2temp
    P2 <- P1temp
    T1temp <- T1
    T2temp <- T2
    T1 <- T2temp
    T2 <- T1temp
  }

  # Flip axes 1 and/or 2 if specified
  if (flip_y == TRUE) {
    P1 <- -P1
    T1 <- -T1
  }
  if (flip_x == TRUE) {
    P2 <- -P2
    T2 <- -T2
  }
  out <- list()
  out$T1 <- T1
  out$T2 <- T2
  out$P1 <- as.matrix(P1)
  out$P2 <- as.matrix(P2)
  out$rotmat <- rotmat
  out$scores <- tibble(T1, T2)
  out$loadings <- tibble(P1, P2)
  return(out)
}
