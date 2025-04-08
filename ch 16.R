#Chapter 16
#Exercices 16.3.1
#1)
library(tidyverse)
library(forcats)

# Basic bar chart
ggplot(gss_cat, aes(x = rincome)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90))
# this is a way to improve this for better readability
gss_cat %>%
  mutate(rincome = fct_infreq(rincome)) %>%
  ggplot(aes(x = rincome)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Distribution of Reported Income", x = "Income Level", y = "Count")

#2)
gss_cat %>%
  count(relig, sort = TRUE)
# The most common relig is Protestant 

gss_cat %>%
  count(partyid, sort = TRUE)
#The most common partyid is Independent or it could be not str democrat dpeending
#on how levels are worded

#3) 
#using a table
gss_cat %>%
  count(relig, denom) %>%
  filter(n > 0) %>%
  arrange(desc(n))

#using visualization
gss_cat %>%
  filter(!is.na(denom)) %>%
  ggplot(aes(x = denom, fill = relig)) +
  geom_bar() +
  coord_flip()
#so it looks like the variable denom applies speciically to people who
#identified as Protestant in the relig column

#Exercises 16.4.1
#1) 
gss_cat %>%
  count(tvhours) %>%
  arrange(desc(tvhours))
summary(gss_cat$tvhours)

#The mean is not a good summary because for people who say i watch tv all day 
#it gives 24 hours of watching tv which is an outlier. it misrepredent the tendency
#of how much people watch tv per day.

#2) 
#Arbitrary: marital, race, partyid, relig, denom
#Principled: rincome (income bands increase in value)
#Not a Factor: tvhours, year, age (because its numeric)

#3) 
gss_cat |>
  group_by(rincome) |>
  summarize(
    age = mean(age, na.rm = TRUE),
    n = n()
  ) |>
  mutate(rincome = fct_relevel(rincome, "Not applicable")) |>
  ggplot(aes(x = age, y = rincome)) +
  geom_point()
#because in ggplot2, when a factor is mapped to the y-axis, 
#the first level appears at the bottom and levels increase upward.
level(fct_relevel(gss_cat$rincome, "Not applicable"))


#Exercises 16.5.1
#1) 
#We’ll use fct_collapse() to group partyid into 3 major political identities
#and then visualize the change over the year.

library(tidyverse)
library(forcats)

gss_cat |>
  mutate(partyid = fct_collapse(partyid,
  "Democrat"    = c("Strong democrat", "Not str democrat"),
  "Republican"  = c("Strong republican", "Not str republican"),
  "Independent" = c("Ind,near rep", "Independent", "Ind,near dem")
  )) |>
  group_by(year, partyid) |>
  summarize(n = n()) |>
  group_by(year) |>
  mutate(prop = n / sum(n)) |>
  ggplot(aes(x = year, y = prop, color = partyid)) +
  geom_line(size = 1.2) +
  labs(
    title = "Trends in Political Identity Over Time",
    x = "Year",
    y = "Proportion",
    color = "Party ID"
  ) +
  theme_minimal()
#Over time, the proportion of Independents has increased, while Democrats and Republicans have remained relatively stable,
#indicating a growing preference for political independence.

#2)
#we can do that by grouping similar categories using fct_collapse()
gss_cat |>
  mutate(rincome = fct_collapse(rincome,
  "Under $10k"     = c("Lt $1000", "$1000 to 2999", "$3000 to 3999", "$4000 to 4999", "$5000 to 5999", "$6000 to 6999", "$7000 to 7999", "$8000 to 9999"),
  "$10k–$25k"      = c("$10000 - 14999", "$15000 - 19999", "$20000 - 24999"),
  "$25k–$50k"      = c("$25000 or more", "$25000 - 29999", "$30000 - 34999", "$35000 - 39999", "$40000 - 49999"),
  "$50k+"          = c("$50000 - 59999", "$60000 - 74999", "$75000 or more"),
  "Not reported"   = c("Refused", "Don't know", "No answer", "Not applicable")
  )) |>
  count(rincome, sort = TRUE)
#we can then visualize it by 
ggplot(gss_cat, aes(x = rincome)) +
  geom_bar(fill = "steelblue") +
  coord_flip() +
  labs(title = "Collapsed Income Categories", x = "Income Bracket", y = "Count") +
  theme_minimal()

#3) 
#Even though fct_lump_n(relig, n = 10) is called, the 10th group is assigned to "Other" by default.
#So technically we are getting 9 categories and 1 other
?fct_lump_n
other_level = "Other"

