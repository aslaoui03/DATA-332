#Chapter 18
#Exercises 18.3.4

#1)
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# To identify the relationship between the carrier and missing rows in the planes dataset, we can check 
# which rows in the flights dataset have a missing match in the planes dataset.
# We will then check for the carrier values for these rows in the flights dataset.

#we'll use anti_join to find the rows in flights where the tailnum (aircraft ID) is missing from planes.
missing_planes <- flights %>%
  distinct(tailnum) %>%
  anti_join(planes, by = "tailnum")

#let's check the carrier for these missing tailnum rows.
missing_planes_with_carriers <- flights %>%
  filter(tailnum %in% missing_planes$tailnum) %>%
  select(tailnum, carrier)

#results
missing_planes_with_carriers

#The missing tailnum entries in the planes dataset appear to be associated with
#specific carriers like AA, MQ, and UA, which means some planes from these airlines are not
#represented in the planes dataset.




