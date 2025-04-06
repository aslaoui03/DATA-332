#Chapter 7 Executables
# Load necessary libraries
library(tidyverse)
library(janitor)

# Exercise 1: Read a file with '|' as delimiter
students_pipe <- read_delim("data/students_pipe.txt", delim = "|")

# Exercise 2: Common arguments of read_csv() and read_tsv()
# Both share col_names, col_types, na, skip, comment, guess_max, n_max, locale, progress

# Exercise 3: Important arguments for read_fwf()
# fwf_widths(): specify field widths
# fwf_positions(): specify field positions
# col_names: specify column names

# Exercise 4: Reading CSV with custom quote character
text_data <- "x,y\n1,'a,b'"
df <- read_csv(text_data, quote = "'")
print(df)

# Exercise 5: Identify errors in CSV files ( this question was already answered in my doc)
# 5.1: Extra column in first row (invalid format)
# read_csv("a,b\n1,2,3\n4,5,6")

# 5.2: Missing value in second row, extra column in third row
# read_csv("a,b,c\n1,2\n1,2,3,4")

# 5.3: Unclosed quote issue
# read_csv("a,b\n\"1")


# 5.4: Data type mismatch (numeric vs string headers)
# read_csv("a,b\n1,2\na,b")

# 5.5: Incorrect delimiter
# read_csv("a;b\n1;3")

# Exercise 6: Working with non-syntactic names
tibble_data <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(10)
)

# Extract variable called `1`
print(tibble_data$`1`)

# Scatterplot of `1` vs. `2`
ggplot(tibble_data, aes(x = `1`, y = `2`)) +
  geom_point() +
  labs(title = "Scatterplot of 1 vs 2")

# Create a new column `3`
tibble_data <- tibble_data |> mutate(`3` = `2` / `1`)
print(tibble_data)

# Rename columns
tibble_data <- tibble_data |> rename(one = `1`, two = `2`, three = `3`)
print(tibble_data)
