
#Exercice 10.3.3

# libraries
library(ggplot2)
library(dplyr)
library(forcats)
library(nycflights13)
library(lvplot)

# 1. Explore the distribution of x, y, and z in diamonds
ggplot(diamonds, aes(x = x)) + geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(x = y)) + geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(x = z)) + geom_histogram(binwidth = 0.5)

# 2. Explore the distribution of price with different binwidths
ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 100)
ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 500)
ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 1000)

# 3. Count diamonds at 0.99 and 1 carat
diamonds %>% filter(carat == 0.99) %>% count()
diamonds %>% filter(carat == 1.00) %>% count()

# 4. Compare coord_cartesian() vs. xlim()/ylim()
ggplot(diamonds, aes(x = price)) +
  geom_histogram(binwidth = 100) +
  coord_cartesian(xlim = c(500, 2000))

ggplot(diamonds, aes(x = price)) +
  geom_histogram(binwidth = 100) +
  xlim(500, 2000)

# Chapter 10.4.1

#libraries again...
library(ggplot2)
library(dplyr)
library(nycflights13)

# 1. What happens to missing values in a histogram?
# First, i created a modified dataset where 'y' has missing values for outliers
diamonds2 <- diamonds %>%
  mutate(y = if_else(y < 3 | y > 20, NA, y))

# Plot histogram of 'y' with missing values included
ggplot(diamonds2, aes(x = y)) + 
  geom_histogram(binwidth = 0.5)  # Missing values are ignored, but warning is shown

# Using na.rm = TRUE to remove the warning
ggplot(diamonds2, aes(x = y)) + 
  geom_histogram(binwidth = 0.5, na.rm = TRUE)  # Silences the warning, but same result

# - Histograms dont how missing values as a separate bar. The warning tells us that some values were removed due to NA.
#Using `na.rm = TRUE` only removes the warning, but NAs are still ignored.

# 2. What happens to missing values in a bar chart? 
ggplot(diamonds2, aes(x = cut)) + 
  geom_bar()  # NA values appear as a separate category in bar charts

# Removing NA values from the bar chart
ggplot(diamonds2, aes(x = cut)) + 
  geom_bar(na.rm = TRUE)  # NA category is removed

# - Unlike histograms, bar charts explicitly show missing values as an "NA" category.
# - If `na.rm = TRUE` is not used, a separate "NA" bar appears.
# - If `na.rm = TRUE` is used, the "NA" category is completely removed.

#3. What does na.rm = TRUE do in mean() and sum()?
# again, i started it by creating a numeric vector with missing values
x <- c(1, 2, 3, NA, 5)

#Without na.rm = TRUE, functions return NA
mean(x) 
sum(x)   

# Using na.rm = TRUE ignores missing values
mean(x, na.rm = TRUE)  # Returns 2.75 
sum(x, na.rm = TRUE)   # Returns 11

# - `na.rm = TRUE` removes NA values before calculation, preventing NA results.

#4 Visualizing Flight Departure Times for Cancelled Flights
  flights %>%
  mutate(
    cancelled = is.na(dep_time),  # TRUE if dep_time is NA
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + (sched_min / 60)  # Convert to hours
  ) %>%
  ggplot(aes(x = sched_dep_time)) +
  geom_freqpoly(aes(color = cancelled), binwidth = 0.25) + 
  facet_wrap(~ cancelled, scales = "free_y")  # Separate plots for cancelled/non-cancelled flights

# - `cancelled = is.na(dep_time)` creates a new variable for cancellations.
# - `geom_freqpoly()` plots scheduled departure times, coloring by cancellations.
# - This will help analyze when cancellations occur most frequently.
  
#Exercices 10.5.1
    library(ggplot2)
  library(dplyr)
  library(forcats)
  library(lvplot)
#1 Improve visualization of departure times of cancelled vs. non-cancelled flights 
  flights %>%
    mutate(
      cancelled = is.na(dep_time),  # TRUE if flight was cancelled
      sched_hour = sched_dep_time %/% 100,
      sched_min = sched_dep_time %% 100,
      sched_dep_time = sched_hour + (sched_min / 60)  # Convert to decimal hours
    ) %>%
    ggplot(aes(x = sched_dep_time, fill = cancelled)) +
    geom_density(alpha = 0.5) + 
    facet_wrap(~ cancelled, scales = "free_y")  
  
#2. Which variable best predicts diamond price?
  #  Price vs. Carat 
  ggplot(diamonds, aes(x = carat, y = price)) + 
    geom_point(alpha = 0.3)
  
  #  Price vs. Cut (Boxplot visualization)
  ggplot(diamonds, aes(x = cut, y = price)) + 
    geom_boxplot()
  
  # Carat is the strongest predictor of price.
  # Cut affects price, but not as much as carat.Higher quality cuts are often cheaper since they are smaller.
  
#3. Compare coord_flip() vs. switching x and y in boxplots 
  ggplot(diamonds, aes(x = cut, y = price)) + 
    geom_boxplot() + 
    coord_flip()  # Flips x and y axes
  
  #coord_flip() rotates the plot, keeping the categorical variable readable.

#4. Using lvplot to reduce outliers in boxplots 
  ggplot(diamonds, aes(x = cut, y = price)) + 
    geom_lv()  
  
  #`geom_lv()` (Letter Value Plot) is better for large datasets.
  # Reduces clutter from excessive outliers.
  
#Exercices 10.5.2
  
#1 Rescale counts to show cut distribution within color 
    diamonds %>%
    count(color, cut) %>%
    group_by(color) %>%
    mutate(prop = n / sum(n)) %>%
    ggplot(aes(x = color, y = cut, fill = prop)) +
    geom_tile()
  
  #Instead of raw counts, we scale the counts to proportions.
  #Helps compare distributions across categories more effectively.
  
#2 Segmented bar chart (color mapped to x, cut mapped to fill) 
  ggplot(diamonds, aes(x = cut, fill = color)) +
    geom_bar(position = "fill")
  
#3 Flight delays by destination and month (Heatmap) 
    flights %>%
    filter(!is.na(dep_delay)) %>%
    group_by(dest, month) %>%
    summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
    ggplot(aes(x = factor(month), y = dest, fill = avg_delay)) +
    geom_tile()
  #Heatmaps help visualize delay patterns across months and destinations.
  #The darker the color, the higher the delay.

#Exercices 10.5.3

#1 Compare cut_width() vs. cut_number() for binning carat 
     ggplot(diamonds, aes(x = carat, y = price)) +
      geom_boxplot(aes(group = cut_width(carat, 0.1)))
    
    ggplot(diamonds, aes(x = carat, y = price)) +
      geom_boxplot(aes(group = cut_number(carat, 20)))  
    
    #`cut_width()` creates bins of fixed width
    #`cut_number()` creates bins with an equal number of observations.
    
#2 Visualize carat distribution partitioned by price 
    ggplot(diamonds, aes(x = carat, fill = cut)) +
      geom_histogram(binwidth = 0.1) +
      facet_wrap(~ price > 5000)
    
    # Faceting by price helps compare cheap vs. expensive diamonds.
    # Expensive diamonds tend to have larger carats.
    
#3. Price distribution of large vs. small diamonds 
    ggplot(diamonds, aes(x = price)) +
      geom_histogram(binwidth = 500) +
      facet_wrap(~ carat > 2)
    
    #Small diamonds are more common.
    #Large diamonds tend to be expensive but have fewer observations.
    
#4. Combine different techniques to visualize cut, carat, and price 
    ggplot(diamonds, aes(x = cut, y = price, fill = carat)) +
      geom_violin()  
    
    ggplot(diamonds, aes(x = price)) +
      geom_histogram(binwidth = 500, fill = "blue") +
      facet_wrap(~ cut)  
    
    ggplot(diamonds, aes(x = price, color = cut)) +
      geom_freqpoly(binwidth = 500) 
    
    ggplot(diamonds, aes(x = price, fill = cut)) +
      geom_density(alpha = 0.5)  
    
    # Violin plots show distribution per category.
    # Faceted histograms allow side-by-side comparison.
    # Frequency polygons work well for overlapping distributions.
    # Density plots give a smooth overview.
    
#5 Compare geom_jitter() with alternatives from ggbeeswarm 
    
    library(ggbeeswarm)
    
    ggplot(diamonds, aes(x = cut, y = price)) +
      geom_quasirandom()  # Jittering with controlled placement
    
    ggplot(diamonds, aes(x = cut, y = price)) +
      geom_beeswarm()  # Alternative beeswarm plot
    
    #`geom_quasirandom()` avoids excessive overlap in jittering.
    # `geom_beeswarm()` arranges points more naturally without overplotting.
    
    
  
  



