#Chapter 20:
#20.2.9 

#1) 
install.packages(c("readxl", "openxlsx", "writexl", "dplyr", "janitor", "tidyr"))
#packages
library(readxl)
library(openxlsx)
library(writexl)
library(dplyr)
library(tidyr)
library(janitor)

survey <- read_excel("/Users/amineslaoui/desktop/survey2.xlsx", 
                     col_types = c("text", "numeric"))
print(survey)
str(survey)

#2)
# Read the file with default settings
roster_raw <- read_excel("/Users/amineslaoui/desktop/roster.xlsx")

# Fill down merged cells
roster <- roster_raw %>%
  fill(group, subgroup)

# Print
print(roster)

#3-a)
sales <- read_excel("/Users/amineslaoui/desktop/sales.xlsx", skip = 4, col_names = c("id", "n"))
# Check
print(sales)

#3-b)
# Load necessary libraries
library(dplyr)
library(tidyr)
library(stringr)

sales <- sales %>%
  mutate(brand = if_else(str_detect(id, "Brand"), id, NA_character_)) %>%
  fill(brand) %>%
  filter(!str_detect(id, "Brand")) %>%
  mutate(
    id = as.numeric(id),
    n = as.numeric(n)
  ) %>%
  select(brand, id, n)
#result
print(sales)

#4)
bake_sale <- data.frame(
  item = c("Lemon Bar", "Chocolate Cake", "Cinnamon Roll", "Cheese Croissant", "Blueberry Muffin"),
  price = c(3.0, 4.5, 2.0, 3.5, 2.8),
  quantity_sold = c(80, 50, 90, 30, 70)
)
print(bake_sale)

# write out to excel
library(openxlsx)
write.xlsx(bake_sale, "bake_sale_updated.xlsx")
cat("bake_sale_updated.xlsx has been created!")

#5)
install.packages("janitor")
library(janitor)
install.packages("readxl")
library(readxl)
install.packages("read_csv")
library(read_csv)
install.packages("readr")
library(readr)

# Read the students.xlsx file
students <- read_excel("/Users/amineslaoui/desktop/students.xlsx")

# View the first few rows of the data to inspect
head(students)
# Clean the column names
students_clean <- students %>%
clean_names()

head(students_clean)

#6)
#If you try to read an .xlsx file with read_xls(), it will throw an error 
#because read_xls() only supports .xls files.

#20.3.6
#1)The resulting data frames may not be exactly the same due to differences in how
#the two platforms handle data (Excel vs. Google Sheets) 
#and how R's reading functions interpret column types, missing values, and formatting. 

#2)
install.packages("googlesheets4")
install.packages("dplyr")
library(googlesheets4)
library(dplyr)
survey_data <- read_sheet("https://pos.it/r4ds-survey") %>%
  mutate(
    survey_id = as.character(survey_id),  # Ensure survey_id is a character variable
    n_pets = as.numeric(n_pets)  # Ensure n_pets is numeric
  )

# View the result
print(survey_data)

#3)
install.packages("googlesheets4")
install.packages("dplyr")
library(googlesheets4)
library(dplyr)
roster <- read_sheet("https://pos.it/r4ds-roster")

# View the result
print(roster)

