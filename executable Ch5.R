#Chapter 5 executables:
# Load required packages
library(tidyverse)

# Creating example tables
table1 <- tibble(
  country = c("Afghanistan", "Afghanistan", "Brazil", "Brazil", "China", "China"),
  year = c(1999, 2000, 1999, 2000, 1999, 2000),
  cases = c(745, 2666, 37737, 80488, 212258, 213766),
  population = c(19987071, 20595360, 172006362, 174504898, 1272915272, 1280428583)
)

# Computing rate per 10,000 people
table1 <- table1 |> mutate(rate = cases / population * 10000)
print(table1)

# Compute total cases per year
total_cases <- table1 |> group_by(year) |> summarize(total_cases = sum(cases), .groups = 'drop')
print(total_cases)

# Visualizing data
ggplot(table1, aes(x = year, y = cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country, shape = country)) +
  scale_x_continuous(breaks = c(1999, 2000))

# Exercises for 5.2.1
# Table2 Representation
table2 <- tibble(
  country = rep(c("Afghanistan", "Afghanistan", "Brazil", "Brazil", "China", "China"), each = 2),
  year = rep(c(1999, 2000), times = 3, each = 2),
  type = rep(c("cases", "population"), times = 6),
  count = c(745, 19987071, 2666, 20595360, 37737, 172006362, 80488, 174504898, 212258, 1272915272, 213766, 1280428583)
)

# Extracting cases and population for rate calculation
table2_cases <- table2 |> filter(type == "cases") |> select(country, year, count) |> rename(cases = count)
table2_population <- table2 |> filter(type == "population") |> select(country, year, count) |> rename(population = count)

# Merging cases and population, then computing rate
if (nrow(table2_cases) > 0 & nrow(table2_population) > 0) {
  table2_tidy <- left_join(table2_cases, table2_population, by = c("country", "year")) |> 
    mutate(rate = cases / population * 10000)
  print(table2_tidy)
} else {
  print("Error: table2_tidy could not be created due to missing data.")
}


#Chapter 6 executables:

# Load necessary libraries
library(dplyr)
library(nycflights13)

# Filtering flights data
not_cancelled <- flights |> 
  filter(!is.na(dep_delay), !is.na(arr_delay))

# Summarizing delay data
not_cancelled |> 
  group_by(year, month, day) |> 
  summarize(mean_delay = mean(dep_delay, na.rm = TRUE), .groups = 'drop')

# Check working directory
getwd()

# Creating a project structure
dir.create("data", showWarnings = FALSE)

# Save a sample dataset
write_csv(diamonds, "data/diamonds.csv")

# Generate a visualization
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_hex()
ggsave("diamonds.png")


