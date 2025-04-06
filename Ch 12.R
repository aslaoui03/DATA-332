#Exercice 12.2.4
#1)
near 
dplyr::near

near <- function(x, y, tol = sqrt(.Machine$double.eps)) {
  abs(x - y) < tol
}

sqrt(2)^2 == 2     #  FALSE due to floating point rounding
near(sqrt(2)^2, 2) # TRUE

#sqrt(2)^2 is mathematically 2, but due to floating-point precision, it's a tiny bit off. 
#So == returns FALSE, but near() returns TRUE because it checks within a small tolerance.

#2)
library(nycflights13)
library(dplyr)

flights %>%
  mutate(
    dep_time_na = is.na(dep_time),
    sched_dep_time_na = is.na(sched_dep_time),
    dep_delay_na = is.na(dep_delay)
  ) %>%
  count(dep_time_na, sched_dep_time_na, dep_delay_na)

#Exercice 12.4.4
#1)
#sum(is.na(X)) will give me the number of missing values in x
sum(is.na(x))
#mean will give me the proportion of missing values in x
mean(is.na(x))

#2)
prod(c(TRUE, TRUE, TRUE))   # 1*1*1
# [1] 1
prod(c(TRUE, FALSE, TRUE))  # 1*0*1
# [1] 0

#prod(x) returns the products of all values in x, it will return 1 only if all values are true, otherwise 0
#min(x) will give the smallest value 
min(c(TRUE, TRUE))   # 1, 1 → min = 1
# [1] 1

min(c(TRUE, FALSE))  # 1, 0 → min = 0
# [1] 0
#if any value is false (0) it returns 0
#prod(x) and min(x) are equivalent to all(x), while max(x) is equivalent to any(x)

#Exercices 12.4.5

#1) 

x <- 0:20
if_else(x %% 2 == 0, "even", "odd")

#2) 

x <- c("Monday", "Saturday", "Wednesday")
if_else(x %in% c("Saturday", "Sunday"), "weekend", "weekday")

#3)

x <- c(-5, -1, 0, 3, 7)
if_else(x < 0, -x, x)

#4)

library(nycflights13)
library(dplyr)

flights |>
  mutate(
    is_holiday = case_when(
      month == 1 & day == 1     ~ TRUE,  # New Year's Day
      month == 7 & day == 4     ~ TRUE,  # Independence Day
      month == 11 & day >= 22 & day <= 28 & weekdays(as.Date(paste(2013, month, day, sep = "-"))) == "Thursday" ~ TRUE, # Thanksgiving (4th Thursday of November)
      month == 12 & day == 25   ~ TRUE,
      TRUE                      ~ FALSE
    ),
    holiday_name = case_when(
      month == 1 & day == 1     ~ "New Year's Day",
      month == 7 & day == 4     ~ "Independence Day",
      month == 11 & day >= 22 & day <= 28 & weekdays(as.Date(paste(2013, month, day, sep = "-"))) == "Thursday" ~ "Thanksgiving",
      month == 12 & day == 25   ~ "Christmas",
      TRUE                      ~ NA_character_
    )
  ) |>
  select(month, day, is_holiday, holiday_name)


