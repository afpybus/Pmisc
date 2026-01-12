## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 7,
    fig.height = 5
)


## ----load, message=FALSE, warning=FALSE---------------------------------------
library(Pmisc)
library(dplyr)
library(ggplot2)
library(survival)


## ----explore_data-------------------------------------------------------------
# Load the lung dataset
data(lung)

# Preview the data
head(lung) %>% knitr::kable()

# Summary of key variables
summary(lung[, c("time", "status", "age", "sex", "ph.ecog")])


## ----prepare_data-------------------------------------------------------------
# Prepare the lung dataset
lung_prep <- lung %>%
    mutate(
        status = status - 1, # Convert 1/2 to 0/1
        sex_binary = sex - 1 # Convert to 0/1 for easier interpretation
    ) %>%
    filter(!is.na(time), !is.na(status)) # Remove missing values

# Verify the conversion
table(lung_prep$status)


## ----coxph_all----------------------------------------------------------------
# Define features to test
features <- c("age", "sex_binary", "ph.ecog", "ph.karno", "pat.karno", "wt.loss")

# Run Cox proportional hazards for all features
cox_results <- coxph_all(
    df = lung_prep,
    feature.names = features,
    time_col = "time",
    status_col = "status"
)

# View results
cox_results %>%
    select(feature, n, hazard_ratio, wald_p, p.adj, p.signif, result) %>%
    knitr::kable(digits = 4)


## ----survival_volcano---------------------------------------------------------
survival_volcano(cox_results) +
    ggtitle("Survival Analysis: Lung Cancer Dataset")


## ----km_sex-------------------------------------------------------------------
# Create categorical variable for sex
lung_km <- lung_prep %>%
    mutate(sex_cat = ifelse(sex_binary == 1, "Female", "Male"))

# Kaplan-Meier plot by sex
KM_categorical(
    df = lung_km,
    gene = "sex", # Column name prefix
    time_scale = "Time (days)",
    reclass = FALSE # Don't split by median since already categorical
)


## ----km_age-------------------------------------------------------------------
# Kaplan-Meier plot for age (split at median)
KM_categorical(
    df = lung_prep,
    gene = "age",
    time_scale = "Time (days)",
    reclass = TRUE # Split continuous variable at median
) +
    ggtitle("Survival by Age (Median Split)")


## ----km_ecog------------------------------------------------------------------
# Create binary ECOG variable (good vs poor performance)
lung_ecog <- lung_prep %>%
    filter(!is.na(ph.ecog)) %>%
    mutate(ph.ecog_cat = ifelse(ph.ecog <= 1, "Good (0-1)", "Poor (2-3)"))

KM_categorical(
    df = lung_ecog,
    gene = "ph.ecog",
    time_scale = "Time (days)",
    reclass = FALSE
) +
    ggtitle("Survival by ECOG Performance Status")


## ----gene_os_scatter----------------------------------------------------------
gene_OS_scatter(
    df = lung_prep,
    gene = "age"
) +
    ggtitle("Age vs Survival Time")


## ----gene_os_scatter_wt-------------------------------------------------------
# Another example: Weight loss vs survival
lung_wt <- lung_prep %>% filter(!is.na(wt.loss))

gene_OS_scatter(
    df = lung_wt,
    gene = "wt.loss"
) +
    ggtitle("Weight Loss vs Survival Time")


## ----complete_workflow--------------------------------------------------------
# 1. Prepare data
lung_analysis <- lung %>%
    mutate(
        status = status - 1,
        Female = (sex == 2) * 1,
        Elderly = (age >= 65) * 1
    ) %>%
    filter(!is.na(time), !is.na(status))

# 2. Test multiple features
features_test <- c("age", "Female", "Elderly", "ph.ecog", "ph.karno", "meal.cal", "wt.loss")

cox_results_full <- coxph_all(
    df = lung_analysis,
    feature.names = features_test,
    time_col = "time",
    status_col = "status"
)

# 3. View significant results
cox_results_full %>%
    filter(p.signif != "ns") %>%
    select(feature, hazard_ratio, p.adj, result) %>%
    arrange(p.adj) %>%
    knitr::kable(digits = 4)

# 4. Visualize results
survival_volcano(cox_results_full) +
    ggtitle("Survival Analysis: Comprehensive Feature Testing")


## ----advanced_example---------------------------------------------------------
# Test interaction between sex and age
lung_interaction <- lung_prep %>%
    mutate(
        age_group = cut(age,
            breaks = c(0, 60, 70, 100),
            labels = c("Young", "Middle", "Old")
        ),
        sex_label = ifelse(sex_binary == 1, "Female", "Male")
    ) %>%
    filter(!is.na(age_group))

# Run Cox model with interaction
cox_interaction <- coxph(Surv(time, status) ~ age_group * sex_label,
    data = lung_interaction
)

summary(cox_interaction)

