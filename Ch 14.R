install.packages("babynames")
library(babynames)

#Chapter 14
#14.2.4)
#1)

x1 <- "He said \"That's amazing!\""
x1
#> [1] "He said \"That's amazing!\""

stringr::str_view(x1)
#> [1] │ He said "That's amazing!"

x2 <- "\\a\\b\\c\\d"
x2
#> [1] "\\a\\b\\c\\d"

stringr::str_view(x2)
#> [1] │ \a\b\c\d

x3 <- "\\\\\\\\\\\\"
x3
#> [1] "\\\\\\\\"

stringr::str_view(x3)
#> [1] │ \\\\\\

x <- "This\u00a0is\u00a0tricky"
stringr::str_view(x)

#after some googling it looks like u00a0is is's used in text to prevent line breaks between words 

#14.3.4

#1)

# Using str_c()
print(str_c("hi ", NA))
#> [1] NA

# Using paste0()
print(paste0("hi ", NA))
#> [1] "hi NA"

# str_c("hi ", NA) returns NA because if any part of the string is NA, the result is NA.
# paste0("hi ", NA) returns "hi NA" because paste0() change NA to the string "NA".

# Using str_c()
print(str_c(letters[1:2], letters[1:3]))
#> [1] "aa" "bb" "ac"

# Using paste0()
print(paste0(letters[1:2], letters[1:3]))
#> [1] "aa" "bb" "ac"

# str_c() gives a warning when the vectors have different lengths.
# paste0() behaves similarly but without the warning.

#2)

# paste() adds a space by default
print(paste("a", "b"))
#> [1] "a b"

# paste0() does not add space (no separator)
print(paste0("a", "b"))
#> [1] "ab"

# we can recreate paste() with str_c() using the sep argument:
print(str_c("a", "b", sep = " "))
#> [1] "a b"

# paste() adds a separator between the elements by default, whereas paste0() does not.
# str_c() can mimic paste() by using sep = " " for adding a space separator.

#3)

# Convert from str_c() to str_glue()
print(str_glue("The price of {food} is {price}"))

# Convert from str_glue() to str_c()
age <- 30
country <- "USA"
print(str_c("I'm ", age, " years old and live in ", country))

# str_glue() automatically evaluates variables inside curly braces.
# In str_c(), we manually concatenate variables with commas.


#14.5.3)

#1)

babynames |>
  count(length = str_length(name), wt = n)
# We used `wt = n` to weight the count of each name by the number of occurrences (`n`).

#2)

babynames |>
  mutate(
    middle = if_else(
      str_length(name) %% 2 == 1,
      str_sub(name, str_length(name) %/% 2 + 1, str_length(name) %/% 2 + 1),
      str_sub(name, str_length(name) %/% 2, str_length(name) %/% 2)
    )
  )
# This will extract the middle letter from each baby name. The `if_else()` function checks if the name has an odd or even length.

#3)

# for the average name length over time
babynames |>
  group_by(year) |>
  summarize(average_length = mean(str_length(name), na.rm = TRUE))
# for the popularity of first letter over time
babynames |>
  mutate(first_letter = str_sub(name, 1, 1)) |>
  group_by(year, first_letter) |>
  count(sort = TRUE)

# for the popularity of last letter over time
babynames |>
  mutate(last_letter = str_sub(name, -1, -1)) |>
  group_by(year, last_letter) |>
  count(sort = TRUE)

# This will show trends in the average name length and the popularity of the first and last letters over time.

