# Load necessary packages
      install.packages("ggrepel")
      install.packages("scales")
      install.packages("hexbin")
      
      library(ggplot2)
      library(dplyr)
      library(ggrepel) 

# Exercise 11.2.1: Customizing Labels in a Scatterplot
# Creating a scatterplot of highway fuel efficiency vs. city fuel efficiency
#1: 
      ggplot(mpg, aes(x = cty, y = hwy, color = drv, shape = drv)) +
        geom_point(size = 3, alpha = 0.7) +  # Points with color and shape based on drivetrain
        geom_smooth(se = FALSE) +  # Adding a smooth trend line
        labs(
          title = "City vs. Highway Fuel Efficiency by Drivetrain",
          subtitle = "Different drive types exhibit distinct fuel efficiency patterns",
          x = "City Fuel Efficiency (mpg)",
          y = "Highway Fuel Efficiency (mpg)",
          color = "Drive Type",
          shape = "Drive Type",
          caption = "Data Source: fueleconomy.gov"
        ) +
        theme_minimal() 
  
  #2: recreating the same plot in the book 
      
      ggplot(mpg, aes(x = cty, y = hwy, color = drv, shape = drv)) +
        geom_point(size = 1.5) +  
        labs(
          title = "City vs. Highway MPG by Drive Type",
          x = "City MPG",
          y = "Highway MPG",
          color = "Type of \ndrive train",
          shape = "Type of \ndrive train"
        ) +
        theme_minimal() 

#3: Using a graphic from ch 10 and enhancing it using what i learned in this section

      ggplot(diamonds, aes(x = x)) + 
        geom_histogram(binwidth = 0.5, fill = "Blue", color = "Black") +
        labs(
          title = "Distribution of Diamond Length (x Dimension)",
          subtitle = "Histogram showing how diamond length is distributed",
          x = "Diamond Length (mm)",
          y = "Frequency",
          caption = "Data Source: diamonds dataset from ggplot2"
        ) +
        theme_classic()

# Exercise 11.3.1: Annotations
# (1) Use geom_text() to place text at the four corners

      ggplot(mpg, aes(x = displ, y = hwy)) +
        geom_point() +
        geom_text(aes(x = Inf, y = Inf, label = "Top Right"), hjust = 1, vjust = 1) +
        geom_text(aes(x = -Inf, y = Inf, label = "Top Left"), hjust = 0, vjust = 1) +
        geom_text(aes(x = Inf, y = -Inf, label = "Bottom Right"), hjust = 1, vjust = 0) +
        geom_text(aes(x = -Inf, y = -Inf, label = "Bottom Left"), hjust = 0, vjust = 0) +
        labs(
          title = "Text Labels at Plot Corners",
          x = "Engine Displacement (L)",
          y = "Highway Fuel Economy (mpg)"
        ) +
        theme_minimal()

# (2) Use annotate() to add a custom point in the middle of the plot

      ggplot(mpg, aes(x = displ, y = hwy)) +
        geom_point() +
        annotate(
          geom = "point", x = mean(mpg$displ), y = mean(mpg$hwy),
          color = "Red", size = 4, shape = 17
        )

# (3) Understanding Labels with Facets

      #When you use geom_text() with faceting, the data is split by the facets, 
      #so labels will be placed accordingly. 
      #To add a label to a single facet, we can filter the data for that facet 
      #To put a different label in each facet, we can include a variable in the label aesthetic thats different from other ones. 
      
      #Here's an example:
      ggplot(mpg, aes(x = displ, y = hwy)) +
        geom_point() +
        facet_wrap(~ drv) +
        geom_text(aes(label = paste(drv, "label")), data = mpg)


# (4) Appearance of geom_label() backgrounds

      #the arguments to geom_text() that control of the backgroud box are:
      #fill, color, label.size, and label.padding

# (5) Exploring the arrow() function in geom_segment()

      #The four arguments to arrow() are:
      # type, angle, length, ends


#Exercices 11.4.6

# Load extra libraries
library(scales)
library(hexbin) 

# (1) Why doesn’t the following code override the default scale?

      # The issue here is that geom_hex() uses fill instead of color.

# (2) What is the first argument to every scale? How does it compare to labs()?

      #scale_*() functions set both labels and other properties for a specific aesthetic (like color or axis). 
      #for example, scale_x_continuous(name = "Engine Size (L)") changes the x-axis label. 
      #however, labs() is a simpler function that only sets labels for multiple aesthetics, like labs(x = "Engine Size (L)", color = "Drive Type").

# (3) Customizing the Presidential Terms Visualization

      library(tibble)
      library(ggplot2)
      presidential_real <- tibble(
        start = as.Date(c("1953-01-20", "1961-01-20", "1963-11-22", "1969-01-20", "1974-08-09", "1977-01-20", 
                          "1981-01-20", "1989-01-20", "1993-01-20", "2001-01-20", "2009-01-20", "2017-01-20", "2021-01-20")),
        end = as.Date(c("1961-01-20", "1963-11-22", "1969-01-20", "1974-08-09", "1977-01-20", "1981-01-20", 
                        "1989-01-20", "1993-01-20", "2001-01-20", "2009-01-20", "2017-01-20", "2021-01-20", "2025-01-20")),
        id = seq(34, 46),
        president = c("Eisenhower", "Kennedy", "Johnson", "Nixon", "Ford", "Carter", "Reagan", "Bush Sr.", 
                      "Clinton", "Bush Jr.", "Obama", "Trump", "Biden"),
        party = c("Republican", "Democratic", "Democratic", "Republican", "Republican", "Democratic", "Republican", 
                  "Republican", "Democratic", "Republican", "Democratic", "Republican", "Democratic")
      )
      
      ggplot(presidential_real, aes(x = start, y = id, color = party)) +
        geom_point(size = 4) +
        geom_segment(aes(xend = end, yend = id), size = 2) +
        geom_text(aes(label = president), hjust = -0.1, vjust = 0.5, size = 4) +
        scale_color_manual(values = c(Republican = "#E81B23", Democratic = "#00AEF3")) +
        scale_x_date(name = "Year", breaks = seq(as.Date("1953-01-20"), as.Date("2025-01-20"), by = "4 years"), date_labels = "%Y") +
        scale_y_continuous(name = "President ID") +
        labs(
          title = "U.S. Presidential Terms (1953-2025)",
          subtitle = "Republicans in red, Democrats in blue",
          caption = "Source: U.S. Government"
        ) +
        theme_minimal()


# (4) Improving the legend with override.aes
        
        ggplot(diamonds, aes(x = carat, y = price)) +
          geom_point(aes(color = cut), alpha = 1/20) +
          guides(color = guide_legend(override.aes = list(size = 5, alpha = 1)))
        
#Exercices 11.5.1:
        install.packages("ggthemes")
        library(ggthemes)
        
        # Scatterplot with ggthemes and axis labels 
        ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
          geom_point() +
          labs(
            title = "Larger engine sizes tend to have lower fuel economy",
            caption = "Source: https://fueleconomy.gov."
          ) +
          theme_economist() +  # I used the economist theme here
          theme(
            axis.title.x = element_text(color = "blue", face = "bold"),  
            axis.title.y = element_text(color = "blue", face = "bold")   
          )
  
  