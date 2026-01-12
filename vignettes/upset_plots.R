## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 8,
    fig.height = 5
)


## ----load---------------------------------------------------------------------
library(Pmisc)
library(dplyr)
library(ggplot2)


## ----create_binary_data-------------------------------------------------------
# Create binary indicators for different car characteristics
mtcars_binary <- mtcars %>%
    mutate(
        HighMPG = mpg > median(mpg),
        HighHP = hp > median(hp),
        FourCylinder = cyl == 4,
        Automatic = am == 0,
        V_Engine = vs == 0
    ) %>%
    select(HighMPG, HighHP, FourCylinder, Automatic, V_Engine)

# Preview the data
head(mtcars_binary) %>% knitr::kable()


## ----basic_upset--------------------------------------------------------------
upset_plot(mtcars_binary)


## ----upset_text_size----------------------------------------------------------
upset_plot(mtcars_binary, cex.text = 1.2)


## ----side_panel_left----------------------------------------------------------
# Left side panel
upset_side(mtcars_binary, side = "left")


## ----side_panel_right---------------------------------------------------------
# Right side panel (without percentages)
upset_side(mtcars_binary, side = "right", add_percent = FALSE)


## ----combined, fig.width=10, fig.height=5-------------------------------------
# Create both plots
main_plot <- upset_plot(mtcars_binary, cex.text = 1.1)
side_plot <- upset_side(mtcars_binary, side = "left", cex.text = 1.1)

# Combine using make_grid
make_grid(list(side_plot, main_plot), nrow = 1, ncol = 2)


## ----expanded_sets------------------------------------------------------------
# Create more detailed binary classifications
mtcars_expanded <- mtcars %>%
    mutate(
        HeavyWeight = wt > median(wt),
        FastQuarterMile = qsec < median(qsec),
        FourGears = gear == 4,
        MultiCarb = carb > 2
    ) %>%
    select(HeavyWeight, FastQuarterMile, FourGears, MultiCarb)

# Create upset plot
upset_plot(mtcars_expanded)


## ----custom_values------------------------------------------------------------
# Create data with 1/0 instead of TRUE/FALSE
mtcars_numeric <- mtcars_binary * 1 # Convert TRUE/FALSE to 1/0

# Use value = 1 to indicate membership
upset_plot(mtcars_numeric, value = 1)


## ----custom_values_text-------------------------------------------------------
# Works with any value
mtcars_text <- mtcars_binary %>%
    mutate(across(everything(), ~ ifelse(.x, "Yes", "No")))

upset_plot(mtcars_text, value = "Yes")


## ----iris_example-------------------------------------------------------------
# Create binary indicators for above-median measurements
iris_binary <- iris %>%
    mutate(
        LargeSepalLength = Sepal.Length > median(Sepal.Length),
        LargeSepalWidth = Sepal.Width > median(Sepal.Width),
        LargePetalLength = Petal.Length > median(Petal.Length),
        LargePetalWidth = Petal.Width > median(Petal.Width)
    ) %>%
    select(LargeSepalLength, LargeSepalWidth, LargePetalLength, LargePetalWidth)

# Create combined visualization
iris_upset <- upset_plot(iris_binary, cex.text = 1.1)
iris_side <- upset_side(iris_binary, side = "left", cex.text = 1.1)

make_grid(list(iris_side, iris_upset), nrow = 1, ncol = 2)


## ----side_expansion-----------------------------------------------------------
upset_side(mtcars_binary, side = "right", expand = 0.3, add_percent = FALSE)


## ----custom_styling-----------------------------------------------------------
upset_plot(mtcars_binary, cex.text = 1.1) +
    theme_minimal() +
    theme(
        plot.background = element_rect(fill = "white", color = NA),
        panel.grid.major = element_line(color = "gray90")
    )

