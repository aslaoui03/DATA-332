#Chapter 26: 26.2.8 

library(dplyr)
library(tidyr)
library(palmerpenguins)
library(nycflights13)
library(lubridate)

#1)

# unique values 
penguins |> 
  summarize(across(everything(), \(x) n_distinct(x)))

# mean 
mtcars |> 
  summarize(across(everything(), mean))

# cut, clarity, color and summarize
diamonds |> 
  group_by(cut, clarity, color) |> 
  summarize(
    n = n(),
    across(where(is.numeric), mean),
    .groups = "drop"
  )

#2)

df <- tibble(a = 1:5, b = c(1, 1, 2, 2, 2))

df |> summarize(across(everything(), list(mean, n_distinct)))
# Output column names are auto-generated as a_1, a_2, b_1, b_2
# because the functions are unnamed — avoid this for clarity.

#3)

expand_dates_clean <- function(df) {
  df |> 
    mutate(
      across(where(is.Date), list(year = year, month = month, day = mday))
    ) |>
    select(-where(is.Date))  # Drop original Date columns
}
# Example:
tibble(name = "Ali", date = ymd("2020-12-31")) |> expand_dates_clean()

#4)

show_missing <- function(df, group_vars, summary_vars = everything()) {
  df |> 
    group_by(pick({{ group_vars }})) |>              # Group by user-supplied grouping vars
    summarize(
      across({{ summary_vars }}, \(x) sum(is.na(x))),# Count NAs in each selected column
      .groups = "drop"
    ) |>
    select(where(\(x) any(x > 0)))                   # Keep only columns with at least one missing value
}
#usage:
nycflights13::flights |> show_missing(c(year, month, day))
#where() is used here to filter for columns that have any NA counts > 0
