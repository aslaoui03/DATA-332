library(ggplot2)

# 9.2.1 Exercises

# Scatterplot with pink filled triangles
ggplot(mpg, aes(x = displ, y = hwy)) +
  
  geom_point(shape = 24, fill = "pink", color = "black", size = 3)
# Why the following code didn't produce blue points?
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, color = "blue"))
# Reason: "color" is treated as a categorical variable, not a color specification.

# Stroke aesthetic example
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(shape = 21, color = "black", fill = "blue", stroke = 2, size = 4)
# Stroke controls the border width of certain shapes (21-25).

# Mapping aesthetic to logical condition
ggplot(mpg, aes(x = displ, y = hwy, color = displ < 5)) +
  geom_point()
# Creates a logical factor (TRUE/FALSE) for coloring points.

# 9.3.1 Exercises

# Line chart
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_line()

# Boxplot
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot()

# Histogram
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2)

# Area chart
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_area(stat = "identity", fill = "blue", alpha = 0.5)

# Effect of show.legend = FALSE
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = FALSE)
# Removes the legend.

# Effect of se argument in geom_smooth()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(se = FALSE)
# Disables confidence interval shading.

# 9.4.1 Exercises

# Faceting on a continuous variable (not recommended)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~ cty)  # Not ideal; forces conversion to categorical.

# Empty cells in facet_grid(drv ~ cyl)
ggplot(mpg) +
  geom_point(aes(x = drv, y = cyl))
# Empty cells indicate no data for that combination.

# Using facet_grid() with dot notation
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)  # Facet by rows

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)  # Facet by columns

# Faceting vs. color aesthetic
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = factor(cyl)))

# Understanding facet_wrap nrow/ncol
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl, nrow = 2)
# facet_grid() lacks nrow/ncol because it follows strict row-column rules.

# Comparing engine size across drive trains
ggplot(mpg, aes(x = displ)) +
  geom_histogram(binwidth = 0.5) +
  facet_grid(drv ~ .)  # Rows better for comparison.

ggplot(mpg, aes(x = displ)) +
  geom_histogram(binwidth = 0.5) +
  facet_grid(. ~ drv)  # Columns.

# Converting facet_grid to facet_wrap
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ drv)
# Labels move to the top.

#Exercices 9.5.1 

library(ggplot2)
library(dplyr)

# 1. What is the default geom associated with stat_summary()?
# The default geom is geom_pointrange(). We can rewrite the plot using geom_pointrange()

ggplot(diamonds, aes(x = cut, y = depth)) + 
  geom_pointrange(stat = "summary", fun.min = min, fun.max = max, fun = median)

# 2. What does geom_col() do? How is it different from geom_bar()?
# geom_col() requires both x and y values, while geom_bar() calculates y (count) automatically.

  diamonds %>%
  count(cut) %>%
  ggplot(aes(x = cut, y = n)) +
  geom_col()

# 3. List of geom-stat pairs
# Common pairs: 
# - geom_bar() -> stat_count()
# - geom_col() -> stat_identity()
# - geom_smooth() -> stat_smooth()
# - geom_bin2d() -> stat_bin2d()
# - geom_boxplot() -> stat_boxplot()

# 4. What variables does stat_smooth() compute?
# It computes y (fitted values), ymin, and ymax for confidence intervals.

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()

# 5. Why do we need group = 1 in proportion bar charts?
# It ensures all values are treated as one group instead of breaking them into subgroups.

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar()

# 9.6.1 Exercices 

# 1. Problem with scatterplot: Overlapping points due to rounding
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_point()

# to fix this, we use position = "jitter" to spread points
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_jitter()

# 2. Difference between these plots? there is no difference.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

  ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity") # Default for geom_point()

# 3. Parameters controlling jitter
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_jitter(width = 0.2, height = 0.2) # Adjust jitter width/height

# 4. Compare geom_jitter() and geom_count()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_count() # Shows size differences for overlapping points

# 5. Default position adjustment for geom_boxplot()
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() # Default position = "dodge2"

#Exercices 9.7.1 

# 1. Turn stacked bar chart into pie chart using coord_polar()
ggplot(diamonds, aes(x = factor(1), fill = cut)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y")

# 2. Difference between coord_quickmap() and coord_map()
# coord_quickmap() is a fast approximation; coord_map() is more precise for projections.

library(maps)
nz <- map_data("nz")

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_map()

# 3. Relationship between city and highway MPG using coord_fixed()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() + 
  coord_fixed()

