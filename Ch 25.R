#Chapter 25
#Exercise 25.2.5

library(dplyr)
library(stringr)
library(lubridate)
library(tidyr)
library(nycflights13)

# Q1: Convert repetitive code snippets into functions

# 1a: Proportion of missing values
prop_na <- function(x) {
  mean(is.na(x))
}
#Calculates the proportion of NA values in a vector.

# 1b: Proportional share of each element
prop_share <- function(x) {
  x / sum(x, na.rm = TRUE)
}
#Normalizes each value to be a proportion of the total sum.

# 1c: Convert to percentages with 1 decimal
prop_percent <- function(x) {
  round(x / sum(x, na.rm = TRUE) * 100, 1)
}
#Returns each value as a percent of the total, rounded to 1 decimal place.

# Q2: Rewrite rescale01() to map -Inf → 0 and Inf → 1

rescale01_strict <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  scaled <- (x - rng[1]) / (rng[2] - rng[1])
  scaled[x == -Inf] <- 0
  scaled[x == Inf] <- 1
  scaled
}
#This function rescales values to [0, 1] and handles infinities safely.

#Q3: Compute age in years from birthdates

age_years <- function(birthdate) {
  as.integer(floor((Sys.Date() - as.Date(birthdate)) / 365.25))
}
#Returns the approximate age in years from a date of birth.

# Q4: Write functions to compute variance and skewness

my_variance <- function(x) {
  m <- mean(x, na.rm = TRUE)
  mean((x - m)^2, na.rm = TRUE)
}
#Manual calculation of population variance.

my_skewness <- function(x) {
  m <- mean(x, na.rm = TRUE)
  s <- sd(x, na.rm = TRUE)
  mean(((x - m) / s)^3, na.rm = TRUE)
}
#Computes skewness (third standardized moment) of a vector.

# Q5: Write both_na() to count where both vectors have NAs

both_na <- function(x, y) {
  sum(is.na(x) & is.na(y))
}
#Returns the number of positions where both x and y are NA.

# Q6: Short file-checking utilities

is_directory <- function(x) {
  file.info(x)$isdir
}
#Checks if a file path points to a directory.

is_readable <- function(x) {
  file.access(x, 4) == 0
}
#Checks if a file is readable by the current user.
#These are useful for validating file inputs in scripts before reading or writing,
# helping to make your code safer and more robust.

#Exercise 25.3.5

# Q1.1: Function to filter flights delayed > 1hr or cancelled

filter_severe <- function(df, hours = 1) {
  df |> filter(is.na(arr_time) | dep_delay > hours * 60)
}
#Filters for cancelled flights or those with delays over 'hours'.
# Example:
flights |> filter_severe()

# Q1.2: Function to count severe flights after grouping
summarize_severe <- function(df) {
  df |> 
    summarize(
      cancelled = sum(is.na(arr_time)),
      delayed = sum(dep_delay > 60, na.rm = TRUE),
      .groups = "drop"
    )
}
#Summarizes total cancelled and >1hr delayed flights.
# Example:
flights |> group_by(dest) |> summarize_severe()

# Q1.3: Same as filter_severe but with custom delay threshold

# Already implemented above with `hours` argument in `filter_severe()`
# Example:
flights |> filter_severe(hours = 2)

# Q1.4: Summarize a numeric weather variable (e.g., temp, wind_speed)
summarize_weather <- function(df, var) {
  df |> 
    summarize(
      min = min({{ var }}, na.rm = TRUE),
      mean = mean({{ var }}, na.rm = TRUE),
      max = max({{ var }}, na.rm = TRUE),
      .groups = "drop"
    )
}
#Summarizes any weather column: min, mean, and max
# Example:
weather |> summarize_weather(temp)

# Q1.5: Standardize time variables like dep_time into decimal hours
standardize_time <- function(df, time_col) {
  df |> 
    mutate(
      {{ time_col }} := ({{ time_col }} %/% 100) + ({{ time_col }} %% 100) / 60
    )
}
#Converts times like 935 → 9.583 hours
#Example:
flights |> standardize_time(sched_dep_time) |> select(sched_dep_time)

# Q2: Which arguments use tidy evaluation?

# Function        |Tidy Evaluation| Type
# --------------- | --------------| ---------
# distinct()      | var names     | data-masking
# count()         | var names     | data-masking
# group_by()      | var names     | data-masking
# rename_with()   | column names  | tidy-selection
# slice_min()     | ordering var  | data-masking
# slice_sample()  | .by (grouping)| data-masking

#If it evaluates inside `mutate()` or `filter()` → data-masking
#     If it chooses columns to modify → tidy-selection

# Q3: Generalize count_prop() to accept multiple variables
count_prop_multi <- function(df, ..., sort = FALSE) {
  df |> 
    count(..., sort = sort) |> 
    mutate(prop = n / sum(n))
}
#Works with 1 or more grouping vars using `...`
# Example:
flights |> count_prop_multi(origin, carrier)

#Exercise 24.4.5 
scatter_with_fit <- function(df, x, y) {
  title <- englue("Scatterplot of {{x}} vs {{y}} with linear model fit")
  
  df |>
    ggplot(aes(x = {{ x }}, y = {{ y }})) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE, color = "blue") +
    labs(title = title)
}
# Example:
# Use a small sample of `diamonds` for better visibility
diamonds |> 
  filter(carat < 2.5) |> 
  scatter_with_fit(carat, price)

#Exercise 25.5.1

#1)

# Original f1: Checks if a string starts with a given prefix
starts_with_prefix <- function(string, prefix) {
  str_sub(string, 1, str_length(prefix)) == prefix
}
#usage:
starts_with_prefix(c("abc", "axy", "bca"), "a")
#> TRUE TRUE FALSE

# Original f3: Repeats y to match the length of x
repeat_to_match <- function(template, value) {
  rep(value, length.out = length(template))
}
#usage:
repeat_to_match(1:5, "x")
#> "x" "x" "x" "x" "x"

#2)
# Original function from 25.3.5:
filter_cancelled_or_delayed <- function(df, delay_hours = 1) {
  df |> filter(is.na(arr_time) | dep_delay > delay_hours * 60)
}
#Renamed from filter_severe to make intent clearer
#usage:
# flights |> filter_cancelled_or_delayed()

#3)

#  Argument for norm_r(), norm_d(), etc.:
# More descriptive of function purpose
# Easier to learn and autocomplete (esp. with many distributions)

#  Argument for rnorm(), dnorm(), etc.:
# Concise and widely adopted in R ecosystem
# Familiar to experienced users and textbooks

# what i would suggest:
# Use more readable suffixes with slight verbosity
rnorm_vec  # random generation
dnorm_pdf  # density
pnorm_cdf  # cumulative probability
qnorm_inv  # quantile function
# These names preserve brevity while keeping it clear

