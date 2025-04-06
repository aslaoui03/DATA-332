install.packages("babynames")
install.packages("dplyr")
install.packages("stringr")
library(stringr)
library(dplyr)
library(babynames)

#Chapter 15)
#15.3.5)

# 1)
# baby name with the most vowels?
babynames |> 
  mutate(vowels = str_count(name, "[aeiouAEIOU]")) |> 
  arrange(desc(vowels)) |> 
  slice(1)

# name with the highest proportion of vowels?
babynames |> 
  mutate(vowels = str_count(name, "[aeiouAEIOU]"), 
         total_letters = str_length(name)) |> 
  mutate(prop_vowels = vowels / total_letters) |> 
  arrange(desc(prop_vowels)) |> 
  slice(1)

# 2)

str_replace_all("a/b/c/d/e", "/", "\\\\")

str_replace_all("a\\b\\c\\d\\e", "\\\\", "/")

# 3)
str_to_lower_simple <- function(x) {
  str_replace_all(x, c("A" = "a", "B" = "b", "C" = "c", "D" = "d", 
                       "E" = "e", "F" = "f", "G" = "g", "H" = "h", 
                       "I" = "i", "J" = "j", "K" = "k", "L" = "l", 
                       "M" = "m", "N" = "n", "O" = "o", "P" = "p", 
                       "Q" = "q", "R" = "r", "S" = "s", "T" = "t", 
                       "U" = "u", "V" = "v", "W" = "w", "X" = "x", 
                       "Y" = "y", "Z" = "z"))
}

#4) 
regex_telephone <- "\\(\\d{3}\\) \\d{3}-\\d{4}"


#15.4.7)

#1) 
str_view(c("\\?"), "\\\\")
str_view(c("$^$"), "\\$\\^\\$")

#2)
# \: you need to escape the backslash itself, so a single backslash is not enough. You need \\\\ to match a literal backslash.

#\\: This already represents a single backslash, but for a match, it must be written as \\\\.

#\\\: invalid because it doesn't properly escape the third backslash. You would need \\\\\\ to match.

#3)
str_view(words, "^y") #starts with y
str_view(words, "^[^y]") #dont start with y 
str_view(words, "x$") #end with x
str_view(words, "^.{3}$") #3 letter long
str_view(words, "^.{7,}$") #7 letters or more
str_view(words, "[aeiou][^aeiou]") #contains a vowal-consonant pair
str_view(words, "(?:[aeiou][^aeiou]){2,}") #contains at least 2 vowal-consonant pair 
str_view(words, "^[^y]") #only contains repeated vowel-consnant pairs

#4) 
str_view(words, "airplane|aeroplane")
str_view(words, "aluminum|aluminium")
str_view(words, "analog|analogue")
str_view(words, "ass|arse")
str_view(words, "center|centre")
str_view(words, "defense|defence")
str_view(words, "donut|doughnut")
str_view(words, "gray|grey")
str_view(words, "modeling|modelling")
str_view(words, "skeptic|sceptic")
str_view(words, "summarize|summarise")

#5) 
str_replace(words, "^(.)(.*)(.)$", "\\3\\2\\1")
#This will switch the first and last letters in the words, none of em is a word now)

#6) 
# ^.*$ - Matches any string from the start to the end of a line.
# "\\{.+\\}" - Matches a pair of curly braces containing one or more characters.
# \d{4}-\d{2}-\d{2} - Matches a date in the format YYYY-MM-DD.
# "\\\\{4}" - Matches four backslashes in a row.
# \..\..\.. - Matches a string with three characters, each separated by a period.
# (.)\1\1 - Matches a string where the first character is repeated three times.
# "(..)\\1" - Matches a string where two characters are repeated twice.


#15.6.4

#1)
#Find all words that start or end with x.
#Single Regular Expression:
str_view(words, "\\b(x.*|.*x)\\b")
#Using multiple str_detect() calls:
str_view(words[str_detect(words, "^x") | str_detect(words, "x$")])
#Find all words that start with a vowel and end with a consonant.
#Single Regular Expression:
str_view(words, "^[aeiouAEIOU].*[^aeiouAEIOU]$")
#Using multiple str_detect() calls:
str_view(words[str_detect(words, "^[aeiouAEIOU]") & str_detect(words, "[^aeiouAEIOU]$")])
#find any words that contain at least one of each different vowel?    
#Single Regular Expression:
str_view(words, "a.*e.*i.*o.*u")
#Using multiple str_detect() calls:
str_view(words[
  str_detect(words, "a") &
    str_detect(words, "e") &
    str_detect(words, "i") &
    str_detect(words, "o") &
    str_detect(words, "u")
])

#2)
#Evidence for the rule ("i before e"):
str_view(words, "[^cC]ie")
#Evidence against the rule ("i before e except after c"):
str_view(words, "c[ei]e")

#3)
str_view(cols, "(light|dark|bright|pale|deep).*")
#This is to automatically identify color modifiers (like "light", "dark", etc.) in the color names:

#4) 
datasets <- data(package = "datasets")$results[, "Item"]
datasets_cleaned <- gsub("\\(.*\\)", "", datasets)  # Remove grouping label
str_view(datasets_cleaned, "^[A-Za-z][A-Za-z0-9_]*$")









