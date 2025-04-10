#Chapter 21
#Exercices 21.5.10

#1) 
#distinct() in R → DISTINCT in SQL removes duplicates.
#head() in R or LIMIT (MySQL) returns the first few rows.

#2)
#a)
#SELECT * FROM flights WHERE dep_delay < arr_delay:
#Selects all columns from the flights table where the departure delay (dep_delay) is less than the arrival delay (arr_delay).

#SELECT *, distance / (air_time / 60) AS speed FROM flights:
#Selects all columns and calculates the speed as distance / (air_time / 60) and renames it as speed.

#b)
#dbplyr: for the 1st query:
flights %>%
  filter(dep_delay < arr_delay)

#dbplyr: for the 2nd query:
flights %>%
  mutate(speed = distance / (air_time / 60))






