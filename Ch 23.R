#Chapter 23
#Exercices 23.3.3.5
library(tidyr)
library(dplyr)
library(tibble)
library(jsonlite)

# Provided data frames
df1 <- tribble(
  ~x, ~y,
  1, list(a = 11, b = 12),
  2, list(a = 21, b = 22),
  3, list(a = 31, b = 32)
)

df2 <- tribble(
  ~x, ~y,
  1, list(11, 12, 13),
  2, list(21),
  3, list(31, 32)
)

df4 <- tribble(
  ~x, ~y, ~z,
  "a", list("y-a-1", "y-a-2"), list("z-a-1", "z-a-2"),
  "b", list("y-b-1", "y-b-2", "y-b-3"), list("z-b-1", "z-b-2", "z-b-3")
)

#1)
df2 |> unnest_wider(y)
#This will throw an error unless you supply the `names_repair` argument, because df2's list elements are unnamed.
#to fix this issue we can do this:
df2 |> unnest_wider(y, names_repair = "unique")
#This unnests unnamed elements into multiple columns (e.g., y...1, y...2, etc.), filling missing values with NA.
# The unnamed lists get auto-numbered, and shorter lists get NA padding.

#2)

df1 |> unnest_longer(y)
#Each element of `y` is unpacked into its own row, and a new column `y_id` is added to show the original name ("a" or "b").
# To suppress the `y_id` column:
df1 |> unnest_longer(y, indices_include = FALSE)

#3)

df4 |> unnest_longer(y)
df4 |> unnest_longer(z)
#If we do this separately, we’ll get mismatched row alignment and lose the relationship between `y[i]` and `z[i]`.

#to do it right we have to do:

df4 |> unnest_longer(c(y, z))
#This ensures each `y[i]` stays aligned with the corresponding `z[i]` in the same row.

#Exercices 23.5.4

# Define the two JSON formats
json_col <- parse_json('
  {
    "x": ["a", "x", "z"],
    "y": [10, null, 3]
  }
')

json_row <- parse_json('
  [
    {"x": "a", "y": 10},
    {"x": "x", "y": null},
    {"x": "z", "y": 3}
  ]
')

# Wrap into tibbles
df_col <- tibble(json = list(json_col)) 
df_row <- tibble(json = json_row)

#1) Rectangling df_col

df_col |> 
  unnest_wider(json)

#the following code tidies the column-wise JSON into row-wise format:
df_col |> 
  unnest_wider(json) |> 
  unnest_longer(x) |> 
  unnest_longer(y)
# You'll get 3 rows with columns x and y aligned element-by-element.


# Rectangling df_row (row-oriented JSON)
df_row |> 
  unnest_wider(json)
# since each JSON element is already a row with named fields so it gives tidy rows directly


