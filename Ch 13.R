#Chapter 13:
#Exercices 13.3.1

#1) 
#To count the number of missing values in a variable (say, dep_time), 
#we can use count() with is.na() like this:
  flights |> 
  count(is.na(dep_time))
  
#2) 
  #original:
  flights |> count(dest, sort = TRUE)
  #expanded:
    flights |> 
    group_by(dest) |> 
    summarize(n = n()) |> 
    arrange(desc(n))
  #original:
  flights |> count(tailnum, wt = distance)
  #expanded: 
    flights |> 
    group_by(tailnum) |> 
    summarize(n = sum(distance, na.rm = TRUE))
    
#13.4.8)
#1) 
    flights |>   # Refers to the flights dataset from the nycflights13 package.
      filter(month == 1, day == 1) |>    # Filters the dataset to only include flights on January 1st.
      ggplot(aes(x = sched_dep_time, y = dep_delay)) +
      geom_point() #Creates a ggplot object, setting the x-axis to scheduled departure time,
      #and the y-axis to departure delay. Then it adds points to the plot
    
#2) you can use sin(x) cos(x) tan(x) asin(x) acos(x) atan(x)  atan2(y, x). ant they all use radians
    
#3) 
    convert_to_minutes <- function(x) {
      hour <- x %/% 100
      minute <- x %% 100
      hour * 60 + minute
    }
    
    flights <- flights |> 
      mutate(
        dep_time_mins = convert_to_minutes(dep_time),
        sched_dep_time_mins = convert_to_minutes(sched_dep_time)
      )
  # Now dep_time_mins and sched_dep_time_mins are continuous and easy to analyze.
    
#4) 
    round_to_nearest_5 <- function(x) {
      round(x / 5) * 5
    }
    
    flights <- flights |> 
      mutate(
        dep_time_5min = round_to_nearest_5(dep_time_mins),
        arr_time_5min = round_to_nearest_5(convert_to_minutes(arr_time))
      )

#13.5.4)
    
#1)
    library(nycflights13)
    library(dplyr)
    
    flights |> 
      filter(!is.na(dep_delay)) |> 
      mutate(rank = min_rank(desc(dep_delay))) |> 
      filter(rank <= 10) |> 
      arrange(desc(dep_delay))
#2)
    flights |> 
      group_by(tailnum) |> 
      summarize(
        avg_delay = mean(arr_delay, na.rm = TRUE),
        n = n()
      ) |> 
      filter(n > 20) |>  # exclude planes with very few flights
      arrange(desc(avg_delay))
  #This gives the worst average arrival delay by plane.
    
#3) 
    flights |> 
      mutate(hour = sched_dep_time %/% 100) |> 
      group_by(hour) |> 
      summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) |> 
      arrange(avg_delay)
  #Earlier hours generally have less delay.
    
#4)
    flights |> 
      group_by(dest) |> 
      filter(row_number() < 4)
    #this returns thew first 3 rows for each destination 
  
    flights |> 
      group_by(dest) |> 
      filter(row_number(dep_delay) < 4)
    #However, this one returns the 3 flights with the least departure delay for each destination

#5) 
    flights |> 
      filter(!is.na(dep_delay)) |> 
      group_by(dest) |> 
      mutate(total_delay = sum(dep_delay, na.rm = TRUE)) |> 
      ungroup() |> 
      mutate(prop_delay = dep_delay / total_delay)
    #prop_delay shows the flight’s contribution to total delay at its destination.

#6)
    flights |> 
      mutate(hour = dep_time %/% 100) |> 
      group_by(year, month, day, hour) |> 
      summarize(
        dep_delay = mean(dep_delay, na.rm = TRUE),
        n = n(),
        .groups = "drop"
      ) |> 
      filter(n > 5) |> 
      mutate(previous_hour_delay = lag(dep_delay))
    # we can visualize this with a scatterplot
    
    ggplot(data = result, aes(x = previous_hour_delay, y = dep_delay)) +
      geom_point() +
      geom_smooth(method = "lm") +
      labs(x = "Previous Hour Delay", y = "Current Hour Delay")
    
#7)
    flights |> 
      group_by(dest) |> 
      filter(!is.na(air_time)) |> 
      mutate(min_air_time = min(air_time, na.rm = TRUE)) |> 
      ungroup() |> 
      mutate(rel_air_time = air_time / min_air_time) |> 
      arrange(rel_air_time)
    # flights with rel_air_time close to 1 are fastest. <1 might be suspicious.

    flights |> 
      mutate(air_delay = arr_delay - dep_delay) |> 
      arrange(desc(air_delay))
    # these were the flights that were delayed the most in air
    
#8)
    # Find destinations with multiple carriers
    multi_carrier_dests <- flights |> 
      group_by(dest) |> 
      summarize(n_carriers = n_distinct(carrier)) |> 
      filter(n_carriers >= 2)
    
    # Now compare carrier performance at those destinations
    flights |> 
      semi_join(multi_carrier_dests, by = "dest") |> 
      group_by(dest, carrier) |> 
      summarize(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop") |> 
      arrange(dest, avg_delay)
    