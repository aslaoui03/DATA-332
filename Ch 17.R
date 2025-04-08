#Chapter 17
#Exercises 17.2.5

#1)
#if we try to parse string that contains an invalid date, 
#lubridate will return NA for that invalid date.

ymd(c("2010-10-10", "bananas"))

#Here, the date is valid, so it's parsed correctly, while "bananas" is invalid, so it returns NA.

#2) 
#The tzone argument to today() specifies the time zone to use when generating the current date. 
#it will either uses the systems time zone or the one you specify

today(tzone = "UTC")
#The tzone argument is important because date-times are influenced by time zones,
#and different time zones can have different dates depending on where you are.

#3) 
d1 <- "January 1, 2010"

read_csv("date
         January 1, 2010", col_types = cols(date = col_date("%B %d, %Y")))
mdy("January 1, 2010")

d2 <- "2015-Mar-07"
read_csv("date
         2015-Mar-07", col_types = cols(date = col_date("%Y-%b-%d")))
ymd("2015-Mar-07")

d3 <- "06-Jun-2017"
read_csv("date
         06-Jun-2017", col_types = cols(date = col_date("%d-%b-%Y")))
dmy("06-Jun-2017")

d4 <- c("August 19 (2015)", "July 1 (2015)")
read_csv("date
         August 19 (2015)
         July 1 (2015)", col_types = cols(date = col_date("%B %d (%Y)")))
d4_clean <- gsub("\\(|\\)", "", d4)  
mdy(d4_clean)

d5 <- "12/30/14"
read_csv("date
         12/30/14", col_types = cols(date = col_date("%m/%d/%y")))
mdy("12/30/14")

t1 <- "1705"
read_csv("time
         1705", col_types = cols(time = col_time("%H%M")))
hms("1705")

t2 <- "11:15:10.12 PM"
parsed_time <- strptime(t2, format = "%I:%M:%OS %p")
parsed_time

#17.3.4
# Load necessary packages
library(dplyr)
library(ggplot2)
library(lubridate)

#1)
flights_dt %>%
  mutate(dep_hour = dep_time - floor_date(dep_time, "day")) %>%
  mutate(dep_hour = hms::as_hms(dep_hour)) %>%
  ggplot(aes(x = dep_hour)) +
  geom_freqpoly(binwidth = 60 * 30) +
  facet_wrap(~ year(dep_time))  

#The distribution of flight times remains consistent throughout the year, with no changes in patterns by day.

#2)
flights_dt %>%
  ggplot(aes(x = dep_time, y = sched_dep_time)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Departure Time vs Scheduled Departure Time")  

flights_dt %>%
  ggplot(aes(x = dep_time, y = dep_delay)) +
  geom_point() +
  labs(title = "Departure Time vs Departure Delay")  

#Dep_time and sched_dep_time are generally close but not identical. 
#Dep_delay shows a slight correlation with dep_time, but there are some delays regardless of time.

#3)
flights_dt %>%
  mutate(duration = as.numeric(arr_time - dep_time, units = "mins")) %>%
  ggplot(aes(x = air_time, y = duration)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "blue") +
  labs(title = "Air Time vs Duration (Departure to Arrival)")  

#`air_time` and the time between departure and arrival are mostly consistent,
#though ther could be differences due to layovers and other factors.

#4)
flights_dt %>%
  mutate(dep_hour = hour(dep_time)) %>%
  group_by(dep_hour) %>%
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = dep_hour, y = avg_delay)) +
  geom_line() +
  labs(title = "Average Delay Time Over the Course of the Day")  

#Delays tend to increase later in the day. with `dep_time` we can see real delays compared to `sched_dep_time`.

#5)
flights_dt %>%
  mutate(wday = wday(dep_time, label = TRUE)) %>%
  group_by(wday) %>%
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wday, y = avg_delay)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Delay by Day of the Week")  

#To minimize delays you should go on tuesday or wednesday because thats when less delays happens

#6)
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 50) +
  labs(title = "Distribution of Diamond Carats")

flights_dt %>%
  ggplot(aes(x = sched_dep_time)) +
  geom_histogram(bins = 50) +
  labs(title = "Distribution of Scheduled Departure Times")  

#Both the distribution of diamond carat weights and scheduled departure times are right-skewed.

#7)
flights_dt %>%
  mutate(dep_minute = minute(dep_time),
         dep_delay_binary = ifelse(dep_delay > 0, 1, 0)) %>%
  filter(dep_minute >= 20 & dep_minute <= 30 | dep_minute >= 50 & dep_minute <= 60) %>%
  ggplot(aes(x = dep_minute, fill = factor(dep_delay_binary))) +
  geom_bar(stat = "count") +
  labs(title = "Early Departures (Minutes 20-30 and 50-60) and Delay Binary")  

#Early departures, especially in minutes 20-30 and 50-60, tend to be associated with delayed flights, supporting the hypothesis that these early times are often due to flights leaving ahead of schedule.

#17.4.4
#1) 
# The key fact is that days() creates a time span, and `!overnight` is a logical negation of `overnight`, 
# where TRUE (overnight) is converted into 1 day, and FALSE (!overnight) is converted into 0 days.

# Example for days(!overnight) and days(overnight)
overnight <- TRUE
days_overnight <- days(overnight)  # This will be 1 day.
days_not_overnight <- days(!overnight)  # This will be 0 days.

#2)
dates_2015 <- seq(ymd("2015-01-01"), by = "month", length.out = 12)
#We can generate a sequence of dates using `seq()`, specifying the start date and time interval.

dates_current_year <- seq(ymd(paste0(format(Sys.Date(), "%Y"), "-01-01")), by = "month", length.out = 12)
# this vector generates the first day of each month for the current year.

#3)
age_in_years <- function(birthday) {
  today_date <- today()
  age <- as.numeric(difftime(today_date, birthday, units = "secs")) / (60 * 60 * 24 * 365.25)
  return(floor(age))
}
#This function calculates age by finding the difference in time between today and the birthday and converts it to years.

#4)
# The reason why (today() %--% (today() + years(1))) / months(1) doesn't work is that intervals can't be divided by periods directly. 
